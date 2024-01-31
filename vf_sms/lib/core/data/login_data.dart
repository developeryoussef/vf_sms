import '../classes/crud.dart';

class LoginData {
  Crud crud;
  LoginData(this.crud);
  postdata(String email, String password) async {
    var response = await crud.postData(
        "http://192.168.1.7:5000/auth/login-mobile/",
        {"email": email, "password": password},
        {});
    return response.fold((l) => l, (r) => r);
  }
}
