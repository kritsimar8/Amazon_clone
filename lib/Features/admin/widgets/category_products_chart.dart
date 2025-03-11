import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_flutter/Features/admin/models/sales.dart';



class CategoryProductsChart extends StatelessWidget {
  final List<Sales>? seriesList;
  const CategoryProductsChart({super.key, required this.seriesList});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(),
        series: <CartesianSeries>[
          ColumnSeries<Sales,String>(
            dataSource: seriesList,
            xValueMapper: (Sales data, _)=> data.label,
             yValueMapper: (Sales data, _)=> data.earning,
             )
        ],
      )
    );
  }
}

