import 'package:app/screens/history/components/empty.dart';
import 'package:app/screens/history/components/main.dart';
import 'package:app/widgets/history_list_loading.dart';
import 'package:app/widgets/list_shimmer_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/history_tab_controller.dart';
import '../../shareds/utils/app_colors.dart';
import '../../shareds/utils/images.dart';
import '../../widgets/app_styles.dart';

class TransactionHistoryScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  TransactionHistoryScreen();
  final controller = Get.put(HistoryTabController());

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    String? selectedItem;

    return DefaultStickyHeaderController(
      child: Scaffold(
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
                icon: SvgPicture.asset(notificationIcon),
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
          body: Obx(() => _getScaffoldBody())),
    );
  }

  Widget _getScaffoldBody() {
    var isProcessing = controller.isLoading.value;
    var isListEmpty = controller.historyItems.isEmpty;

    return isProcessing
        ? ShimmerLoading(
            itemCount: 10,
            loadingPlaceholder: const HistoryListLoading(),
          )
        : isListEmpty
            ? const EmptyWidget()
            : MainWidget(controller: controller);
  }
}
