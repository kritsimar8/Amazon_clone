import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/constants/error_handling.dart';
import 'package:test_flutter/constants/global_variables.dart';
import 'package:test_flutter/models/product.dart';
import 'package:test_flutter/models/user.dart';
import 'package:test_flutter/providers/user_provider.dart';
import 'package:http/http.dart' as http;
class ProductDetailServices {

   void addToCart ({
    required BuildContext context,
    required Product product,
  
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
    
       http.Response res1 = await http.post(
          Uri.parse('$uri/api/add-to-cart'),
          headers: {
            'Content-Type': 'application/json',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'id': product.id!,
          })
        );
   
        httpErrorHandle(response: res1, context: context, onSuccess: (){ 
        User user =  userProvider.user.copyWith(
            cart: jsonDecode(res1.body)['cart']);
            userProvider.setUserFromModel(user);
        });
      
    } catch  (e){
      throw Exception(e);
    }
  }


   void rateProduct ({
    required BuildContext context,
    required Product product,
    required double rating
  
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
    
       http.Response res1 = await http.post(
          Uri.parse('$uri/api/rate-product'),
          headers: {
            'Content-Type': 'application/json',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'id': product.id!,
            'rating': rating
          })
        );
   
        httpErrorHandle(response: res1, context: context, onSuccess: (){ });
      
    } catch  (e){
      throw Exception(e);
    }
  }
}