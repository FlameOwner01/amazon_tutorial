import 'dart:convert';
import 'dart:io';
import 'package:amazaon_tutorial/constants/error_handling.dart';
import 'package:amazaon_tutorial/constants/global_variables.dart';
import 'package:amazaon_tutorial/constants/utils.dart';
import 'package:amazaon_tutorial/features/admin/models/sales.dart';
import 'package:amazaon_tutorial/models/order.dart';
import 'package:amazaon_tutorial/models/product.dart';
import 'package:amazaon_tutorial/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final usersProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic("dlzmcelwm", "fkib63pm");
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price);

      http.Response res = await http.post(
        Uri.parse("$uri/admin/add-product"),
        headers: {
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": usersProvider.user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSueccess: () {
          showSnackBar(context, "Product added sueccesfully");
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
  //get all the products

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProviders = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];

    try {
      http.Response res =
          await http.get(Uri.parse("$uri/admin/get-products"), headers: {
        'Content-Type': "application/json; charset=UTF-8",
        "x-auth-token": userProviders.user.token,
      });
      httpErrorHandler(
        response: res,
        context: context,
        onSueccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(Product.fromJson(jsonEncode(
              jsonDecode(res.body)[i],
            )));
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandler(
        response: res,
        context: context,
        onSueccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  void deleteProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSucess}) async {
    try {
      final userProviders = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse("$uri/admin/delete-products"),
        headers: {
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": userProviders.user.token,
        },
        body: jsonEncode({
          "id": product.id,
        }),
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSueccess: () {
          onSucess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': order.id,
          'status': status,
        }),
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSueccess: onSuccess,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/analytics'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandler(
        response: res,
        context: context,
        onSueccess: () {
          var response = jsonDecode(res.body);
          totalEarning = response['totalEarnings'];

          sales = [
            Sales('Mobiles', response['mobileEarnings']),
            Sales('Essentials', response['essentialEarnings']),
            Sales('Books', response['booksEarnings']),
            Sales('Appliances', response['applianceEarnings']),
            Sales('Fashion', response['fashionEarnings']),
          ];
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }
}
