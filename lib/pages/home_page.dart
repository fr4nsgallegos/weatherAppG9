import 'package:flutter/material.dart';
import 'package:weatherappg9/widgets/weather_item.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: Column(
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
                    "Lima, Perú",
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
                    "23.9°",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 100,
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    height: 16,
                  ),
                  Row(
                    children: [
                      WeatherItem(),
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
