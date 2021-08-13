import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rewayat_alkateb_islam/models/novel.dart';
import 'package:rewayat_alkateb_islam/repositories/novelsRepository.dart';

part 'novels_event.dart';
part 'novels_state.dart';

class NovelsBloc extends Bloc<NovelsEvent, NovelsState> {
  NovelsBloc() : super(NovelsInitial());

  @override
  Stream<NovelsState> mapEventToState(
    NovelsEvent event,
  ) async* {
   if(event is FetchNovels){
     yield NovelsLoading();
     List<Novel> novels=await NovelsRepo().fetchNovels(event.category);

     if(novels==null){
       yield NovelsError();
     }else if (novels.length==0){
       yield NovelsEmpty();
     }else {
       yield NovelsLoaded(novels);
     }
   }
  }
}
