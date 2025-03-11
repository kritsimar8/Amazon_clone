
import 'package:flutter/material.dart';
import 'package:test_flutter/Features/Product_details/screens/product_details_screen.dart';
import 'package:test_flutter/Features/address/screens/address_screen.dart';
import 'package:test_flutter/Features/admin/screens/add_product_screen.dart';
import 'package:test_flutter/Features/auth/screens/auth_screen.dart';
import 'package:test_flutter/Features/home/screens/category_deals_screen.dart';
import 'package:test_flutter/Features/home/screens/home_screen.dart';
import 'package:test_flutter/Features/order_details/screens/order_details.dart';
import 'package:test_flutter/Features/search/screens/search_screen.dart';
import 'package:test_flutter/common/widgets/bottom_bar.dart';
import 'package:test_flutter/models/order.dart';
import 'package:test_flutter/models/product.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings){
  switch (routeSettings.name){
    case AuthScreen.routeName:
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (_)=> const AuthScreen()
    );
    case HomeScreen.routeName: 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=> const HomeScreen()); 
    case BottomBar.routeName: 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=> const BottomBar()); 
    case AddProductScreen.routeName: 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=> const AddProductScreen()); 
    case CategoryDealsScreen.routeName: 
    var category = routeSettings.arguments as String; 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=>  CategoryDealsScreen(
          category: category,
        )); 
    case SearchScreen.routeName: 
    var searchQuery = routeSettings.arguments as String; 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=>  SearchScreen(
          searchQuery: searchQuery,
        )); 
    case ProductDetailsScreen.routeName: 
    var product = routeSettings.arguments as Product; 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=>  ProductDetailsScreen(
          product: product,
        )); 
    case AddressScreen.routeName: 
    var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=>  AddressScreen(
          totalAmount: totalAmount,
        )); 
    case OrderDetaiilScreen.routeName: 
    var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=>  OrderDetaiilScreen(
          order: order,
        )); 
    default: 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=> const Scaffold(
        body: Center(
          child: Text('Screen does not exist!'),
        ),
      ));

  }
}