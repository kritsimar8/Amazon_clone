import 'package:flutter/material.dart';
import 'package:test_flutter/Features/account/widgets/single_product.dart';
import 'package:test_flutter/Features/admin/services/admin_services.dart';
import 'package:test_flutter/Features/order_details/screens/order_details.dart';
import 'package:test_flutter/common/widgets/loader.dart';
import 'package:test_flutter/models/order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrders();
  }

 void fetchOrders() async{
   orders = await adminServices.fetchAllOrders(context);
   setState(() {
     
   });
  }


  @override
  Widget build(BuildContext context) {
    return orders == null ? Loader() : GridView.builder(
      itemCount: orders!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
       itemBuilder: (context, index){
        final orderData = orders![index];
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, OrderDetaiilScreen.routeName,arguments: orderData);
          },
          child: SizedBox(
            height: 140,
            child: SingleProduct(
              image: orderData.products[0].images[0]),
          ),
        );
       });
  }
}