import 'package:bloc_api/home/bloc/home_bloc.dart';
import 'package:bloc_api/services/boredService.dart';
import 'package:bloc_api/services/connectivityService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        RepositoryProvider.of<BoredService>(context),
        RepositoryProvider.of<ConnectivityService>(context),
      )..add(LoadApiEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter BLoC - Api"),
        ),
        body: SizedBox(
          width: double.infinity,
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is HomeLoadedState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      state.activityName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(state.activityType),
                    Text(state.participants.toString()),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<HomeBloc>(context).add(LoadApiEvent());
                      },
                      child: const Text("Load Next"),
                    ),
                  ],
                );
              }
              if (state is HomeNoInternetState) {
                return const Center(
                  child: Text("No internet"),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
