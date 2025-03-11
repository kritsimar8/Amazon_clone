
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:test_flutter/constants/error_handling.dart';
import 'package:test_flutter/constants/global_variables.dart';
import 'package:test_flutter/constants/utils.dart';
import 'package:test_flutter/models/product.dart';
import 'package:test_flutter/providers/user_provider.dart';

class SearchService{
   Future<List<Product>> fetchSearchedProduct({required BuildContext context, required String searchQuery}) async {
     final userProvider = Provider.of<UserProvider>(context,listen : false);
    List<Product> productList = [];
    try{
      http.Response res = await  http.get(Uri.parse('$uri/api/products/search/$searchQuery'),
      headers: {
         'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token,
      }
      );
      print(res.body);
      print("hello body above");
      httpErrorHandle(response: res, context: context, onSuccess: (){
        for (int i =0; i< jsonDecode(res.body).length; i++){
          productList.add(Product.fromJson(
            jsonEncode(jsonDecode(res.body)[i])
          ));
        }
      });
      
    } catch(e){
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}