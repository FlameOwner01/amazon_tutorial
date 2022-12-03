import 'package:amazaon_tutorial/common/widgets/loader.dart';
import 'package:amazaon_tutorial/features/admin/models/sales.dart';
import 'package:amazaon_tutorial/features/admin/services/admin_services.dart';
import 'package:amazaon_tutorial/features/admin/widgets/category_products_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class AnaltyicsScreen extends StatefulWidget {
  const AnaltyicsScreen({Key? key}) : super(key: key);

  @override
  State<AnaltyicsScreen> createState() => _AnaltyicsScreenState();
}

class _AnaltyicsScreenState extends State<AnaltyicsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;
  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Text(
                "\$$totalSales",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 250,
                child: CategoryProductsChart(
                  seriesList: [
                    charts.Series(
                      id: "Sales",
                      data: earnings!,
                      domainFn: (Sales sales, _) => sales.label,
                      measureFn: (Sales sales, _) => sales.earning,
                    )
                  ],
                ),
              )
            ],
          );
  }
}
