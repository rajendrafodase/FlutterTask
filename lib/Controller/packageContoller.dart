

import '../Constant/component.dart';
import 'package:http/http.dart'as http;

class PackageController extends GetxController {
  var isLoading = true.obs;
  var packageList = <Package>[].obs;

  // ConnectionManagerController connectionManagerController = Get.put(ConnectionManagerController());



  @override
  void onInit() {

      getData();
    super.onInit();
  }

  void getData() async {

    try {
      var data = await getPackage();
      if (data != null) {
        packageList.value = data.response;
      }
    } finally {
      // isLoading(false);
    }
  }







  Future<PackageList> getPackage() async {
    final response = await http.post(
      Uri.parse(ApiEndPoints.packageList), // Convert the data to JSON
    );
    if (response.statusCode == 200) {
      return PackageList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data ${response.statusCode}');
    }
  }

}