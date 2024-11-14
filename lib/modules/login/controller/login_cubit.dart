import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket_dashboard/core/constant/storage_key.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/utils/notification_services.dart';
import '../../../core/widgets/toast_app.dart';
import '../../../main.dart';
import '../../home/view/home_screen.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial()) {
    getToken();
  }
  static LoginCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  bool isLoadingLogin = false;
  showPassword() {
    emit(LoginInitial());
    hidePassword = !hidePassword;
    emit(TogglePasswordState());
  }

  login() async {
    isLoadingLogin = true;
    emit(LoadingLoginState());
    await FirebaseFirestore.instance
        .collection("admin")
        .where("email", isEqualTo: emailController.text.trim().toLowerCase())
        .get()
        .then((value) async {
      if (value.docs.first.get('password') == passwordController.text.trim()) {
        isLoadingLogin = false;
        emit(SuccessLoginState());
        FirebaseFirestore.instance
            .collection("admin")
            .doc(value.docs.first.get('id'))
            .update({
          "token": registerToken,
        });
        FlutterSecureStorage storage = const FlutterSecureStorage();
        await storage.write(
            key: StorageKey.email, value: value.docs.first.get("email"));
        await storage.write(key: StorageKey.email, value: registerToken);
        await storage.write(
            key: StorageKey.id, value: value.docs.first.get("id"));
        await storage.write(
            key: StorageKey.name, value: value.docs.first.get("name"));
        await storage.write(
            key: StorageKey.role, value: value.docs.first.get("role"));
        await storage.write(key: StorageKey.isLogin, value: "true");
        Navigator.push(MarketDashboard.navigatorKey.currentContext!,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        isLoadingLogin = false;
        emit(FailedLoginState());

        toastApp(message: "Email Or Password Wrong!");
      }
    }).onError((error, stackTrace) {
      isLoadingLogin = false;
      emit(FailedLoginState());

      debugPrint(error.toString());

      toastApp(message: "Email not found!");
    });
  }

  String? registerToken = "";
  getToken() async {
    WidgetsFlutterBinding.ensureInitialized();
    await [Permission.notification].request();
    try {
      NotificationService().initNotification();

      registerToken = await FirebaseMessaging.instance.getToken();
      FirebaseMessaging.instance.subscribeToTopic("market");
      debugPrint(registerToken);
      FirebaseMessaging.onMessage.listen((event) async {
        String? title = event.notification?.title;
        String? body = event.notification?.body;

        await NotificationService().showNotification(
            Random().nextInt(10000) * Random().nextInt(10000),
            title ?? "",
            body ?? "");
      });

      FirebaseMessaging.onMessageOpenedApp.listen((event) {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
