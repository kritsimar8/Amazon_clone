

import 'package:flutter/material.dart';
import 'package:test_flutter/Features/auth/services/auth_service.dart';
import 'package:test_flutter/common/widgets/custom_button.dart';
import 'package:test_flutter/common/widgets/custom_textfield.dart';
import 'package:test_flutter/constants/global_variables.dart';
import 'package:http/http.dart' as http;

enum Auth{
  signin,
  signup
}



class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  
 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  Future<void> signUpUser()async {
   await authService.signUpUser(context: context,
     email: _emailController.text,
      password: _passwordController.text,
       name: _nameController.text
    );
  }
  Future<void> signInUser()async {
   await authService.signInUser(context: context,
     email: _emailController.text,
      password: _passwordController.text,
       
    );
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3001/test'));
    if (response.statusCode == 200){
      print(response.statusCode);
      print(response.body);
    } else {
      throw Exception("Failed call");
    }
  }




  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ListTile(
                  tileColor: _auth == Auth.signup ? GlobalVariables.backgroundColor : GlobalVariables.greyBackgroundCOlor,
                  title: const Text('Create Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signup,
                     groupValue: _auth,
                      onChanged: (Auth? val){
                        setState(() {
                          _auth = val!;
                        });
                      }),
                ),
                if(_auth == Auth.signup)
                 Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                   child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        CustomTextfield(controller: _nameController,hintText: 'Name',),
                        SizedBox(height: 10,),
                        CustomTextfield(controller: _emailController,hintText: 'Email',),
                        SizedBox(height: 10,),
                        CustomTextfield(controller: _passwordController,hintText: 'Password',),
                        SizedBox(height: 10,),
                        CustomButton(text: 'Sign Up',
                         onTap: (){
                          if(_signUpFormKey.currentState!.validate()){
                           signUpUser();
                          }
                         })
                      ],
                    ),
                    ),
                 ),
                ListTile(
                  title: const Text('Sign-In',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signin,
                     groupValue: _auth,
                      onChanged: (Auth? val){
                        setState(() {
                          _auth = val!;
                        });
                      }),
                ),
                  if(_auth == Auth.signin)
                 Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                   child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        CustomTextfield(controller: _emailController,hintText: 'Email',),
                        SizedBox(height: 10,),
                        CustomTextfield(controller: _passwordController,hintText: 'Password',),
                        SizedBox(height: 10,),
                        CustomButton(text: 'Sign In',
                         onTap: (){
                          if(_signInFormKey.currentState!.validate()){
                            signInUser();
                          }
                         })
                      ],
                    ),
                    ),
                 ),
              ],
            ),
          )
        ],
      )),
    );
  }
}