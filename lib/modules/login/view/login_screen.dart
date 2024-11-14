import 'package:elamlymarket_dashboard/core/constant/app_colors.dart';
import 'package:elamlymarket_dashboard/core/utils/validate.dart';
import 'package:elamlymarket_dashboard/core/widgets/buttons.dart';
import 'package:elamlymarket_dashboard/core/widgets/loading_item.dart';
import 'package:elamlymarket_dashboard/core/widgets/responsive.dart';
import 'package:elamlymarket_dashboard/core/widgets/text_field_shape.dart';
import 'package:elamlymarket_dashboard/modules/login/controller/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const Expanded(
                child: Center(
                  child: Text(
                    "Welcome to Elamly Market",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  final controller = LoginCubit.get(context);
                  return Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: Responsive.isDesktop(context) ? 500 : 400,
                        child: Card(
                          elevation: 2,
                          margin: const EdgeInsets.all(10),
                          color: Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                                Responsive.isDesktop(context) ? 25 : 8.0),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormFieldShape(
                                      title: "Email",
                                      controller: controller.emailController,
                                      validate: (val) =>
                                          Validate.validateEmail(val)),
                                  TextFormFieldShape(
                                      title: "Password",
                                      hidePassword: controller.hidePassword,
                                      isPassword: true,
                                      onTapPassword: controller.showPassword,
                                      controller: controller.passwordController,
                                      validate: (val) =>
                                          Validate.notEmpty(val)),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  controller.isLoadingLogin
                                      ? const LoadingItem()
                                      : ButtonsWidget(
                                          onPressed: () {
                                            controller.login();
                                          },
                                          text: "Login",
                                          icon: Icons.login,
                                          backgroundColor:
                                              AppColor.primaryColor)
                                ]),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
