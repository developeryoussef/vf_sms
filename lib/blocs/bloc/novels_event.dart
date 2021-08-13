part of 'novels_bloc.dart';

@immutable
abstract class NovelsEvent {}


class FetchNovels extends NovelsEvent{
  final String category;

  FetchNovels(this.category);
}