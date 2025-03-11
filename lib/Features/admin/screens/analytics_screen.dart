import 'package:flutter/material.dart';
import 'package:test_flutter/Features/admin/models/sales.dart';
import 'package:test_flutter/Features/admin/services/admin_services.dart';
import 'package:test_flutter/Features/admin/widgets/category_products_chart.dart';
import 'package:test_flutter/common/widgets/loader.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServicees = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServicees.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null ?
     const Loader() :
      Column(
        children: [
          Text(
            '\$$totalSales',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          CategoryProductsChart(seriesList: earnings)
        ],
      );
  }
}
