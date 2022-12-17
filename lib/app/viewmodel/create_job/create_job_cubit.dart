import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fakeslink/app/model/repositories/job_repository.dart';
import 'package:fakeslink/app/model/request/create_job_request.dart';
import 'package:fakeslink/app/viewmodel/create_job/create_job_state.dart';
import 'package:fakeslink/core/utils/storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CreateJobCubit extends Cubit<CreateJobState> {
  final JobRepository _jobRepository = JobRepositoryImpl();

  CreateJobCubit() : super(CreateJobState(status: CreateJobStatus.loading));
  List<dynamic> cities = [];
  List<dynamic> districts = [];
  List<dynamic> ward = [];
  String? cityName;
  String? codeCity;
  String? districtName;
  String? codeDistrict;
  String? wardName;
  String? paymentMethodName;
  int? paymentId;
  List<XFile>? selectedImages = [];
  bool isRemoteJob = false;

  DateTime? dueDate;

  List<int> listCategory = [];

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  void getCity() async {
    try {
      emit(state.copyWith(
        status: CreateJobStatus.loading,
      ));
      String response = await rootBundle.loadString('assets/json/city.json');
      var data = await json.decode(response);
      data = data as Map;
      data.forEach((key, value) {
        cities.add(value);
      });
      emit(state.copyWith(
        status: CreateJobStatus.success,
      ));
    } catch (e) {}
  }

  void getDistrict({String? codeD}) async {
    try {
      emit(state.copyWith(status: CreateJobStatus.loading));
      final response = await rootBundle.loadString('assets/json/district.json');
      var data = json.decode(response);
      (data as Map).forEach((key, value) {
        if (codeD == value['parent_code']) {
          districts.add(value);
        }
      });
      emit(state.copyWith(
        status: CreateJobStatus.success,
      ));
    } catch (e) {}
  }

  void getWard({String? codeW}) async {
    try {
      final response =
          await rootBundle.loadString('assets/json/xa-phuong/$codeW.json');
      var data = json.decode(response);
      (data as Map).forEach((key, value) {
        ward.add(value);
      });
      emit(state.copyWith(
        status: CreateJobStatus.success,
      ));
    } catch (e) {}
  }

  void selectedCity({String? name, String? code}) {
    emit(state.copyWith(
      status: CreateJobStatus.loading,
    ));
    districts.clear();
    cityName = name;
    codeCity = code;
    emit(state.copyWith(
        status: CreateJobStatus.success, category: state.category));
    getDistrict(codeD: codeCity);
  }

  void selectedDistrict({String? name, String? code}) {
    emit(state.copyWith(
      status: CreateJobStatus.loading,
    ));
    ward.clear();
    districtName = name;
    codeDistrict = code;
    emit(state.copyWith(
      status: CreateJobStatus.success,
    ));
    getWard(codeW: codeDistrict);
  }

  void selectedWard({String? name}) {
    emit(state.copyWith(
      status: CreateJobStatus.loading,
    ));
    wardName = name;
    emit(state.copyWith(
      status: CreateJobStatus.success,
    ));
  }

  void selectImages() async {
    emit(state.copyWith(
      status: CreateJobStatus.loading,
    ));
    selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages!);
    }
    emit(state.copyWith(
      status: CreateJobStatus.updateImageSuccess,
    ));
  }

  void getCategory() {
    emit(state.copyWith(
        status: CreateJobStatus.loading, category: state.category));
    _jobRepository.getCategory().then((value) {
      emit(state.copyWith(
        status: CreateJobStatus.success,
        category: value,
      ));
    }).catchError((onError) {
      emit(state.copyWith(
          category: state.category, status: CreateJobStatus.error));
    });
  }

  void selectedCategory(int id) {
    emit(state.copyWith(
      status: CreateJobStatus.loading,
    ));
    if (listCategory.contains(id)) {
      listCategory.remove(id);
    } else {
      listCategory.add(id);
    }
    emit(state.copyWith(
      status: CreateJobStatus.success,
    ));
  }

  void changeRemote(bool value) {
    isRemoteJob = value;
    emit(state.copyWith(status: CreateJobStatus.success));
  }

  void getPayment() {
    try {
      emit(state.copyWith(
        status: CreateJobStatus.loading,
      ));
      _jobRepository.getPayment().then((value) {
        emit(state.copyWith(
          status: CreateJobStatus.success,
          payment: value,
        ));
      });
    } catch (e) {}
  }

  void selectPaymentMethod({String? name, int? paymentMethodId}) {
    emit(state.copyWith(
      status: CreateJobStatus.success,
    ));
    paymentMethodName = name;
    paymentId = paymentMethodId;
  }

  void createJob(
      {String? description,
      String? title,
      String? city,
      String? district,
      String? ward,
      String? detail,
      String? price,
      int? paymentMethod}) async {
    try {
      emit(state.copyWith(
          status: CreateJobStatus.loading, category: state.category));
      final images = await Future.wait((imageFileList ?? [])
          .map((e) => StorageService.uploadFile(File(e.path)))
          .toList());
      _jobRepository
          .createJob(CreteJobRequest(
              description: description,
              title: title,
              address: isRemoteJob
                  ? null
                  : Address(
                      city: city,
                      district: district,
                      ward: ward,
                      detail: detail),
              categories: listCategory,
              dueDate: (dueDate?.millisecondsSinceEpoch)! ~/ 1000,
              payment: Payment(
                  amount: int.parse(price ?? ""), paymentMethod: paymentMethod),
              images: images))
          .then((value) {
        emit(state.copyWith(
          status: CreateJobStatus.createJobSuccess,
        ));
      });
    } catch (e) {
      emit(state.copyWith(
        status: CreateJobStatus.error,
      ));
    }
  }

  void selectDueDate(DateTime time) {
    emit(state.copyWith(
      status: CreateJobStatus.loading,
    ));
    dueDate = time;
    emit(state.copyWith(
      status: CreateJobStatus.success,
    ));
  }
}
