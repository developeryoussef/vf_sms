import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewayat_alkateb_islam/blocs/bloc/novels_bloc.dart';
import 'package:rewayat_alkateb_islam/blocs/bloc/voicenovels_bloc.dart';
import 'package:rewayat_alkateb_islam/constants.dart';
import 'package:rewayat_alkateb_islam/views/screens/categoryNovels.dart';
import 'package:rewayat_alkateb_islam/views/screens/voiceNovels.dart';

import 'package:superellipse_shape/superellipse_shape.dart';

buildCatContainer(context, _height, _width, nameEn, nameAr, picPath, tag,nameAr2,fn,fnForDisposing) {
  return Padding(
    padding: const EdgeInsets.all(7.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) =>nameEn=='voiceNovels'?BlocProvider(
                  create: (ctx)=>VoicenovelsBloc()..add(VoiceFetch()),
                  child: VoiceNovels(
                    nameAr: nameAr,
                    nameEn: nameEn,
                    photoPath: picPath,
                    tag:tag,
                    nameAr2:nameAr2,
                  )): BlocProvider(
                      create: (context) =>
                          NovelsBloc()..add(FetchNovels(nameEn)),
                      child: CategoryNovels(
                        nameAr: nameAr,forDisposing: fnForDisposing,
                        nameEn: nameEn,
                        photoPath: picPath,
                        tag: tag,nameAr2: nameAr2,
                      ),
                    )));
                    //TODO UNCOMMENT FN
                    fn();
      },
      child: Material(
        color: Colors.white,
        shadowColor: Colors.grey.withOpacity(.5),
        elevation: 3,
        shape: SuperellipseShape(
          borderRadius: BorderRadius.circular(28),
        ),
        child: Container(
          height: _height * .15,
          width: _width * .4,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: _height * .13,
                  width: _width * .3,
                  child: ClipRRect(
                    child: Hero(
                      tag: tag,
                      child: Image.asset(
                        picPath,
                        fit: BoxFit.fill,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  nameAr,
                  style: TextStyle(
                      color: kMainColor,fontFamily: 'Cairo',
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      letterSpacing: .1),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

buildContainer(context, _height, _width, nameEn, nameAr, picPath, tag, tab) {
  return Padding(
    padding: const EdgeInsets.all(7.0),
    child: InkWell(
      onTap: tab,
      child: Material(
        color: Colors.white,
        shadowColor: Colors.grey.withOpacity(.5),
        elevation: 3,
        shape: SuperellipseShape(
          borderRadius: BorderRadius.circular(28),
        ),
        child: Container(
          height: _height * .15,
          width: _width * .4,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: _height * .13,
                  width: _width * .3,
                  child: ClipRRect(
                    child: Image.asset(
                      picPath,
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  nameAr,
                  style: TextStyle(
                      color: kMainColor,fontFamily: 'Cairo',
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      letterSpacing: .1),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
