import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rewayat_alkateb_islam/models/user.dart';
import 'package:rewayat_alkateb_islam/repositories/userRepo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
   if(event is FetchUser){yield UserLoading();
     User user=await UserRepo().getUser();
     if(user==null){
       yield UserError();
     }else{
       yield UserLoaded(user);
     }
   }
  }
}
