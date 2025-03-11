


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/Features/home/widgets/address_box.dart';
import 'package:test_flutter/Features/home/widgets/carousel_image.dart';
import 'package:test_flutter/Features/home/widgets/deal_of_day.dart';
import 'package:test_flutter/Features/home/widgets/top_categories.dart';
import 'package:test_flutter/Features/search/screens/search_screen.dart';
import 'package:test_flutter/constants/global_variables.dart';
import 'package:test_flutter/providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;


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
            AddressBox(),
            SizedBox(height: 10,),
            TopCategories(),
            SizedBox(height: 10,),
            CarouselImage(),
            SizedBox(height: 10,),
            DealOfDay()
          ],
        ),
      )
    );
  }
}