import 'package:elamlymarket_dashboard/modules/admins/controller/admins_cubit.dart';
import 'package:elamlymarket_dashboard/modules/home/view/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/controllers/menu_controller_cubit.dart';
import 'core/utils/notification_services.dart';
import 'firebase_options.dart';
import 'modules/ads/controller/ads_cubit.dart';
import 'modules/deliveries/controller/deliveries_cubit.dart';
import 'modules/login/view/login_screen.dart';
import 'modules/orders/controller/orders_cubit.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  NotificationService().initNotification();
  MarketDashboard.navigatorKey = GlobalKey<NavigatorState>();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MarketDashboard());
}

class MarketDashboard extends StatelessWidget {
  const MarketDashboard({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => MenucontrollerCubit()
                ..getUserInfo()
                ..initNotification()),
          // BlocProvider(create: (context) => ProductCubit()),
          BlocProvider(create: (context) => OrdersCubit()),
          BlocProvider(create: (context) => AdminsCubit()),
          BlocProvider(
            create: (context) => AdsCubit()..getAds(),
          ),
          BlocProvider(create: (context) => DeliveriesCubit()..getDeliveries()),
          // BlocProvider(
          //   create: (context) => DeliveriesCubit(),
          // ),
        ],
        child: BlocBuilder<MenucontrollerCubit, MenucontrollerState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Elamly Market Dashboard',
              navigatorKey: navigatorKey,
              theme: ThemeData(
                useMaterial3: true,
              ),
              home: BlocProvider.of<MenucontrollerCubit>(context).isLogin ==
                      "true"
                  ? const HomeScreen()
                  : const LoginScreen(),
            );
          },
        ));
  }
}
