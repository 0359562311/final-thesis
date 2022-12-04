import 'package:bloc/bloc.dart';
import 'package:fakeslink/app/model/request/filter_job_request.dart';
import 'package:fakeslink/app/model/repositories/job_repository.dart';
import 'package:fakeslink/app/model/repositories/user_respository.dart';
import 'package:fakeslink/app/viewmodel/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final JobRepository _jobRepository = JobRepositoryImpl();
  final UserRepository _userRepository = UserRepositoryImpl();

  HomeCubit() : super(HomeState(status: HomeStatus.initial));

  List<String> listJob = [
    "Đào tạo",
    "Lập trình",
    "Kế toán",
    "Sửa chữa",
    "Marketing",
    "Vận chuyển",
    "Thiết kế",
    "Viết & Dịch",
    "Khác"
  ];
  List<String> listImage = [
    "assets/images/education.png",
    "assets/images/it.png",
    "assets/images/accounting.png",
    "assets/images/reparing.png",
    "assets/images/marketing.png",
    "assets/images/delivery-truck.png",
    "assets/images/designer.png",
    "assets/images/interpreter.png",
    "assets/images/other.png"
  ];

  void init() async {
    emit(state.copyWith(status: HomeStatus.loading));
    await _userRepository.getProfile();
    getCategory();
  }

  void getCategory() {
    _jobRepository.getCategory().then((value) {
      emit(state.copyWith(status: HomeStatus.success, category: value));
      changeTab(state.currentTab);
    }).catchError((onError) {
      emit(state.copyWith(category: state.category, status: HomeStatus.error));
    });
  }

  void changeTab(int index) {
    emit(state.copyWith(currentTab: index, jobs: []));
    _jobRepository
        .getJobs(FilterJob(categories: [state.category?[index].id ?? 0]))
        .then((value) => emit(state.copyWith(currentTab: index, jobs: value)))
        .catchError((_) => emit(state.copyWith(currentTab: index, jobs: [])));
  }
}
