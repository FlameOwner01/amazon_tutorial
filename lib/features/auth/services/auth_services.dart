import 'package:amazaon_tutorial/constants/error_handling.dart';
import 'package:amazaon_tutorial/constants/global_variables.dart';
import 'package:amazaon_tutorial/constants/utils.dart';
import 'package:amazaon_tutorial/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthService {
  //signup user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: "",
          name: name,
          email: email,
          password: password,
          address: "",
          type: "",
          token: "");

      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': "application/json; charset=UTF-8",
          });
      httpErrorHandler(
          response: res,
          context: context,
          onSueccess: () => {
                showSnackBar(
                    context, "Account created! Login with same credentials!"),
              });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
