import 'package:bloc/bloc.dart';
import 'package:healthify/bloc/home/get_user_data/fetch_bloc_event.dart';
import 'package:healthify/bloc/home/get_user_data/fetch_bloc_state.dart';
import 'package:healthify/service/ApiService.dart';

class FetchUserDataBloc
    extends Bloc<FetchUserDataBlocEvent, FetchUserDataBlocState> {
  final ApiService _apiService;

  FetchUserDataBloc({required ApiService apiService})
      : _apiService = apiService,
        super(FetchingDataInitial()) {
    on<GetUserData>((event, emit) async {
      emit(FetchingDataLoading());

      try {
        Future.delayed(const Duration(seconds: 5));
        await _apiService.getUserData();

        emit(FetchingDataSuccess());
      } catch (err) {
        emit(FetchingDataFailure(errorMessage: err.toString()));
      }
    });
  }
}
