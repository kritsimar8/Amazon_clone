import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/constants/error_handling.dart';
import 'package:test_flutter/constants/global_variables.dart';
import 'package:test_flutter/constants/utils.dart';
import 'package:test_flutter/models/user.dart';
import 'package:test_flutter/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class AddressServices {
 void saveUserAddress ({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
     http.Response res = await http.post(
      Uri.parse('$uri/api/save-user-address'),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': userProvider.user.token,
      },
      body: jsonEncode({
        'address': address
      })
     );
      
    } catch  (e){
      throw Exception(e);
    }
  }
 void placeOrder ({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
     http.Response res = await http.post(
      Uri.parse('$uri/api/order'),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': userProvider.user.token,
      },
      body: jsonEncode({
        'cart': userProvider.user.cart,
        'address': address,
        'totalPrice': totalSum,
      })
     );

     httpErrorHandle(response: res,
      context: context,
       onSuccess: (){
        showSnackBar(context, 'Your order has been placed!');
        User user = userProvider.user.copyWith(
          cart:[],
        );
        userProvider.setUserFromModel(user);
       });
      
    } catch  (e){
      throw Exception(e);
    }
  }
}