// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/border_radius.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/bank_list_loading.dart';
import 'package:app/widgets/list_shimmer_loader.dart';
import 'package:flutter/material.dart';

class ExpenseTypeModalSheet extends StatefulWidget {
  final void Function(String)? onExpenseSelected;
  final List<String> allExpenseTypes;
  final String? initialSelectedType;

  ExpenseTypeModalSheet({
    this.onExpenseSelected,
    required this.allExpenseTypes,
    this.initialSelectedType,
  });

  @override
  _BankListModalSheetState createState() => _BankListModalSheetState();
}

class _BankListModalSheetState extends State<ExpenseTypeModalSheet> {
  late TextEditingController searchController;
  List<String> filteredExpenseTypes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    filteredExpenseTypes.addAll(widget.allExpenseTypes);
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Center(
        child: Container(
          height: 800,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: isLoading
              ? ShimmerLoading(
                  itemCount: 10,
                  loadingPlaceholder: const BankListLoading(),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () => searchController.clear(),
                              icon: Icon(Icons.cancel)),
                          labelStyle: appStyles(15, null, null),
                          hintText: "Search for an expense type",
                          errorStyle:
                              appStyles(null, validationErrorColor, null),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius),
                            borderSide: const BorderSide(color: search),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius),
                            borderSide: const BorderSide(color: search),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius),
                            borderSide: const BorderSide(color: search),
                          ),
                          filled: true,
                          fillColor: search,
                          prefixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        ),
                        onChanged: (value) {
                          setState(() {
                            filteredExpenseTypes = widget.allExpenseTypes
                                .where((bank) => bank
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredExpenseTypes.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 18.0, right: 18.0),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(filteredExpenseTypes[index]),
                                  onTap: () {
                                    if (widget.onExpenseSelected != null) {
                                      widget.onExpenseSelected!(
                                          filteredExpenseTypes[index]);
                                    }
                                  },
                                ),
                                Divider(
                                  color: search,
                                  thickness: 1.5,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
