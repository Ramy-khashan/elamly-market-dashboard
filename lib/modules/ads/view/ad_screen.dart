import 'package:elamlymarket_dashboard/core/widgets/loading_item.dart';
import 'package:elamlymarket_dashboard/modules/ads/controller/ads_cubit.dart';
import 'package:elamlymarket_dashboard/modules/ads/view/widgets/add_edit_ad_dialog.dart';
import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/delete_dialog.dart';
import '../../../core/widgets/drawer_item.dart';
import '../../../core/widgets/head_title.dart'; 

class AdScreen extends StatelessWidget {
  const AdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<AdsCubit>(context)..getAds() ,
      child: Scaffold(
          appBar: AppBar(),
          drawer: const DrawerItem(),
          body: Column(
            children: [
              HeadTitleItem(
                title: "Ads",
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => const AddEditAdDilaog());
                },
              ),
              Expanded(
                child: BlocBuilder<AdsCubit, AdsState>(
                  builder: (context, state) {
                    final controller = AdsCubit.get(context);
                    return  Center(
                      child: controller.isLoading
                          ? const LoadingItem()
                          : controller.isFailed
                              ? const Text("Failed To Get Ads",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold))
                              :controller.adsItems.isEmpty
                              ? const Text("No Ads Exist",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold))
                              : ExpandableTheme(
                                  data: ExpandableThemeData(
                                    context,
                                    contentPadding: const EdgeInsets.all(20),
                                    expandedBorderColor: Colors.transparent,
                                    paginationSize: 48,
                                    headerHeight: 56,
                                    headerColor: Colors.grey.shade300,
                                    headerBorder: const BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    rowBorder: const BorderSide(
                                      color: Colors.black,
                                      width: 0.3,
                                    ),
                                    editIcon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    headerTextMaxLines: 4,
                                    headerSortIconColor: const Color(0xFF6c59cf),
                                    paginationSelectedFillColor:
                                        const Color(0xFF6c59cf),
                                    paginationSelectedTextColor: Colors.white,
                                  ),
                                  child: ExpandableDataTable(
                                    headers: controller.headers,
                                    rows: controller.rows,
                                    multipleExpansion: true,
                                    isEditable: true,
                                    renderEditDialog: (row, onSuccess) {
                                      return deleteDialog(onDelete: () {
                                        controller
                                            .deleteAd(controller.rows.indexOf(row));
                                      });
                                    },
                                    onRowChanged: (newRow) {
                                      debugPrint(newRow.cells[01].value);
                                    },
                                    onPageChanged: (page) {
                                      debugPrint(page.toString());
                                    },
                                    // renderEditDialog: (row, onSuccess) =>
                                    //     buildActionDialog(row, onSuccess),
                                    visibleColumnCount: controller.headers.length,
                                  ),
                                ),
                    );
                  },
                ),
              )
            ],
          ),
       
      ),
    );
  }
}
