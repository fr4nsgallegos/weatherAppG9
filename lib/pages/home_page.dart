import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherappg9/models/forecast_model.dart';
import 'package:weatherappg9/models/weather_model.dart';
import 'package:weatherappg9/services/api_services.dart';
import 'package:weatherappg9/widgets/forecast_item_widget.dart';
import 'package:weatherappg9/widgets/weather_item.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? weatherModel;
  ForecastModel? forecastModel;
  TextEditingController _searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
    // weatherModel = await ApiServices()
    //     .getWeatherInfo(position.latitude, position.longitude);
    forecastModel = await ApiServices().getForecastInfo(
      position.latitude,
      position.longitude,
    );
    setState(() {});
  }

  Future<void> getForecastSearch(String cityName) async {
    ForecastModel? _forecasModelAux;
    _forecasModelAux = await ApiServices().getForecastCity(cityName);
    if (_forecasModelAux == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Hubo un inconveniente, intenta con otra ciudad"),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      forecastModel = _forecasModelAux;
      _searchController.clear();
    }
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
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     ApiServices apiServices = ApiServices();
        //     apiServices.getForecastInfo(
        //         -11.993044302705213, -77.00924362697712);
        //   },
        // ),
        backgroundColor: Color(0xff272B2E),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                getDataLocation();
              },
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
        body: forecastModel == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: formKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 8),
                      child: TextFormField(
                        controller: _searchController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                getForecastSearch(_searchController.text);
                              }
                            },
                          ),
                          hintText: "Ingrese la ciudad",
                          fillColor: Colors.white.withOpacity(0.08),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.white54),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
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
                            "${forecastModel!.location.name}, ${forecastModel!.location.country}",
                            textAlign: TextAlign.center,
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
                            "${forecastModel!.current.tempC}°",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height / 10,
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
                                value: forecastModel!.current.visKm.toString(),
                              ),
                              WeatherItem(
                                image: "humidity",
                                unit: "%",
                                value:
                                    forecastModel!.current.humidity.toString(),
                              ),
                              WeatherItem(
                                image: "cloud",
                                unit: "%",
                                value: forecastModel!.current.cloud.toString(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Forecast",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          forecastModel!.forecast.forecastday[0].hour.length,
                          (index) => ForecastItemWidget(
                            isDay: forecastModel!
                                .forecast.forecastday[0].hour[index].isDay,
                            time: forecastModel!
                                .forecast.forecastday[0].hour[index].time
                                .toString()
                                .substring(11, 16),
                            value: forecastModel!
                                .forecast.forecastday[0].hour[index].tempC
                                .toString(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
