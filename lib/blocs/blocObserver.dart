import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  // ignore: must_call_super
  void onCreate(BlocBase bloc) {
    print(bloc);
  }

  @override
  // ignore: must_call_super
  void onEvent(Bloc bloc, Object? event) {print('$bloc event occured : $event');}


  @override
  // ignore: must_call_super
  void onTransition(Bloc bloc, Transition transition) {
    print('$bloc transition occured : $transition');
  }

  @override
  // ignore: must_call_super
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {print('$bloc error occured : $error');}

  @override
  // ignore: must_call_super
  void onClose(BlocBase bloc) {print('$bloc closed');}
}