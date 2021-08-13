part of 'messages_bloc.dart';

@immutable
abstract class MessagesState {}

class MessagesInitial extends MessagesState {}
class MessagesLoading extends MessagesState {}


class MessagesFetched extends MessagesState{
  final MessageRoom messageRoom;

  MessagesFetched(this.messageRoom); 
}

class MessagesFailed extends MessagesState{

}

class MessagesEmpty extends MessagesState{}

class MessageSendSuccessFully extends MessagesState{

}

class MessagesRefreshed extends MessagesState{

}