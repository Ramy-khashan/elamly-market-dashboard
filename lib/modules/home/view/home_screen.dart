import 'package:elamlymarket_dashboard/core/widgets/loading_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../core/widgets/drawer_item.dart';
import '../controller/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getData(),
      child: Scaffold(
        drawer: const DrawerItem(),
        appBar: AppBar(),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final controller = HomeCubit.get(context);
            return Center(
              child: controller.isLoading
                  ? const LoadingItem()
                  : SingleChildScrollView(
                    child: Column(
                        children: [
                          Card(
                            child: ListTile(
                              leading: const Icon(Icons.person),
                              title: const Text("All Users"),
                              trailing: Text(controller.allUsersCount.toString()),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              leading: const Icon(Icons.delivery_dining_outlined),
                              title: const Text("All Deliveries"),
                              trailing:
                                  Text(controller.allDeliveriesCount.toString()),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              leading: const Icon(Icons.person),
                              title: const Text("All Reports"),
                              trailing:
                                  Text(controller.allReportsCount.toString()),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              leading: const Icon(Icons.person),
                              title: const Text("All Order"),
                              trailing:
                                  Text(controller.allOrdersCount.toString()),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              leading: const Icon(Icons.shopping_bag_outlined),
                              title: const Text("All Products"),
                              trailing:
                                  Text(controller.allProductsCount.toString()),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: PieChart(
                              dataMap: {
                                "Pending Orders": double.parse(
                                    controller.allPendingOrdersCount.toString()),
                                "Canceled Order": double.parse(
                                    controller.allCanceledOrdersCount.toString()),
                                "Delivered Order": double.parse(controller
                                    .allDeliveredOrdersCount
                                    .toString()),
                              },
                              animationDuration:
                                  const Duration(milliseconds: 800),
                              chartLegendSpacing: 32,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.2,
                              colorList: [
                                Colors.yellow.shade600,
                                Colors.red.shade600,
                                Colors.green.shade600,
                              ],
                              initialAngleInDegree: 0,
                              chartType: ChartType.ring,
                              ringStrokeWidth: 40,
                              centerText: "Orders",
                              legendOptions: const LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: LegendPosition.right,
                                showLegends: true,
                                legendShape: BoxShape.circle,
                                legendTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValueBackground: true,
                                showChartValues: true,
                                showChartValuesInPercentage: false,
                                showChartValuesOutside: false,
                                decimalPlaces: 1,
                              ),
                              // gradientList: ---To add gradient colors---
                              // emptyColorGradient: ---Empty Color gradient---
                            ),
                          )
                        ],
                      ),
                  ),
            );
          },
        ),
      ),
    );
  }
}
