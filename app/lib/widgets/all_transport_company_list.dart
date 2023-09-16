
// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:app/controllers/top_up_transport_wallet_controller.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/border_radius.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransportCompanyListModalSheet extends StatefulWidget {
  final void Function(String)? onTransportCompanySelected;
  final List<String> allTransportCompany;
  final String? initialSelectedTransportCompany;

  TransportCompanyListModalSheet({
    this.onTransportCompanySelected,
    required this.allTransportCompany,
    this.initialSelectedTransportCompany,
  });

  @override
  _TransportCompanyListModalSheetState createState() => _TransportCompanyListModalSheetState();
}

class _TransportCompanyListModalSheetState extends State<TransportCompanyListModalSheet> {
  late TextEditingController searchController;
  List<String> filteredTransportCompany = [];
  final controller = Get.put(TopUpTransportWalletController());

  @override
  void initState() {
    super.initState();
    print("All transport: ${controller.allTransportCompany}");
    searchController = TextEditingController();
    filteredTransportCompany.addAll(widget.allTransportCompany);
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
                    hintText: "Search Transport Company",
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
                      filteredTransportCompany = widget.allTransportCompany
                          .where((bank) =>
                              bank.toLowerCase().contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredTransportCompany.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredTransportCompany[index]),
                      onTap: () {
                        if (widget.onTransportCompanySelected != null) {
                          widget.onTransportCompanySelected!(filteredTransportCompany[index]);
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


