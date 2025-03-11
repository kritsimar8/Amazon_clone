import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/Features/address/services/address_services.dart';
import 'package:test_flutter/common/widgets/custom_button.dart';
import 'package:test_flutter/common/widgets/custom_textfield.dart';
import 'package:test_flutter/constants/global_variables.dart';
import 'package:test_flutter/constants/utils.dart';
import 'package:test_flutter/providers/user_provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  final AddressServices addressServices = AddressServices();
  String addressToBeUsed = '';
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pinCodeController.dispose();
    cityController.dispose();
  }
  void onPressed()async {
    addressServices.saveUserAddress(context: context, address: addressToBeUsed);
    addressServices.placeOrder(context: context, address: addressToBeUsed, 
    totalSum: double.parse(widget.totalAmount)
    );

  }
  void payPressed( String addressFromProvider){
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty || areaController.text.isNotEmpty || pinCodeController.text.isNotEmpty || cityController.text.isNotEmpty;

    if (isForm){
      if (_addressFormKey.currentState!.validate()){
        addressToBeUsed = '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pinCodeController.text}';
      } else {
        throw Exception("Please enter all the value!");
      }
    } else if (addressFromProvider.isNotEmpty){
      addressToBeUsed = addressFromProvider;
    }else {
      showSnackBar(context, 'ERROR');
    }
    onPressed();
  }
  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _addressFormKey,
            child: Column(
              children: [
                if(address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(address, style: TextStyle(
                          fontSize: 18
                        ),),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                    const SizedBox(height: 20,)
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 10),
                    CustomTextfield(
                      controller: flatBuildingController,
                      hintText: 'Flate, House no, Building',
                    ),
                    SizedBox(height: 10),
                    CustomTextfield(
                      controller: areaController,
                      hintText: 'Area, Street',
                    ),
                    SizedBox(height: 10),
                    CustomTextfield(
                      controller: pinCodeController,
                      hintText: 'Pincode',
                    ),
                    SizedBox(height: 10),
                    CustomTextfield(
                      controller: cityController,
                      hintText: 'Town/city',
                    ),
                    SizedBox(height: 10),
                    CustomButton(text: 'Place Order',
                     onTap:()=> payPressed(address))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
