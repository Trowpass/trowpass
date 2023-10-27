import 'package:app/extensions/strict_nulls_extension.dart';
import 'package:app/screens/history/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../../../controllers/history/history_tab_controller.dart';
import '../../../shareds/utils/app_colors.dart';
import '../../../widgets/app_styles.dart';
import '../../../widgets/history_list_item.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({
    super.key,
    required this.controller,
  });

  final HistoryTabController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          CustomScrollView(
            slivers: _buildSlivers(),
            reverse: false,
          ),
          Row(
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
                    style: appStyles(14, gray, FontWeight.normal),
                  ),
                  onPressed: null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSlivers() {
    final sliverList = <Widget>[];

    if (controller.isHistorySorted.value && controller.historyItems.isNotEmpty) {
      sliverList.add(_buildSortedList(controller.selectedFilterType.value ?? 'New to Old'));
    } else {
      if (controller.todayTransaction.isNotEmpty) {
        sliverList.add(_buildTodayList());
      }

      if (controller.earlierTransaction.isNotEmpty) {
        sliverList.add(_buildEarlierList());
      }
    }

    return sliverList;
  }

  Widget _buildEarlierList() {
    return SliverStickyHeader(
      header: const Header(
        title: 'Earlier',
        color: background,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => HistoryListItem(controller.earlierTransaction[index]),
          childCount: controller.earlierTransaction.length,
        ),
      ),
    );
  }

  Widget _buildTodayList() {
    return SliverStickyHeader(
      header: const Header(
        title: 'Today',
        color: background,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => HistoryListItem(controller.todayTransaction[index]),
          childCount: controller.todayTransaction.length,
        ),
      ),
    );
  }

  Widget _buildSortedList(String headerText) {
    return SliverStickyHeader(
      header: Header(
        title: headerText,
        color: background,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => HistoryListItem(controller.historyItems[index]),
          childCount: controller.historyItems.length,
        ),
      ),
    );
  }
}
