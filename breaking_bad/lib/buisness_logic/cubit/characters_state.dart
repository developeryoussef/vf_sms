import 'package:breaking_bad/data/models/characters_model.dart';

abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<CharacterModel> characters;
  CharactersLoaded({required this.characters});
}

class CharactersErrorCase extends CharactersState {}

class CharactersLoadingCase extends CharactersState {}
