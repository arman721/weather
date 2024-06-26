import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_app/controller/weathercontroller.dart';

class HourlyForecast extends StatelessWidget {
  HourlyForecast({super.key});
  final WeatherController weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        Container(
          height: Get.height,
          width: Get.width,
          child: Image.asset(
            "lib/assets/images/background.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Expanded(
              flex: 1,
              child: Obx(
                () => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 40,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: Get.width * 0.1,
                    ),
                    Column(
                      children: [
                        Text(
                          "${Jiffy.parse(weatherController.weatherdata["forecast"]["forecastday"][weatherController.dayindex.value]["date"].replaceAll('-', '/')).MMMEd}",
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${weatherController.weatherdata["forecast"]["forecastday"][weatherController.dayindex.value]["day"]["avgtemp_c"]} °C",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${weatherController.weatherdata["forecast"]["forecastday"][weatherController.dayindex.value]["day"]["condition"]["text"]}",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
                flex: 2,
                child: Container(
                  width: Get.width * 0.9,
                  child: Image.asset(
                    "lib/assets/images/home.jpg",
                    fit: BoxFit.fitWidth,
                  ),
                )),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(55, 101, 168, 1).withOpacity(.8),
                      Color.fromRGBO(12, 78, 178, 0.8),
                    ]),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(55))),
                child: Column(
                  children: [
                    Container(
                        height: 29,
                        child: Center(
                          child: Text(
                            "Hourly Forecast",
                            style: TextStyle(
                                color: Colors.white60,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                    Divider(
                      color: Colors.white60,
                      thickness: 2,
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: weatherController
                            .weatherdata["forecast"]["forecastday"]
                                [weatherController.dayindex.value]["hour"]
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: 100,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color.fromARGB(255, 60, 123, 175),
                                      Color.fromARGB(255, 22, 103, 170),
                                      Color.fromARGB(255, 0, 45, 82),
                                    ]),
                                border: Border.all(color: Colors.white54),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            margin: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "${weatherController.weatherdata["forecast"]["forecastday"][weatherController.dayindex.value]["hour"][index]["time"]}"
                                      .substring(11),
                                  style: TextStyle(
                                      color: Colors.white60, fontSize: 25),
                                ),
                                Icon(
                                  Icons.cloud,
                                  color: Colors.white38,
                                  size: 35,
                                ),
                                Text(
                                  "${weatherController.weatherdata["forecast"]["forecastday"][weatherController.dayindex.value]["hour"][index]["temp_c"]}",
                                  style: TextStyle(
                                      color: Colors.white60, fontSize: 15),
                                ),
                                Text(
                                  "${weatherController.weatherdata["forecast"]["forecastday"][weatherController.dayindex.value]["hour"][index]["condition"]["text"]}",
                                  style: TextStyle(
                                      color: Colors.white60, fontSize: 25),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    )));
  }
}
