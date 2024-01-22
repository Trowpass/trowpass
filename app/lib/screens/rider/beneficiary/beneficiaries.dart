import 'package:app/screens/rider/beneficiary/add_beneficiary.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controllers/rider/heneficiaries_controller.dart';

class BeneficiariesScreen extends StatelessWidget {
  BeneficiariesScreen({super.key});
  final controller = Get.put(BeneficiariesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: background,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: primaryColor,
            statusBarBrightness: Brightness.light, // For iOS
            statusBarIconBrightness: Brightness.light, // For Android
            systemNavigationBarColor: navigationBarBackground,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
          title: Text(controller.title.value),
          centerTitle: true,
          backgroundColor: primaryColor,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 15),
              child: GestureDetector(
                  onTap: () => Get.to(AddBeneficiaryScreen()),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text('Add', style: appStyles(16, null, FontWeight.bold)),
                      const Icon(Icons.add)
                    ],
                  )),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    color: Colors.white,
                    elevation: 1,
                    shadowColor: titleActive,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        child: ClipOval(
                          child: Text(
                            controller.nameAbbreviation.value,
                            style: appStyles(16, Colors.white, null),
                          ),
                        ),
                      ),
                      title: Text(controller.beneficiaryName.value),
                      subtitle: Text(controller.accountNumber.value),
                    ),
                  ),
                );
              }),
        ));
  }
}
