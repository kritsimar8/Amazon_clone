import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/Features/Product_details/services/product_detail_services.dart';
import 'package:test_flutter/Features/search/screens/search_screen.dart';
import 'package:test_flutter/common/widgets/custom_button.dart';
import 'package:test_flutter/common/widgets/stars.dart';
import 'package:test_flutter/constants/global_variables.dart';
import 'package:test_flutter/models/product.dart';
import 'package:test_flutter/providers/user_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailServices _productDetailServices = ProductDetailServices();
  
  double avgRating = 0;
  double myRating =0;

  @override 
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i=0; i<widget.product.rating!.length; i++){
      totalRating += widget.product.rating![i].rating;
      if(widget.product.rating![i].userId == Provider.of<UserProvider>(context,listen: false).user.id){
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating!=0){
      avgRating = totalRating / widget.product.rating!.length;
    }


  }
  
  void addToCart() {
    _productDetailServices.addToCart(
      context: context, product: widget.product);
  }
  
  
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 5, right: 10),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Color.fromARGB(108, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Icon(Icons.mic, color: Colors.black, size: 25),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(widget.product.id!), Stars(rating: avgRating)],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text(widget.product.name, style: TextStyle(fontSize: 15)),
            ),
            CarouselSlider(
              items:
                  widget.product.images.map((i) {
                    return Builder(
                      builder:
                          (BuildContext context) =>
                              Image.network(i, fit: BoxFit.contain, height: 200),
                    );
                  }).toList(),
              options: CarouselOptions(viewportFraction: 1, height: 200),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(padding: const EdgeInsets.all(8),
            child: RichText(text: TextSpan(
              text: 'Deal Price:',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
              text: ' \$${widget.product.price}',
              style: const TextStyle(
                fontSize: 22,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              )
            )
              ]
            )),
            ),
            Padding(padding: const EdgeInsets.all(8.0),
            child: Text(widget.product.description),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(text: 'Buy Now',
             
               onTap: (){}),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(text: 'Add To Cart',
               onTap: addToCart,
               color: const Color.fromRGBO(254, 216, 19, 1),
               ),
            ),
            const SizedBox(height: 10,),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text("Rate The Product",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),
            ),
            ),
            RatingBar.builder(
              initialRating: myRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 5),
              itemBuilder: (context,_) => const Icon(Icons.star,color: GlobalVariables.secondaryColor,),
             onRatingUpdate: (rating){
              _productDetailServices.rateProduct(context: context,
              product: widget.product, rating: rating);
             }),
             SizedBox(height: 20,)
          ],
        ),
        
      ),
    );
  }
}
