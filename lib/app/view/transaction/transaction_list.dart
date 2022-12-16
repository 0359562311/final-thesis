import 'package:fakeslink/app/model/entities/transaction.dart';
import 'package:fakeslink/app/viewmodel/transaction/list/transaction_list_state.dart';
import 'package:fakeslink/app/viewmodel/transaction/list/transaction_list_viewmodel.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/const/app_routes.dart';
import 'package:fakeslink/core/custom_widgets/loading_widget.dart';
import 'package:fakeslink/core/utils/extensions/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TransactionListPage extends StatefulWidget {
  const TransactionListPage({Key? key}) : super(key: key);

  @override
  State<TransactionListPage> createState() => _TransactionListPageState();
}

class _TransactionListPageState extends State<TransactionListPage> {
  late final RefreshController _refreshController;
  late final TransactionListViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    _viewModel = TransactionListViewModel();
    _viewModel.getTransaction(true);
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
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        elevation: 3,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: AppColor.white),
        title: Text(
          "Giao dịch",
          style: GoogleFonts.montserrat(
              color: AppColor.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<TransactionListViewModel, TransactionListState>(
        bloc: _viewModel,
        listener: (context, state) {
          if (state.status == TransactionListStatus.error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Đã có lỗi xảy ra")));
          }
          if (state.status != TransactionListStatus.loading) {
            _refreshController.refreshCompleted();
            _refreshController.loadComplete();
          }
        },
        builder: (context, state) {
          if (state.status == TransactionListStatus.loading &&
              state.data.isEmpty) {
            return LoadingWidget();
          }
          return SmartRefresher(
            controller: _refreshController,
            enablePullUp: state.hasMore,
            onLoading: () {
              _viewModel.getTransaction();
            },
            onRefresh: () {
              _viewModel.getTransaction(true);
            },
            child: ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final data = state.data[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.transactionDetail,
                        arguments: data.id);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _getStatus(data),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              data.type,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              data.zAmount,
                              style: GoogleFonts.montserrat(
                                  color: data.zAmount.startsWith("-")
                                      ? AppColor.red
                                      : Colors.green),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              data.createAt?.date ?? "",
                              style: GoogleFonts.montserrat(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _getStatus(Transaction tran) {
    var data = Icons.pending;
    Color color = Colors.yellow;
    if (tran.status == TransactionStatus.Success.name) {
      data = Icons.done_rounded;
      color = Colors.green[300]!;
    } else if (tran.status == TransactionStatus.Failed.name) {
      data = Icons.cancel;
      color = AppColor.red;
    }
    return Icon(
      data,
      size: 24,
      color: color,
    );
  }
}
