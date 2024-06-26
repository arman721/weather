// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  RxInt dayindex = 0.obs;
  RxMap weatherdata = {}.obs;
  RxString location = "Cuttack".obs;
  RxBool isloading = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loaddata();
  }

  Future loaddata() async {
    try {
      isloading(true);
      var response = await http.get(Uri.parse(
          "http://api.weatherapi.com/v1/forecast.json?key=61543a2a551c42df8b094726232810&q=$location&days=3&aqi=no&alerts=no"));
      final decodedlist = jsonDecode(response.body);
      if (response.body.contains("error")) {
        weatherdata.value = {};
      } else {
        weatherdata.value = decodedlist;
        weatherdata.refresh();
      }
    } on Exception catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: e.toString(),
      ));
    } finally {
      isloading(false);
    }
  }
}
