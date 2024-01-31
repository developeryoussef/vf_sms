import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:breaking_bad/constant/constant.dart';
import 'package:breaking_bad/data/models/characters_model.dart';
import 'package:breaking_bad/data/services/characters_services.dart';
// ignore_for_file: prefer_is_empty

// ignore_for_file: unnecessary_new, prefer_collection_literals

// ignore_for_file: unused_import

// ignore_for_file: avoid_print

// ignore_for_file: unused_local_variable

class CharactersRepository {
  Future<List<CharacterModel>> getAllCharacters() async {
    List<CharacterModel> charactersList = [];
    var respone = await http.get(Uri.parse(charactersURL));
    var responeData = jsonDecode(respone.body);
    print(respone.statusCode);
    print(responeData);
    if (respone.statusCode == 200) {
      print("wtf");
      List<dynamic> characters;
      characters = responeData;
      print('fuck');
      for (int i = 0; i < characters.length; i++) {
        if (characters[i] != null) {
          Map<String, dynamic> map = characters[i];
          charactersList.add(CharacterModel.fromJson(map));
          print(map);
        }
      }
    }
    print(charactersList);
    return charactersList;
  }
}
