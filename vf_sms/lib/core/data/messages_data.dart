import '../classes/crud.dart';
// ignore_for_file: unnecessary_string_interpolations


class MessagesData {
  Crud crud;
  MessagesData(this.crud);
  postdata(String id , String tokenApp) async {
    var response = await crud.postData("http://192.168.1.7:5000/api/message/",
        {"userId" : id} , {
          "authorization" : "$tokenApp"
        });
    return response.fold((l) => l, (r) => r);
  }
}
