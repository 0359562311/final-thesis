import 'package:bloc/bloc.dart';
import 'package:fakeslink/app/model/repositories/home_repository.dart';
import 'package:fakeslink/app/viewmodel/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository = HomeRepositoryImpl();

  HomeCubit() : super(HomeState(status: HomeStatus.initial));

  int currentTab = 0;

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

  void getCategory() {
    emit(state.copyWith(status: HomeStatus.loading));
    _homeRepository.getCategory().then((value) {
      emit(state.copyWith(status: HomeStatus.success, category: value));
    }).catchError((onError) {
      emit(state.copyWith(category: state.category, status: HomeStatus.error));
    });
  }

  void changeTab(int index) {
    emit(state.copyWith(status: HomeStatus.loading));
    currentTab = index;
  }
}
