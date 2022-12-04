import 'dart:io';

import 'package:fakeslink/app/viewmodel/create_job/create_job_cubit.dart';
import 'package:fakeslink/app/viewmodel/create_job/create_job_state.dart';
import 'package:fakeslink/core/const/app_colors.dart';
import 'package:fakeslink/core/custom_widgets/button_widget.dart';
import 'package:fakeslink/core/custom_widgets/custom_appbar.dart';
import 'package:fakeslink/core/custom_widgets/text_field_widget.dart';
import 'package:fakeslink/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

typedef OnTab = void Function(int index);

class CreateJobPage extends StatefulWidget {
  const CreateJobPage({Key? key}) : super(key: key);

  @override
  State<CreateJobPage> createState() => _CreateJobPageState();
}

class _CreateJobPageState extends State<CreateJobPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  late CreateJobCubit _cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = CreateJobCubit();
    _cubit.getCity();
    _cubit.getCategory();
    _cubit.getPayment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Tạo công việc",
          backgroundColor: const Color(0xFF4E43BD),
          centerTitle: true,
          iconColor: AppColor.white),
      body: BlocConsumer<CreateJobCubit, CreateJobState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state.status == CreateJobStatus.createJobSuccess) {
            Navigator.of(context).pop();
            Utils.showSnackBar(context, "Đăng tìm việc làm thành công");
          }
        },
        builder: (context, state) {
          if (state.status == CreateJobStatus.loading) {
            return CircularProgressIndicator();
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Tiêu đề",
                  style: GoogleFonts.montserrat(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                const SizedBox(height: 10),
                TextFieldWidget(
                  controller: _titleController,
                  hintText: "Tiêu đề",
                  isEnable: true,
                  fillColor: Colors.grey.shade200,
                  maxLines: 1,
                  autoFocus: false,
                ),
                const SizedBox(height: 15),
                Text(
                  "Loại công việc",
                  style: GoogleFonts.montserrat(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(
                      _cubit.state.category?.length ?? 0,
                      (index) => GestureDetector(
                            onTap: () {
                              _cubit.selectedCategory(
                                  _cubit.state.category?[index].id ?? 0);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                  color: _cubit.listCategory.contains(
                                          _cubit.state.category?[index].id)
                                      ? AppColor.primaryColor.withOpacity(0.3)
                                      : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                _cubit.state.category?[index].name ?? "",
                                style: GoogleFonts.montserrat(
                                    color: AppColor.primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      "Chọn địa chỉ",
                      style: GoogleFonts.montserrat(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    Spacer(),
                    Checkbox(
                        value: _cubit.isRemoteJob,
                        fillColor:
                            MaterialStateProperty.all(AppColor.primaryColor),
                        onChanged: (value) {
                          _cubit.changeRemote(value ?? false);
                        }),
                    Text(
                      "Việc từ xa",
                      style: GoogleFonts.montserrat(
                          color: _cubit.isRemoteJob
                              ? AppColor.primaryColor
                              : null),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                if (!_cubit.isRemoteJob) ...[
                  GestureDetector(
                    onTap: () {
                      _cubit.districtName = null;
                      _cubit.wardName = null;
                      buildSelectedAddress(context, callBack: (index) {
                        Navigator.pop(context);
                        _cubit.selectedCity(
                            name: _cubit.cities[index]['name'],
                            code: _cubit.cities[index]['code']);
                      }, list: _cubit.cities);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.primaryColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  _cubit.cityName ?? "Chọn tỉnh/ thành phố")),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: AppColor.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      _cubit.wardName = null;
                      buildSelectedAddress(context, list: _cubit.districts,
                          callBack: (index) {
                        Navigator.pop(context);
                        _cubit.selectedDistrict(
                            name: _cubit.districts[index]['name_with_type'],
                            code: _cubit.districts[index]['code']);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.primaryColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  _cubit.districtName ?? "Chọn quận/ huyện")),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: AppColor.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      buildSelectedAddress(context, callBack: (index) {
                        Navigator.pop(context);
                        _cubit.selectedWard(
                            name: _cubit.ward[index]['name_with_type']);
                      }, list: _cubit.ward);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.primaryColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Expanded(
                              child:
                                  Text(_cubit.wardName ?? "Chọn phường/ xã")),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: AppColor.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFieldWidget(
                    controller: _locationController,
                    hintText: "Địa chỉ cụ thể",
                    isEnable: true,
                    fillColor: Colors.grey.shade200,
                    maxLines: 1,
                    autoFocus: false,
                  ),
                  const SizedBox(height: 10),
                ],
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Thời gian kết thúc \n(tối đa 30 ngày kể từ ngày đăng việc)",
                        style: GoogleFonts.montserrat(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100));
                        if (pickedDate != null) {
                          final dif = pickedDate.difference(DateTime.now());
                          if (dif.inDays <= 30 && dif.inDays >= 0) {
                            _cubit.selectDueDate(pickedDate);
                          }
                        }
                      },
                      child: Container(
                        width: 120,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade300)),
                        child: Text(
                          _cubit.dueDate == null
                              ? "... /... /..."
                              : DateFormat('yyyy-MM-dd')
                                  .format(_cubit.dueDate!)
                                  .toString(),
                          style: GoogleFonts.montserrat(
                            color: AppColor.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Mô tả",
                  style: GoogleFonts.montserrat(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                const SizedBox(height: 10),
                TextFieldWidget(
                  controller: _descriptionController,
                  autoFocus: false,
                  isEnable: true,
                  fillColor: Colors.grey.shade200,
                  maxLines: 10,
                  hintText: "Mô tả công việc",
                ),
                const SizedBox(height: 10),
                Text(
                  "Hình ảnh/ Video",
                  style: GoogleFonts.montserrat(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _cubit.selectImages();
                      },
                      child: Container(
                        height: 60,
                        width: 70,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(Icons.add),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              _cubit.imageFileList?.length ?? 0,
                              (index) => Container(
                                    height: 60,
                                    width: 70,
                                    margin: EdgeInsets.only(right: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Image.file(
                                      File(_cubit.imageFileList![index].path),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Thanh toán",
                  style: GoogleFonts.montserrat(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                        ),
                        builder: (context) {
                          return IntrinsicHeight(
                            child: Column(
                              children: List.generate(
                                  state.payment?.length ?? 0, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    _cubit.selectPaymentMethod(
                                        name: _cubit
                                                .state.payment?[index].title ??
                                            "",
                                        paymentMethodId:
                                            _cubit.state.payment?[index].id ??
                                                0);
                                  },
                                  child: ListTile(
                                    title: Text(
                                      _cubit.state.payment?[index].title ?? "",
                                      style: GoogleFonts.montserrat(
                                          color: AppColor.primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Text(
                                      _cubit.state.payment?[index]
                                              .description ??
                                          "",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          );
                        });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.primaryColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          _cubit.paymentMethodName ?? "Phương thức thanh toán",
                          style: GoogleFonts.montserrat(
                              color: Colors.black, fontSize: 14),
                        )),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: AppColor.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  color: Colors.grey.shade200,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFieldWidget(
                          controller: _priceController,
                          autoFocus: false,
                          fillColor: Colors.grey.shade200,
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          hintText: "Nhập giá công việc",
                        ),
                      ),
                      Text("VND",
                          style: GoogleFonts.montserrat(
                              color: Colors.black, fontSize: 14))
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Expanded(
                      child: ButtonWidget(
                    title: "Đăng",
                    uppercaseTitle: false,
                    onPressed: () {
                      _cubit.createJob(
                          title: _titleController.text.trim(),
                          city: _cubit.cityName,
                          district: _cubit.districtName,
                          ward: _cubit.wardName,
                          detail: _locationController.text.trim(),
                          description: _descriptionController.text.trim(),
                          price: _priceController.text.trim(),
                          paymentMethod: _cubit.paymentId);
                    },
                    radius: 5,
                  )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> buildSelectedAddress(BuildContext context,
      {List<dynamic>? list, required OnTab callBack}) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        builder: (context) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5, top: 5),
                child: Align(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.close)),
                  alignment: Alignment.centerRight,
                ),
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: list?.length ?? 0,
                  itemBuilder: (context, int index) {
                    return GestureDetector(
                      onTap: () {
                        callBack(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, bottom: 10, top: 10),
                        child: Text(
                          list?[index]['name_with_type'],
                          style: GoogleFonts.montserrat(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 1,
                      color: Colors.grey.shade200,
                    );
                  },
                ),
              ),
            ],
          );
        });
  }
}
