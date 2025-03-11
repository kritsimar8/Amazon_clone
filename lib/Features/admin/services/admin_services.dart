import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/Features/admin/models/sales.dart';
import 'package:test_flutter/constants/error_handling.dart';
import 'package:test_flutter/constants/global_variables.dart';
import 'package:test_flutter/models/order.dart';
import 'package:test_flutter/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:test_flutter/providers/user_provider.dart';

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
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('djz1u0als', 'Testing');
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
        price: price,
      );

      http.Response res1 = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );
      print(res1.statusCode);
      httpErrorHandle(
        response: res1,
        context: context,
        onSuccess: () {
          print('Product added successfully');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token,
        },
      );
      print(res.body);
      print('hi top');
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(jsonEncode(jsonDecode(res.body)[i])),
            );
          }
        },
      );
      print('hi bottom');
    } catch (e) {
      throw Exception(e);
    }
    return productList;
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res1 = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': product.id}),
      );
      print(res1.statusCode);
      httpErrorHandle(
        response: res1,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-orders'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token,
        },
      );
      print(res.body);
      print('hi top');
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(Order.fromJson(jsonEncode(jsonDecode(res.body)[i])));
          }
        },
      );
      print('hi bottom');
    } catch (e) {
      throw Exception(e);
    }
    return orderList;
  }

  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res1 = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': order.id, 'status': status}),
      );
      print(res1.statusCode);
      httpErrorHandle(response: res1, context: context, onSuccess: onSuccess);
    } catch (e) {
      throw Exception(e);
    }
  }


  Future<Map<String,dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarning=0;
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/analytics'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token,
        },
      );
      print(res.body);
     
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
         var response = jsonDecode(res.body);
         totalEarning = response['totalEarning'];
         sales =[
          Sales('Mobiles', response['mobileEarnings']),
          Sales('Essentials', response['essentialEarnings']),
          Sales('Books', response['booksEarnings']),
          Sales('Appliances', response['applianceEarnings']),
          Sales('Fashion', response['fashionEarnings']),
         ];
        },
      );
      
    } catch (e) {
      throw Exception(e);
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }



}
