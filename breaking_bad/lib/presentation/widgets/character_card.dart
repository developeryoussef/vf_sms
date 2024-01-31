// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:breaking_bad/constant/constant.dart';
import 'package:breaking_bad/data/models/characters_model.dart';

// ignore_for_file: sort_child_properties_last

class CharacterItem extends StatelessWidget {
  final CharacterModel character;

  const CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        child: GridTile(
          child: Hero(
            tag: character.id.toString(),
            child: Container(
                color: myDarkC,
                child: FadeInImage.assetNetwork(
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: 'assets/images/loading.gif',
                  image: character.image!,
                  fit: BoxFit.cover,
                )),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              '${character.name}',
              style: TextStyle(
                height: 1.3,
                fontSize: 16,
                color: myWhite,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
