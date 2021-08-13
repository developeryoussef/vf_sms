import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';
import 'package:rewayat_alkateb_islam/models/messageRoom.dart';
import 'package:rewayat_alkateb_islam/repositories/messagingRepo.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  MessagesBloc() : super(MessagesInitial());

  @override
  Stream<MessagesState> mapEventToState(
    MessagesEvent event,
  ) async* {
    if (event is FetchMessages) {
      yield MessagesLoading();
      dynamic messageRoom = await MessagingRepo().getAllMessages();
      if (messageRoom == false) {
        yield MessagesFailed();
      } else {
        yield MessagesFetched(messageRoom);
      }
    } else if (event is SendMessage) {
      bool sended = await MessagingRepo().addMessage(event.message);
      if (sended == true) {
        dynamic messageRoom = await MessagingRepo().getAllMessages();
        if (messageRoom == false) {
          yield MessagesFailed();
        } else {
          yield MessagesFetched(messageRoom);
        }
      }
    }else if (event is RefreshMessages){
       dynamic messageRoom = await MessagingRepo().getAllMessages();   if (messageRoom == false) {
        yield MessagesFailed();
      } else {
        yield MessagesFetched(messageRoom);
      }
    }
  }
}