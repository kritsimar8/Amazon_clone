import 'package:flutter/material.dart';
import 'package:test_flutter/Features/account/widgets/single_product.dart';
import 'package:test_flutter/Features/admin/screens/add_product_screen.dart';
import 'package:test_flutter/Features/admin/services/admin_services.dart';
import 'package:test_flutter/common/widgets/loader.dart';
import 'package:test_flutter/models/product.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  
  List<Product>? products;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchallProducts();
  }

  fetchallProducts() async {
   products = await adminServices.fetchAllProducts(context);
   setState(() {
     
   });
  }
  void deleteProduct(Product product , int index) async {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: (){
        products!.removeAt(index);
        setState(() {
          
        });
      });
  }


  void navigateToAddProduct(){
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }


  @override
  Widget build(BuildContext context) {
    return products== null ? Loader():Scaffold(
      body: GridView.builder(
        itemCount: products!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2), itemBuilder: (context,index){
          final productData = products![index];
          print(productData.images[0]);
          return Column(
            children: [
              SizedBox(
                height: 120,
                child: SingleProduct(image: productData.images[0]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Text(
                    productData.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )),
                  IconButton(onPressed: ()=> deleteProduct(productData, index), 
                  icon: Icon(Icons.delete_outline))
                ],
              )
            ],
          );
        }),
      floatingActionButton: FloatingActionButton(
        
        backgroundColor: Colors.cyan,
        onPressed: navigateToAddProduct,
        tooltip: 'Add a Product',
        child: const Icon(Icons.add),
        
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}