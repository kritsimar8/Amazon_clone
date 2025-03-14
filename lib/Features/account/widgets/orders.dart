import 'package:flutter/material.dart';
import 'package:test_flutter/Features/account/services/account_services.dart';
import 'package:test_flutter/Features/account/widgets/single_product.dart';
import 'package:test_flutter/Features/order_details/screens/order_details.dart';
import 'package:test_flutter/common/widgets/loader.dart';
import 'package:test_flutter/constants/global_variables.dart';
import 'package:test_flutter/models/order.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
 List<Order>? orders;
 final AccountService accountService = AccountService();

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountService.fetchMyOrders(context: context);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return orders == null? const Loader() :Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text('Your Orders',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800
              ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                right: 15
              ),
              child: Text(
                'See all',
                style: TextStyle(
                  color: GlobalVariables.selectedNavBarColor
                ),
              ),
            )
          ],
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20,right: 0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: orders!.length,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, OrderDetaiilScreen.routeName,arguments: orders![index]);
                },
                child: SingleProduct(image: orders![index].products[0].images[0]));
            }),
        )
      ],
    );
  }
}