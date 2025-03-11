import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter/Features/home/screens/home_screen.dart';
import 'package:test_flutter/common/widgets/bottom_bar.dart';
import 'package:test_flutter/constants/error_handling.dart';
import 'package:test_flutter/constants/global_variables.dart';
import 'package:test_flutter/constants/utils.dart';
import 'package:test_flutter/models/user.dart';
import 'package:test_flutter/providers/user_provider.dart';

class AuthService {
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
        cart:[]
      );

      final res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: {'Content-Type': 'application/json'},
      );
      print(res.statusCode);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // showSnackBar(
          //   context,
          //   'Account created! Login with the same credentials',
          // );
        },
      );
    } catch (e) {
      // showSnackBar(context, e.toString());
    }
  }

  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          bool tok = await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          print('$tok this is insert func');
          if(!context.mounted) return;
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
            (route) => false,
          );
      
        },
      );
    } catch (e) {
      // showSnackBar(context, e.toString());
    }
  }

  Future<void> getUserData({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      print('$token this is getuser func');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
        print('pre post');
      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token!},
      );
      print('token veri done');

      var response = jsonDecode(tokenRes.body);
      print(response);
      if (response == true) {
      final userRes =   await http.get(
          Uri.parse('$uri/'),
          headers: {'Content-Type': 'application/json', 'x-auth-token': token},
        );
        print(userRes.body);
        var userProvider = Provider.of<UserProvider>(context,listen:false);
        userProvider.setUser(userRes.body);


      }

    } catch (e) {
      // showSnackBar(context, e.toString());
    }
  }
}
