

import '../Constant/component.dart';
import 'package:http/http.dart'as http;

class BookingController extends GetxController {
  var isLoading = true.obs;
  var bookingList = <Booking>[].obs;
  // ConnectionManagerController connectionManagerController = Get.put(ConnectionManagerController());





  @override
  void onInit() {
      getBookingData();
    super.onInit();
  }

  void getBookingData() async {

    try {
      var datas = await getbooking();
      if (datas != null) {
        bookingList.value = datas.response;
      }
    } finally {
      // isLoading(false);
    }
  }







  Future<BookingList> getbooking() async {
    final response = await http.post(
      Uri.parse(ApiEndPoints.bookingList), // Convert the data to JSON
    );
    bookingList.clear();
    if (response.statusCode == 200) {
      return BookingList.fromJson(jsonDecode(response.body));
    } else {
      // Get.snackbar("Exception", response.reasonPhrase.toString(),
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.white,
      //     colorText: Appcolors.Containerbackgroundtint);
      throw Exception('Failed to load data ${response.statusCode}');
    }
  }

}