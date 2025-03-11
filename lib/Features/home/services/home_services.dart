import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/constants/error_handling.dart';
import 'package:test_flutter/constants/global_variables.dart';
import 'package:test_flutter/models/product.dart';
import 'package:test_flutter/providers/user_provider.dart';
import 'package:http/http.dart' as http; 

class HomeServices {
  Future<List<Product>> fetchCategoryProducts({required BuildContext context, required String category}) async {
     final userProvider = Provider.of<UserProvider>(context,listen : false);
    List<Product> productList = [];
    try{
      http.Response res = await  http.get(Uri.parse('$uri/api/products?category=$category'),
      headers: {
         'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token,
      }
      );
      print(res.body);
      
      httpErrorHandle(response: res, context: context, onSuccess: (){
        for (int i =0; i< jsonDecode(res.body).length; i++){
          productList.add(Product.fromJson(
            jsonEncode(jsonDecode(res.body)[i])
          ));
        }
      });
      
    } catch(e){
      throw Exception(e);
    }
    return productList;
  }

  Future<Product> fetchDealOfDay({required BuildContext context}) async {
     final userProvider = Provider.of<UserProvider>(context,listen : false);
     Product product = Product(
      name: '',
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0);
    try{
      http.Response res = await  http.get(Uri.parse('$uri/api/deal-of-day'),
      headers: {
         'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token,
      }
      );
      print(res.body);
      
      httpErrorHandle(response: res, context: context, onSuccess: (){
        product = Product.fromJson(res.body);
      });
      
    } catch(e){
      throw Exception(e);
    }
    return product;
  }
}