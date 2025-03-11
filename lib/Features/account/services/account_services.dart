import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter/Features/auth/screens/auth_screen.dart';
import 'package:test_flutter/constants/error_handling.dart';
import 'package:test_flutter/constants/global_variables.dart';
import 'package:test_flutter/constants/utils.dart';
import 'package:test_flutter/models/order.dart';
// import 'package:test_flutter/models/product.dart';
import 'package:test_flutter/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class AccountService {
  Future<List<Order>> fetchMyOrders({
    required BuildContext context,
   
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/orders/me'),
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
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(Order.fromJson(jsonEncode(jsonDecode(res.body)[i])));
          }
        },
      );
    } catch (e) {
      throw Exception(e);
    }
    return orderList;
  }

  void logOut(BuildContext context) async {
    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(context, AuthScreen.routeName, (route)=> false);

    } catch(e){
      showSnackBar(context, e.toString());
    }
  }



}
