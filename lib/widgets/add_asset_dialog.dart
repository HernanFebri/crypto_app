import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_crypto_app/services/http_service.dart';

class AddAssetDialogController extends GetxController {
  RxBool loading = false.obs;
  RxList<dynamic> assets = <dynamic>[].obs;
  RxString selectedAsset = ''.obs; // Untuk menyimpan nilai aset yang dipilih

  @override
  void onInit() {
    super.onInit();
    _getAssets();
  }

  Future<void> _getAssets() async {
    loading.value = true;
    HttpService httpService = Get.find<HttpService>();
    try {
      var responseData = await httpService.get("currencies");
      assets.value =
          responseData['data']; // Asumsikan respons API memiliki field 'data'
    } catch (e) {
      Get.snackbar("Error", "Failed to load assets");
    } finally {
      loading.value = false;
    }
  }

  void setSelectedAsset(String value) {
    selectedAsset.value = value;
  }
}

class AddAssetDialog extends StatelessWidget {
  final AddAssetDialogController controller =
      Get.put(AddAssetDialogController());

  AddAssetDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: Material(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.40,
            width: MediaQuery.of(context).size.width * 0.80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: _buildUI(),
          ),
        ),
      ),
    );
  }

  Widget _buildUI() {
    if (controller.loading.isTrue) {
      return const Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(),
        ),
      );
    } else if (controller.assets.isEmpty) {
      return const Center(
        child: Text("No assets found"),
      );
    } else {
      return DropdownButton<String>(
        value: controller.selectedAsset.value.isEmpty
            ? null
            : controller.selectedAsset.value,
        hint: const Center(child: Text("Select an asset")),
        items: controller.assets.map((asset) {
          return DropdownMenuItem<String>(
            value: asset['symbol'], // Ubah sesuai dengan struktur data dari API
            child: Text(
                asset['name']), // Ubah sesuai dengan struktur data dari API
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            controller.setSelectedAsset(value);
          }
        },
        isExpanded: true, // Agar dropdown menyesuaikan lebar kontainer
      );
    }
  }
}
