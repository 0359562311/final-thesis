import 'package:fakeslink/app/model/entities/transaction.dart';
import 'package:fakeslink/app/viewmodel/home/home_tab/home_cubit.dart';
import 'package:fakeslink/app/viewmodel/transaction/detail/transaction_detail_state.dart';
import 'package:fakeslink/app/viewmodel/transaction/detail/transaction_detail_viewmodel.dart';
import 'package:fakeslink/core/custom_widgets/loading_widget.dart';
import 'package:fakeslink/core/utils/extensions/num.dart';
import 'package:fakeslink/core/utils/extensions/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fakeslink/core/const/app_colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TransactionDetail extends StatefulWidget {
  final int transactionId;
  const TransactionDetail({Key? key, required this.transactionId})
      : super(key: key);

  @override
  State<TransactionDetail> createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  late final TransactionDetailViewModel _viewModel;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _viewModel = TransactionDetailViewModel();
    _viewModel.init(widget.transactionId);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            child: const Icon(Icons.done),
            onTap: () {
              if (_viewModel.state.data?.status ==
                      TransactionStatus.Pending.name &&
                  (_viewModel.state.data?.deposit != null ||
                      _viewModel.state.data?.withdraw != null)) {
                _viewModel.done(true);
              }
            },
          ),
          InkWell(
            child: const Icon(Icons.cancel_outlined),
            onTap: () {
              if (_viewModel.state.data?.status ==
                      TransactionStatus.Pending.name &&
                  (_viewModel.state.data?.deposit != null ||
                      _viewModel.state.data?.withdraw != null)) {
                _viewModel.done(false);
              }
            },
          ),
        ],
        centerTitle: true,
        backgroundColor: AppColor.white,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: AppColor.black),
        elevation: 0,
        title: Text(
          "Chi tiết giao dịch",
          style: GoogleFonts.montserrat(
              color: AppColor.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () {
          _viewModel.init(widget.transactionId);
        },
        child: BlocConsumer<TransactionDetailViewModel, TransactionDetailState>(
          bloc: _viewModel,
          listener: (context, state) {
            if (state.status == TransactionDetailStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Đã có lỗi xảy ra")));
            } else {
              _refreshController.refreshCompleted();
            }
          },
          builder: (context, state) {
            if (state.status == TransactionDetailStatus.loading) {
              return const LoadingWidget();
            }
            if (state.data?.deposit != null) {
              return _buildPendingDeposit(context);
            }
            if (state.data?.withdraw != null) {
              return _buildWithDraw();
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildWithDraw() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.yellow[100],
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.support_agent,
                  size: 30, color: AppColor.primaryColor),
              const SizedBox(
                width: 8,
              ),
              const Expanded(
                child: Text("Giao dịch sẽ cần 1 khoảng thời gian để hoàn tất."),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(color: AppColor.white),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                const Text("Tên ngân hàng:"),
                const Spacer(),
                Text(
                  "${_viewModel.state.data?.withdraw?.userBankAccount?.bank?.name}",
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text("Số tài khoản:"),
                const Spacer(),
                Text(
                  "${_viewModel.state.data?.withdraw?.userBankAccount?.accountNumber}",
                  style: GoogleFonts.montserrat(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text("Chủ tài khoản:"),
                const Spacer(),
                Text(
                  "${_viewModel.state.data?.withdraw?.userBankAccount?.owner}",
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text("Số tiền:"),
                const Spacer(),
                Text(
                  "${(_viewModel.state.data?.amount ?? 0).price} VND",
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            if (_viewModel.state.data?.status ==
                TransactionStatus.Success.name) ...[
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text("Cập nhật vào lúc:"),
                  const Spacer(),
                  Text(
                    _viewModel.state.data?.updatedAt?.date ?? "",
                    style: GoogleFonts.montserrat(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ]),
        ),
      ],
    );
  }

  Column _buildPendingDeposit(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: _viewModel.state.data?.deposit != null &&
              _viewModel.state.data?.status == TransactionStatus.Pending,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.support_agent,
                    size: 30, color: AppColor.primaryColor),
                const SizedBox(
                  width: 8,
                ),
                const Expanded(
                  child: Text(
                      "Để hoàn thành giao dịch, quý khách vui lòng chuyển khoản ngân hàng vào tài khoản dưới đây. Mọi thắc mắc vui lòng xin liên hệ đường dây nóng chăm sóc khách hàng"),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(color: AppColor.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text("Tên ngân hàng:"),
                  const Spacer(),
                  Text(
                    "Tiên Phong Bank (TPBank)",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text("Số tài khoản:"),
                  const Spacer(),
                  Text(
                    "04323662178",
                    style: GoogleFonts.montserrat(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(
                              const ClipboardData(text: "04323662178"))
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Đã copy vào bộ nhớ đệm.")));
                      });
                    },
                    child: const Icon(
                      Icons.copy,
                      size: 18,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text("Chủ tài khoản:"),
                  const Spacer(),
                  Text(
                    "NGUYEN KIEM TAN",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text("Số tiền:"),
                  const Spacer(),
                  Text(
                    "${(_viewModel.state.data?.amount ?? 0).price} VND",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text("Nội dung khoản:"),
                  const Spacer(),
                  Text(
                    _viewModel.state.data?.deposit?.detail ?? "",
                    style: GoogleFonts.montserrat(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(
                              text:
                                  _viewModel.state.data?.deposit?.detail ?? ""))
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Đã copy vào bộ nhớ đệm.")));
                      });
                    },
                    child: const Icon(
                      Icons.copy,
                      size: 18,
                    ),
                  )
                ],
              ),
              if (_viewModel.state.data?.status ==
                  TransactionStatus.Pending.name) ...[
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Nhập chính xác nội dung chuyển khoản để hệ thống có thể nạp đúng vào tài khoản của bạn.",
                  style: GoogleFonts.montserrat(color: AppColor.secondaryColor),
                )
              ],
              if (_viewModel.state.data?.status ==
                  TransactionStatus.Success.name) ...[
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const Text("Cập nhật vào lúc:"),
                    const Spacer(),
                    Text(
                      _viewModel.state.data?.updatedAt?.date ?? "",
                      style: GoogleFonts.montserrat(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
              if (_viewModel.state.data?.status ==
                  TransactionStatus.Pending.name) ...[
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const Text("Hết hạn vào:"),
                    const Spacer(),
                    Text(
                      _viewModel.state.data?.deposit?.dueDate?.date ?? "",
                      style: GoogleFonts.montserrat(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ]
            ],
          ),
        ),
      ],
    );
  }
}
