import 'dart:developer';
import 'package:bloc/bloc.dart';

class SimpleObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log("onChange: \tBloc: ${bloc.runtimeType}, \nChange: ${change.currentState}");
    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase bloc) {
    log("onClose: \tBloc: ${bloc.runtimeType}");
    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    log("onCreate: \tBloc: ${bloc.runtimeType}");
    super.onCreate(bloc);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log("onTransition: \tBloc: ${bloc.runtimeType}, \nTransition: ${transition.event}");
    super.onTransition(bloc, transition);
  }
}
