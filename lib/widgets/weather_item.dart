import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  String value;
  String unit;
  String image;
  WeatherItem({
    required this.value,
    required this.unit,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/$image.webp",
          height: 50,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "$value $unit",
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
