import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherappg9/models/weather_model.dart';
import 'package:weatherappg9/services/api_services.dart';
import 'package:weatherappg9/widgets/weather_item.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? weatherModel;

  Future<Position> getLocation() async {
    bool _serviceEnabled;
    LocationPermission _permission;

    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      return Future.error("Servicios de geolocalización deshabilitados");
    }

    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        return Future.error("Los permisos han sido denegados");
      }
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> getDataLocation() async {
    Position position = await getLocation();
    print(position);
    weatherModel = await ApiServices()
        .getWeatherInfo(-11.993044302705213, -77.00924362697712);
    setState(() {});
  }

  @override
  void initState() {
    getDataLocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ApiServices apiServices = ApiServices();
            apiServices.getWeatherInfo(-11.993044302705213, -77.00924362697712);
          },
        ),
        backgroundColor: Color(0xff272B2E),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.location_on_outlined,
                color: Colors.white,
              ),
            ),
          ],
          title: Text(
            "Weather App",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff272B2E),
        ),
        body: weatherModel == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.all(24),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff225FF1),
                          Color(0xff699BFC),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${weatherModel!.location.name}, ${weatherModel!.location.country}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Image.asset(
                          "assets/images/heavycloudy.webp",
                          height: 100,
                        ),
                        Text(
                          "${weatherModel!.current.tempC}°",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 100,
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          height: 16,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            WeatherItem(
                              image: "windspeed",
                              unit: "km/h",
                              value: weatherModel!.current.visKm.toString(),
                            ),
                            WeatherItem(
                              image: "humidity",
                              unit: "%",
                              value: weatherModel!.current.humidity.toString(),
                            ),
                            WeatherItem(
                              image: "cloud",
                              unit: "%",
                              value: weatherModel!.current.cloud.toString(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
