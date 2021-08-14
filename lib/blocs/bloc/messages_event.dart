part of 'messages_bloc.dart';

@immutable
abstract class MessagesEvent {}


class FetchMessages extends MessagesEvent{

}


class SendMessage extends MessagesEvent{
  final String message;

  SendMessage(this.message);
}


class RefreshMessages extends MessagesEvent{
final ScrollController  _scrollController;
final MessageRoom messageRoom;
  RefreshMessages(this._scrollController, this.messageRoom);
}