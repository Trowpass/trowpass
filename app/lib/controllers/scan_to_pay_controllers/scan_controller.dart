import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanController extends GetxController {
  Rx<Barcode?> result = Rx<Barcode?>(null);

  void setResult(Barcode? newResult) {
    result.value = newResult;
  }
}
