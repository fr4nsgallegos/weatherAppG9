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
