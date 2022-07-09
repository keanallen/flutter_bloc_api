import 'package:bloc_api/services/boredService.dart';
import 'package:bloc_api/services/connectivityService.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BoredService _boredService;
  final ConnectivityService _connectivityService;

  HomeBloc(this._boredService, this._connectivityService)
      : super(HomeLoadingState()) {
    _connectivityService.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        print("No Internet");
        add(NoInternetEvent());
      } else {
        print("Has Internet");
        add(LoadApiEvent());
      }
    });

    on<LoadApiEvent>(_onLoadApi);
    on<NoInternetEvent>(_onNoInternet);
  }

  Future<void> _onLoadApi(LoadApiEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    final activity = await _boredService.getBoredActivity();
    emit(
      HomeLoadedState(
        activityName: activity.activity,
        activityType: activity.type,
        participants: activity.participants,
      ),
    );
  }

  Future<void> _onNoInternet(
      NoInternetEvent event, Emitter<HomeState> emit) async {
    emit(HomeNoInternetState());
  }
}
