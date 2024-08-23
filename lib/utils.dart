import 'package:get/get.dart';
import 'package:getx_crypto_app/services/http_service.dart';

Future<void> registerServices() async {
  Get.put(
    HttpService(),
  );
}
