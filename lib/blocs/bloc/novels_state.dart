part of 'novels_bloc.dart';

@immutable
abstract class NovelsState {}

class NovelsInitial extends NovelsState {}

class NovelsLoading extends NovelsState
{

}

class NovelsEmpty extends NovelsState{

}

class NovelsError extends NovelsState{

}

class NovelsLoaded extends NovelsState{
  final List<Novel> novels
  ;

  NovelsLoaded(this.novels);
}