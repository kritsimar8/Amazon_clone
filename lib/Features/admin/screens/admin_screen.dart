import 'package:flutter/material.dart';
import 'package:test_flutter/Features/account/screens/account_screen.dart';
import 'package:test_flutter/Features/admin/screens/analytics_screen.dart';
import 'package:test_flutter/Features/admin/screens/order_screen.dart';
import 'package:test_flutter/Features/admin/screens/posts_screen.dart';
import 'package:test_flutter/Features/home/screens/home_screen.dart';
import 'package:test_flutter/constants/global_variables.dart';
import 'package:badges/badges.dart' as customBadge;

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});
  
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
   int _page =0;
   double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;


  List<Widget> pages =[
    PostsScreen(),
     AnalyticsScreen(),
     OrdersScreen()
  ];


  void updatePage(int page){
    setState(() {
      _page = page;
    });
  }
  @override
  Widget build(BuildContext context) {
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
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
             const Text(
              'Admin',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
             )
             ],
          ),
         )),
          body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page, 
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(icon: Container(
            width: bottomBarWidth,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: _page==0 ?
                  GlobalVariables.selectedNavBarColor
                  : GlobalVariables.backgroundColor,
                  width: bottomBarBorderWidth
                )
              )
            ),
            child: const Icon(
              Icons.home_outlined
            ),
          ),
          label: ''
          ),
          BottomNavigationBarItem(icon: Container(
            width: bottomBarWidth,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: _page==1 ?
                  GlobalVariables.selectedNavBarColor
                  : GlobalVariables.backgroundColor,
                  width: bottomBarBorderWidth
                )
              )
            ),
            child: const Icon(
              Icons.analytics_outlined
            ),
          ),
          label: ''
          ),
          BottomNavigationBarItem(icon: Container(
            width: bottomBarWidth,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: _page==2 ?
                  GlobalVariables.selectedNavBarColor
                  : GlobalVariables.backgroundColor,
                  width: bottomBarBorderWidth
                )
              )
            ),
            child: customBadge.Badge(
              badgeContent: const Text('2'),
              badgeStyle: customBadge.BadgeStyle(
                badgeColor: Colors.white
              ),
              child: const Icon(
                Icons.all_inbox_outlined
              ),
            ),
          ),
          label: ''
          )
        ],
      ),
    );
    
  }
}