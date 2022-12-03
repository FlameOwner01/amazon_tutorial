import 'package:amazaon_tutorial/common/widgets/loader.dart';
import 'package:amazaon_tutorial/constants/global_variables.dart';
import 'package:amazaon_tutorial/features/account/services/account_services.dart';
import 'package:amazaon_tutorial/features/account/widgets/single_product.dart';
import 'package:amazaon_tutorial/models/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;

  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOders();
    setState(() {});
  }

  void fetchOders() async {
    orders = await accountServices.fetchMyOrders(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      "Your orders:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 17,
                        color: GlobalVariables.selectedNavBarColor,
                      ),
                    ),
                  ),
                  // display orders
                ],
              ),
              Container(
                height: 170,
                padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: orders!.length,
                  itemBuilder: (context, index) {
                    return SingleProduct(
                      image: orders![index].products[0].images[0],
                    );
                  },
                ),
              ),
            ],
          );
  }
}
