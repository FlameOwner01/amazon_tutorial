import 'package:amazaon_tutorial/features/admin/models/sales.dart';
import 'package:flutter/material.dart';
import "package:charts_flutter/flutter.dart" as charts;

class CategoryProductsChart extends StatelessWidget {
  final List<charts.Series<Sales, String>> seriesList;
  const CategoryProductsChart({super.key, required this.seriesList});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }
}
