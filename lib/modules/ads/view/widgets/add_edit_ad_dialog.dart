import 'package:elamlymarket_dashboard/core/constant/app_colors.dart';
import 'package:elamlymarket_dashboard/core/widgets/buttons.dart';
import 'package:elamlymarket_dashboard/core/widgets/loading_item.dart';
import 'package:elamlymarket_dashboard/core/widgets/text_field_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/responsive.dart';
import '../../controller/ads_cubit.dart';

class AddEditAdDilaog extends StatelessWidget {
  const AddEditAdDilaog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<AdsCubit>(context) ,
      child: BlocBuilder<AdsCubit, AdsState>(
        builder: (context, state) {
          final controller = AdsCubit.get(context);
          return Container(
              alignment: Alignment.center,
              child: SizedBox(
                height: Responsive.isDesktop(context) ? 600 : 500,
                width: 400,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Add Ad Dilaog",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Ad Image:",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            Card(
                              margin: const EdgeInsets.all(5),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: InkWell(
                                onTap: () {
                                  controller.pickAdsMainImage();
                                },
                                child: SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: controller.imgEncoded == null
                                      ? const Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Icon(Icons.add),
                                        )
                                      : Image.memory(controller.imgEncoded!),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 300,
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormFieldShape(
                              hint: "Title",
                              controller: controller.adTitleController,
                              validate: (val) => null),
                        ),
                        controller.isLoadingAddAds
                            ? const LoadingItem()
                            : ButtonsWidget(
                                onPressed: () {
                                  controller.addAds();
                                },
                                text: "Add Ad",
                                icon: Icons.add,
                                backgroundColor: AppColor.primaryColor),
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
