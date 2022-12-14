import 'package:fakeslink/app/view/home_page/home.dart';
import 'package:fakeslink/app/view/verify_password/verify_password.dart';
import 'package:fakeslink/app/viewmodel/all_offers/all_offers_cubit.dart';
import 'package:fakeslink/app/viewmodel/all_offers/all_offers_state.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/custom_widgets/button_widget.dart';
import 'package:fakeslink/core/custom_widgets/circle_avatar_widget.dart';
import 'package:fakeslink/core/custom_widgets/custom_appbar.dart';
import 'package:fakeslink/core/utils/extensions/string.dart';
import 'package:fakeslink/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

enum Status { Approved, Pending, Payed }

class AllOfferPage extends StatefulWidget {
  final int? jobId;

  const AllOfferPage({Key? key, this.jobId}) : super(key: key);

  @override
  State<AllOfferPage> createState() => _AllOfferPageState();
}

class _AllOfferPageState extends State<AllOfferPage> {
  late AllOffersViewModel _cubit;
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _evaluateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = AllOffersViewModel();
    _cubit.getAllOffer(jobId: widget.jobId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: appBar(context, "All Offers",
          textColor: AppColor.primaryColor,
          elevation: 1,
          centerTitle: true,
          iconColor: AppColor.primaryColor),
      body: BlocConsumer<AllOffersViewModel, AllOffersState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state.status == AllOfferStatus.acceptSuccess) {
            Navigator.pop(context);
          }
          if (state.status == AllOfferStatus.paySuccess) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                        "B???n c?? mu???n ????nh gi?? ng?????i nh???n vi???c n??y kh??ng?",
                        style: GoogleFonts.montserrat(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const HomePage()));
                        },
                        child: Text(
                          "Kh??ng",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: AppColor.black),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SingleChildScrollView(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: RatingBar.builder(
                                            itemSize: 40,
                                            initialRating: 5,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 2.0),
                                            itemBuilder: (context, index) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            ),
                                            onRatingUpdate: (value) {
                                              setState(() {
                                                _cubit.changeRating(
                                                    value.toInt());
                                              });
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        TextField(
                                          controller: _evaluateController,
                                          decoration: const InputDecoration(
                                              hintText: "Chi ti???t"),
                                        ),
                                        const SizedBox(height: 10),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: SizedBox(
                                            width: 100,
                                            child: ButtonWidget(
                                              title: "????nh gi??",
                                              uppercaseTitle: false,
                                              onPressed: () {
                                                Navigator.pop(context);
                                                _cubit.review(
                                                    transactionId: _cubit
                                                        .state.transaction?.id,
                                                    rating: _cubit.rating,
                                                    detail: _evaluateController
                                                        .text,
                                                    jobId: state.jobId);
                                              },
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Text(
                          "Ok",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.red),
                        ),
                      )
                    ],
                  );
                });
          }
          if (state.status == AllOfferStatus.reviewSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state.status == AllOfferStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return CustomScrollView(
            shrinkWrap: true,
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(height: 10),
              ),
              if (_cubit.state.offers?.isEmpty ?? false)
                SliverToBoxAdapter(
                  child: Center(
                      heightFactor: 20,
                      child: Text(
                        "Kh??ng c?? ch??o gi?? n??o!",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColor.primaryColor),
                      )),
                ),
              if (_cubit.state.offers?.isNotEmpty ?? false)
                SliverPadding(
                  sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    final data = _cubit.state.offers?[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AvatarWidget(
                                  avatar: data?.user?.avatar ?? "", size: 40),
                              Expanded(
                                child: Text(
                                  data?.user?.name ?? "",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                              Text(
                                (Utils.formatMoney(data?.price) ?? "") + " VND",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            data?.description ?? "",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              if (data?.user?.createAt != null)
                                Expanded(
                                  child: Text(
                                    data?.user?.updateAt?.date ?? "",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                ),
                              const SizedBox(width: 5),
                              Visibility(
                                visible: data?.status == Status.Pending.name,
                                child: Container(
                                  constraints: const BoxConstraints(
                                      minWidth: 70, maxWidth: 100),
                                  child: ButtonWidget(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 3),
                                      title: "Ch???p nh???n",
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                  'Tr???ng th??i c??ng vi???c',
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16),
                                                ),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      Text(
                                                        'B???n c?? mu???n chuy???n tr???ng th??i c??ng vi???c ????? t???m  th???i kh??ng nh???n c??c ch??o gi?? n???a kh??ng?',
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "Kh??ng",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      _cubit.accept(
                                                          offerId: data!.id!,
                                                          jobId: widget.jobId!);
                                                    },
                                                    child: Text(
                                                      "C??",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.red),
                                                    ),
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                      textSize: 14,
                                      uppercaseTitle: false),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Visibility(
                                visible: data?.status == Status.Payed.name,
                                child: SizedBox(
                                  width: 120,
                                  child: ButtonWidget(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 3),
                                      title: "???? thanh to??n",
                                      onPressed: () {},
                                      textSize: 14,
                                      uppercaseTitle: false),
                                ),
                              ),
                              Visibility(
                                visible: data?.status == Status.Approved.name,
                                child: SizedBox(
                                  width: 120,
                                  child: ButtonWidget(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 3),
                                      title: "Thanh to??n",
                                      onPressed: () async {
                                        await buildPay(context, index);
                                      },
                                      textSize: 14,
                                      uppercaseTitle: false),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }, childCount: _cubit.state.offers?.length)),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                )
            ],
          );
        },
      ),
    );
  }

  buildPay(BuildContext context, int index) async {
    showDialog(
        context: context,
        builder: (contextT) {
          return AlertDialog(
            title: Text(
              "B???n c?? mu???n thanh to??n cho ng?????i d??ng n??y kh??ng?",
              style: GoogleFonts.montserrat(
                  fontSize: 14, fontWeight: FontWeight.w600),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(contextT);
                },
                child: Text("Kh??ng",
                    style: GoogleFonts.montserrat(
                        fontSize: 14, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(contextT);
                  final res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const VerifyPasswordPage()));
                  if (res == true) {
                    if (_cubit.state.offers?[index].job?.payment?.paymentMethod
                            ?.id ==
                        2) {
                      await showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SingleChildScrollView(
                              padding: MediaQuery.of(context).viewInsets,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: _textEditingController,
                                      decoration: const InputDecoration(
                                          hintText: "Nh???p s??? gi??? l??m"),
                                    ),
                                    const SizedBox(height: 15),
                                    ButtonWidget(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        backgroundColor: AppColor.primaryColor,
                                        title: "Thanh to??n",
                                        onPressed: () {
                                          Navigator.pop(context);
                                          showDialog(
                                              context: context,
                                              builder: (contextDia) {
                                                return AlertDialog(
                                                  title: Text(
                                                    "B???n c?? mu???n thanh to??n ${priceOffer(_cubit.state.offers?[index].job?.payment?.amount ?? 0, int.parse(_textEditingController.text))} VND kh??ng?",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16),
                                                  ),
                                                  actions: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(
                                                            contextDia);
                                                        _cubit.pay(
                                                            jobId: _cubit
                                                                .state
                                                                .offers?[index]
                                                                .job
                                                                ?.id,
                                                            offerId: _cubit
                                                                .state
                                                                .offers?[index]
                                                                .id,
                                                            hours: int.parse(
                                                                _textEditingController
                                                                    .text));
                                                      },
                                                      child: Text(
                                                        "Ok",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 16,
                                                                color:
                                                                    Colors.red),
                                                      ),
                                                    )
                                                  ],
                                                );
                                              });
                                        }),
                                    const SizedBox(height: 15),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                  "B???n c?? mu???n thanh to??n ${_cubit.state.offers?[index].price} VND kh??ng?",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                              actions: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    _cubit.pay(
                                        jobId:
                                            _cubit.state.offers?[index].job?.id,
                                        offerId:
                                            _cubit.state.offers?[index].id);
                                  },
                                  child: Text(
                                    "Ok",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.red),
                                  ),
                                )
                              ],
                            );
                          });
                    }
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                                "M???t kh???u kh??ng ch??nh x??c, vui l??ng nh???p l???i ????? c?? th??? thanh to??n",
                                style: GoogleFonts.montserrat(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                            actions: [
                              const Text("???? hi???u"),
                            ],
                          );
                        });
                  }
                },
                child: Text("C??",
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.red)),
              )
            ],
          );
        });
  }

  int? priceOffer(int price, int hours) {
    final int priceOffer;
    priceOffer = price * hours;
    return priceOffer;
  }
}
