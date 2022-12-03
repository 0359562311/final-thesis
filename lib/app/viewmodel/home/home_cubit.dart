import 'package:bloc/bloc.dart';
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
    "Kế toàn",
    "Kiến trúc",
    "Marketing",
    "Thiết kế",
    "Trợ lý",
    "Tư Vấn",
    "Tất cả"
  ];
  List<String> listImage = [
    "assets/images/ic_form.png",
    "assets/images/ic_programming.png",
    "assets/images/ic_assistant.png",
    "assets/images/ic_architecture.png",
    "assets/images/ic_marketing.png",
    "assets/images/ic_designer.png",
    "assets/images/ic_advise.png",
    "assets/images/ic_analytics.png",
    "assets/images/ic_all.png"
  ];

  void init() {
    _userRepository.getProfile().then((value) => null);
  }

  void getCategory() {
    emit(state.copyWith(status: HomeStatus.loading));
    _jobRepository.getCategory().then((value) {
      emit(state.copyWith(status: HomeStatus.success, category: value));
    }).catchError((onError) {
      emit(state.copyWith(category: state.category, status: HomeStatus.error));
    });
  }

  void changeTab(int index) {
    emit(state.copyWith(status: HomeStatus.loading, currentTab: index));
  }
}
