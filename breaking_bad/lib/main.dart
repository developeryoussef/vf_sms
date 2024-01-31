import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breaking_bad/data/services/characters_services.dart';
import 'package:breaking_bad/buisness_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/presentation/screens/characters_screen.dart';
import 'package:breaking_bad/data/repositories/characters_repository.dart';
// ignore_for_file: prefer_const_constructors

// ignore_for_file: unused_import

void main() async {
  runApp(BreakingBadApp());
}

class BreakingBadApp extends StatelessWidget {
  const BreakingBadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CharactersCubit(CharactersRepository());
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        locale: Locale('en'),
        home: CharactersScreen(),
      ),
    );
  }
}
