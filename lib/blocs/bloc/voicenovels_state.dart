part of 'voicenovels_bloc.dart';

@immutable
abstract class VoicenovelsState {}

class VoicenovelsInitial extends VoicenovelsState {}

class VoiceLoading extends VoicenovelsState {}

class VoiceLoaded extends VoicenovelsState {
  final List<VoiceNovel> voiceNovels;

  VoiceLoaded(this.voiceNovels);
}

class VoiceEmpty extends VoicenovelsState {}
