import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:rewayat_alkateb_islam/constants.dart';
import 'package:rewayat_alkateb_islam/models/novel.dart';
import 'package:rewayat_alkateb_islam/models/voiceNovel.dart';

class NovelsRepo {
  fetchNovels(category) async {
    DioCacheManager _dioCacheManager;

   late List<Novel> novels;
    _dioCacheManager = DioCacheManager(CacheConfig());

    Dio _dio = Dio();
    _dio.interceptors.add(_dioCacheManager.interceptor);

    Response response = await _dio.get("$baseUrl/novels/$category",
       //options: buildCacheOptions(Duration(hours: 6))
        );
    if (response.statusCode == 200) {
      novels = [];
      response.data.forEach((novel) {
        novels.add(Novel.fromJson(novel));
      });

      novels.sort((a, v) => v.createdAt.compareTo(a.createdAt));
    }

    return novels;
  }

  fetchVoiceNovels()async{
   late List <VoiceNovel> novels;
    Response res= await Dio().get('$baseUrl/voiceNovels');
    if(res.statusCode==200){
      novels = [];
      res.data.forEach((novel) {
        novels.add(VoiceNovel.fromJson(novel));
      });

      novels.sort((a, v) => v.createdAt.compareTo(a.createdAt));
    }

    return novels;
  }
}
