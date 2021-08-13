import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:rewayat_alkateb_islam/models/voiceNovel.dart';
import 'package:rewayat_alkateb_islam/repositories/novelsRepository.dart';

part 'voicenovels_event.dart';
part 'voicenovels_state.dart';

class VoicenovelsBloc extends Bloc<VoicenovelsEvent, VoicenovelsState> {
  VoicenovelsBloc() : super(VoicenovelsInitial());

  @override
  Stream<VoicenovelsState> mapEventToState(
    VoicenovelsEvent event,
  ) async* {
    if (event is VoiceFetch) {
      yield VoiceLoading();
      List<VoiceNovel> voiceNovels = await NovelsRepo().fetchVoiceNovels();
      if (voiceNovels.length == 0) {
        yield VoiceEmpty();
      } else {
        yield VoiceLoaded(voiceNovels);
      }
    }
  }
}
