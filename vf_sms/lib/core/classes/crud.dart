import 'dart:convert';
import 'statusrequest.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../functions/check_internet.dart';

class Crud {
  Future<Either<StatusRequest, Map>> postData(
      String linkurl, Map data, Map<String, String> headers) async {
    if (await checkInternet()) {
      var response =
          await http.post(Uri.parse(linkurl), body: data, headers: headers);
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = jsonDecode(response.body);
        print(responsebody);

        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }
}
