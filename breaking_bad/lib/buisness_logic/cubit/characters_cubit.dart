import 'characters_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breaking_bad/data/models/characters_model.dart';
import 'package:breaking_bad/data/repositories/characters_repository.dart';
// ignore_for_file: unnecessary_this

// ignore_for_file: depend_on_referenced_packages

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<CharacterModel> charactersList = [];
  CharactersCubit(
    this.charactersRepository,
  ) : super(CharactersInitial());

  List<CharacterModel> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters: characters));
      this.charactersList = characters;
      print(charactersList);
    });
    return charactersList;
  }
}
