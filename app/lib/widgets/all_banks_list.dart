
// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_key_in_widget_constructors

import 'package:app/controllers/top_up_transport_wallet_controller.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/border_radius.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankListModalSheet extends StatefulWidget {
  final void Function(String)? onBankSelected;
  final List<String> allBanks;
  final String? initialSelectedBank;

  BankListModalSheet({
    this.onBankSelected,
    required this.allBanks,
    this.initialSelectedBank,
  });

  @override
  _BankListModalSheetState createState() => _BankListModalSheetState();
}

class _BankListModalSheetState extends State<BankListModalSheet> {
  late TextEditingController searchController;
  List<String> filteredBanks = [];
  final controller = Get.put(TopUpTransportWalletController());

  @override
  void initState() {
    super.initState();
    print("All Banks in TopUpScreen: ${controller.allBanks}");
    searchController = TextEditingController();
    filteredBanks.addAll(widget.allBanks);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Center(
        child: Container(
          height: 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    // suffixIcon: suffixIcon,
                    labelStyle: appStyles(15, null, null),
                    hintText: "Search Banks",
                    // errorText: textError,
                    errorStyle: appStyles(null, validationErrorColor, null),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      borderSide: const BorderSide(color: border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      borderSide: const BorderSide(color: border),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      borderSide: const BorderSide(color: border),
                    ),
                    filled: true,
                    fillColor: border,
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      filteredBanks = widget.allBanks
                          .where((bank) =>
                              bank.toLowerCase().contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredBanks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredBanks[index]),
                      onTap: () {
                        if (widget.onBankSelected != null) {
                          widget.onBankSelected!(filteredBanks[index]);
                          // Navigator.pop(context); // Close the modal sheet
                        }
                      },
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


