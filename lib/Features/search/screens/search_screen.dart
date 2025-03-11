import 'package:flutter/material.dart';
import 'package:test_flutter/Features/Product_details/screens/product_details_screen.dart';
import 'package:test_flutter/Features/home/widgets/address_box.dart';
import 'package:test_flutter/Features/search/services/search_services.dart';
import 'package:test_flutter/Features/search/widget/searched_product.dart';
import 'package:test_flutter/common/widgets/loader.dart';
import 'package:test_flutter/constants/global_variables.dart';
import 'package:test_flutter/models/product.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchService searchServices = SearchService(); 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSearchedProduct();
  }
  Future<void> fetchSearchedProduct()async {
    products = await searchServices.fetchSearchedProduct(
      context: context,
      searchQuery: widget.searchQuery);
      setState(() {
        
      });
  }
   void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
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
                 margin: const EdgeInsets.only(left: 0,right: 10),
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
      body:products==null? Loader(): Column(
        children: [
          const AddressBox(),
          const SizedBox(height: 10,),
          Expanded(child: ListView.builder(
            itemCount: products?.length,
            itemBuilder: (context, index){
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.routeName, arguments: products![index]);
                },
                child: SearchedProduct(
                  product: products![index]),
              );
            },
            ))
        ],
      )
    );
  }
}