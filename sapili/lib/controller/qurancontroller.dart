import 'dart:convert';
import '../main.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../view/screens/surahpage.dart';
import '../view/screens/ayahscreen.dart';
// ignore_for_file: unused_import, unused_local_variable, unnecessary_brace_in_string_interps, prefer_const_constructors

class QuranController extends GetxController {
  String? currentAyahTafseer;
  String? currentAyahMeaning;
  String? currentSurah;
  int? currentIndex;

  setLastSurah(String name, int surah) async {
    currentSurah = name;
    currentIndex = surah;
    sharedPreferences!.setString('lastsurah', name);
    Get.to(SurahPage());
  }

  // getAyahs() async {
  //   String baseUrl = 'https://api.alquran.cloud/v1/surah/${currentIndex}';
  //   var response = await http.get(Uri.parse(baseUrl));
  //   var statusCode = response.statusCode;
  //   var responsebody = jsonDecode(response.body);
  //   return responsebody['data']['ayahs'];
  // }

  getAyahTafseer(int ayah) async {
    String? baseUrl =
        'https://quranenc.com/api/v1/translation/aya/english_saheeh/${currentIndex}/${ayah}';
    var response = await http.get(Uri.parse(baseUrl));
    var statusCode = response.statusCode;
    var responsebody = jsonDecode(response.body);
    currentAyahMeaning = responsebody['result']['translation'];
    currentAyahTafseer = responsebody['result']['footnotes'];
    if (currentAyahTafseer != null && currentAyahMeaning != null) {
      Get.to(AyahScreen(
          ayah: responsebody['result']['arabic_text'], ayahNum: ayah));
    }
  }
}
