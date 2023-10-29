import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_app/controller/weathercontroller.dart';
import 'package:weather_app/pages/additional_item.dart';
import 'package:weather_app/pages/hourly_forecast.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
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
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(255, 43, 90, 129),
                Color.fromARGB(255, 20, 52, 77),
                Color.fromARGB(255, 22, 60, 91),
              ])),
            ),
            Obx(() => Column(children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "${weatherController.weatherdata["location"]["name"]}",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 46, 64, 157),
                            Color.fromARGB(255, 29, 59, 111),
                            Color.fromARGB(255, 40, 52, 73),
                          ])),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.sunny,
                                    color: Colors.white,
                                    size: 100,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Sunny",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 30),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${weatherController.weatherdata["current"]["temp_c"]}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 30),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    AdditionalInfoItem(
                                      icon: Icons.water_drop,
                                      label: 'Humdity',
                                      value:
                                          '${weatherController.weatherdata["current"]["humidity"]} %',
                                    ),
                                    AdditionalInfoItem(
                                      icon: Icons.air,
                                      label: 'Wind Speed',
                                      value:
                                          '${weatherController.weatherdata["current"]["wind_kph"]}',
                                    ),
                                    AdditionalInfoItem(
                                      icon: Icons.beach_access,
                                      label: 'Pressure',
                                      value:
                                          '${weatherController.weatherdata["current"]["pressure_mb"]}',
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(24, 50, 89, 1).withOpacity(.8),
                            Color.fromRGBO(7, 43, 97, 0.8),
                          ]),
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(25))),
                      child: Column(
                        children: [
                          Container(
                              height: 29,
                              child: Center(
                                child: Text(
                                  "5-day forecast",
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
                            child: GetBuilder<WeatherController>(
                              builder: (WeatherController) {
                                return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: weatherController
                                      .weatherdata["forecast"]["forecastday"]
                                      .length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        weatherController.dayindex.value =
                                            index;
                                        Get.to(HourlyForecast());
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        color: Color.fromARGB(255, 6, 50, 87),
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Icon(
                                                Icons.sunny,
                                                size: 60,
                                                color: Colors.white60,
                                              ),
                                              Text(
                                                  "${weatherController.weatherdata["forecast"]["forecastday"][index]["day"]["avgtemp_c"]}",
                                                  style: TextStyle(
                                                      color: Colors.white60,
                                                      fontSize: 30)),
                                              Text(
                                                  "${Jiffy.parse(weatherController.weatherdata["forecast"]["forecastday"][index]["date"].replaceAll('-', '/')).MMMEd}",
                                                  style: TextStyle(
                                                      color: Colors.white60,
                                                      fontSize: 30)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]))
          ],
        ),
      ),
    );
  }
}
