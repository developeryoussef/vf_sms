import 'package:flutter/material.dart';
import 'package:rewayat_alkateb_islam/repositories/authRepo.dart';

Container buildFacebookLoginButton(context) {
  return Container(
    margin: EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 0),
    child:Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(onTap: ()async{
            await AuthRepo().signInWithFacebook(context);

      },
        child: Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/fb.png'))),
          height: 48,width: MediaQuery.of(context).size.width,
        ),
      ),
    ));/* ButtonTheme(
      height: 48,

      child: RaisedButton(
          materialTapTargetSize: MaterialTapTargetSize.padded,
          onPressed: () async {
          },
          color: Color.fromRGBO(27, 76, 213, 1),
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "التسجيل من خلال الفيسبوك",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          )),
    ),
  */
}
