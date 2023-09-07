import 'package:app/screens/history/list_item.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/history_tab_controller.dart';
import '../../shareds/utils/app_colors.dart';
import '../../widgets/app_styles.dart';

class HistoryScreen extends GetView<HistoryTabController> {
  // ignore: use_key_in_widget_constructors
  const HistoryScreen();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    String? selectedItem;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarBrightness: Brightness.light, // For iOS
          statusBarIconBrightness: Brightness.light, // For Android
          systemNavigationBarColor: navigationBarBackground,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        backgroundColor: background,
        elevation: 0.0,
        title: Text(
          controller.title,
          style: appStyles(18, titleActive, FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              Get.back();
            },
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: Row(
              children: <Widget>[
                Obx(
                  () => Text(
                    controller.period.value,
                    style: appStyles(14, titleActive, FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PopupMenuButton(
                        tooltip: 'Show filters',
                        child: TextButton.icon(
                          icon: Image.asset(configure),
                          label: Text(
                            'Filter',
                            style: appStyles(12, gray, FontWeight.normal),
                          ),
                          onPressed: null,
                        ),
                        onSelected: (value) {
                          selectedItem = value;
                        },
                        itemBuilder: (BuildContext context) {
                          return controller.filterTypes.map((selectedType) {
                            return PopupMenuItem(
                              value: selectedType,
                              child: Text(
                                selectedType,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(14),
              controller: controller.scrollController,
              itemCount: controller.historyItems.length,
              // physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                var history = controller.historyItems[index];
                return history == null
                    ? Padding(
                        padding: const EdgeInsets.all(14),
                        child: Text(
                          'Earlier',
                          style: appStyles(12, titleActive, FontWeight.bold),
                        ),
                      )
                    : HistoryListItem(history);
              },
            ),
          ),
        ],
      ),
    );
  }
}
