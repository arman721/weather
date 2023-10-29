// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  RxInt dayindex = 0.obs;
  RxMap weatherdata = {}.obs;
  @override
  void onInit() {
    super.onInit();

    loaddata();
  }

  Future loaddata() async {
    try {
      await Future.delayed(Duration(seconds: 2));
      var response = await http.get(Uri.parse(
          "http://api.weatherapi.com/v1/forecast.json?key=61543a2a551c42df8b094726232810&q=Cuttack&days=5&aqi=no&alerts=no"));
      final decodedlist = jsonDecode(response.body);
      // var weatherdataJson =
      //     await rootBundle.loadString("lib/models/weatherdata.json");
      // final decoded = jsonDecode(weatherdataJson);
      weatherdata.value = decodedlist;
      // Get.log("$weatherdata]");
    } on Exception catch (e) {
      Get.log(" the error is $e");
    }
  }
}
