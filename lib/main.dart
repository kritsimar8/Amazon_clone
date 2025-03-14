import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/Features/admin/screens/admin_screen.dart';
import 'package:test_flutter/Features/auth/screens/auth_screen.dart';
import 'package:test_flutter/Features/auth/services/auth_service.dart';
import 'package:test_flutter/Features/home/screens/home_screen.dart';
import 'package:test_flutter/common/widgets/bottom_bar.dart';
import 'package:test_flutter/constants/global_variables.dart';
import 'package:test_flutter/providers/user_provider.dart';
import 'package:test_flutter/router.dart';

void main() {
  runApp(MultiProvider(
    providers:[
      ChangeNotifierProvider(create: (context)=> UserProvider()),
      
    ],child: const MyApp()
    ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override 
  void initState(){
    super.initState();
    authService.getUserData(context: context);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor:  GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black
          )
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home:  Provider.of<UserProvider>(context).user.token.isNotEmpty ?
      Provider.of<UserProvider>(context).user.type=='user'? const BottomBar() : const AdminScreen(): AuthScreen()
      
    );
  }
}
