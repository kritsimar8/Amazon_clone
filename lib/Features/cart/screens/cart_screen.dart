import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/Features/address/screens/address_screen.dart';
import 'package:test_flutter/Features/cart/widgets/cart_product.dart';
import 'package:test_flutter/Features/cart/widgets/cart_subtotal.dart';
import 'package:test_flutter/Features/home/widgets/address_box.dart';
import 'package:test_flutter/Features/search/screens/search_screen.dart';
import 'package:test_flutter/common/widgets/custom_button.dart';
import 'package:test_flutter/constants/global_variables.dart';
import 'package:test_flutter/models/user.dart';
import 'package:test_flutter/providers/user_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {


   void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }
   void navigateToAddress(int sum) {
    Navigator.pushNamed(context, AddressScreen.routeName, arguments:sum.toString() );
  }



  @override
  Widget build(BuildContext context) {
    
    final user = context.watch<UserProvider>().user;
    int sum =0;
    user.cart.map((e)=> sum += e['quantity'] * e['product']['price'] as int).toList();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
         child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient
            ),
          ),
          title: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
              Expanded(
                child: Container(
                 height: 42,
                 margin: const EdgeInsets.only(left: 5,right: 10),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: (){},
                          child: const Padding(padding: EdgeInsets.only(
                            left: 6,
                          ),
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 23,
                          ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top:10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7),
                          ),
                          borderSide: BorderSide.none
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          )
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Color.fromARGB(108, 0, 0, 0)
                        )
                      ),
                    ),
                  )
                ),
              ),
             Padding(
               padding: const EdgeInsets.only(right: 6.0),
               child: Icon(Icons.mic,color: Colors.black,size: 25,),
             )
             ],
          ),
         )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const AddressBox(),
              const CartSubtotal(),
              Padding(padding: const EdgeInsets.all(8.0),
              child: CustomButton(text: 'Proceed to Buy (${user.cart.length}) items', 
              onTap: ()=> navigateToAddress(sum),
              color: Colors.yellow[600],
              ),
              ),
              const SizedBox(height: 15,),
              Container(
                color: const Color.fromARGB(26, 0, 0, 0),
                height: 1,
              ),
              const SizedBox(height: 5,),
              ListView.builder(
                itemCount: user.cart.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return CartProduct(index: index);
                })
            ],
          ),
        ),
    );
  }
}