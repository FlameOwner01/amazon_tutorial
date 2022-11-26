import 'dart:convert';
import 'dart:ffi';

import 'package:amazaon_tutorial/constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void httpErrorHandler({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSueccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSueccess();
      break;
    case 400:
      showSnackBar(
        context,
        json.decode(response.body)['msg'],
      );
      break;
    case 500:
      showSnackBar(
        context,
        json.decode(response.body)['error'],
      );
      break;
    default:
      showSnackBar(
        context,
        response.body,
      );
  }
}
