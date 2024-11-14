import 'package:elamlymarket_dashboard/modules/admins/view/admins_screen.dart';
import 'package:elamlymarket_dashboard/modules/categories/view/category_screen.dart';
import 'package:elamlymarket_dashboard/modules/home/view/home_screen.dart';
import 'package:elamlymarket_dashboard/modules/orders/view/order_screen.dart';
import 'package:elamlymarket_dashboard/modules/products/view/product_screen.dart';
import 'package:elamlymarket_dashboard/modules/reports/view/reports_screen.dart';
import 'package:elamlymarket_dashboard/modules/users/view/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/controllers/menu_controller_cubit.dart';
import '../../modules/ads/view/ad_screen.dart';
import '../../modules/deliveries/view/deliveries_screen.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenucontrollerCubit()..getUserInfo(),
      child: Drawer(
        child: BlocBuilder<MenucontrollerCubit, MenucontrollerState>(
          builder: (context, state) {
            final controller = MenucontrollerCubit.get(context);
            return Column(
              children: [
                DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        child: Icon(
                          Icons.person,
                          size: 50,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(controller.name.toString()),
                      Text(controller.role.toString()),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("Home"),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.store),
                  title: const Text("Products"),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductScreen(),
                        ));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.category),
                  title: const Text("Categories"),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CategoryScreen(),
                        ));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.ads_click),
                  title: const Text("Ads"),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdScreen(),
                        ));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.shopping_bag),
                  title: const Text("Orders"),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OrdersScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.report),
                  title: const Text("Reports"),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReportsScreen()));
                  },
                ),  ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Users"),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UsersScreen()));
                  },
                ),  ListTile(
                  leading: const Icon(Icons.admin_panel_settings_rounded),
                  title: const Text("Admins"),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminsScreen()));
                  },
                ),  ListTile(
                  leading: const Icon(Icons.delivery_dining),
                  title: const Text("Deliveries"),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DeliveriesScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout_rounded),
                  title: const Text("Log Out"),
                  onTap: () {
                    controller.logOut();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
