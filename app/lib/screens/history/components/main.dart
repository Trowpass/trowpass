import 'package:flutter/material.dart';

import '../../../controllers/history_tab_controller.dart';
import '../../../shareds/utils/app_colors.dart';
import '../../../widgets/app_styles.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({
    super.key,
    required this.controller,
  });

  final HistoryTabController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton(
                  tooltip: 'Show filters',
                  onSelected: controller.filterList,
                  itemBuilder: (BuildContext context) {
                    return controller.filterTypes.map((selectedType) {
                      return PopupMenuItem(
                        value: selectedType,
                        child: Text(
                          selectedType,
                          style: appStyles(12, gray, FontWeight.normal),
                        ),
                      );
                    }).toList();
                  },
                  child: TextButton.icon(
                    icon: const Icon(
                      Icons.filter_alt_outlined,
                      size: 24,
                    ),
                    label: Text(
                      'Filter',
                      style: appStyles(12, gray, FontWeight.normal),
                    ),
                    onPressed: null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
