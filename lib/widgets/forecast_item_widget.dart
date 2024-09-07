import 'package:flutter/material.dart';

class ForecastItemWidget extends StatelessWidget {
  String time;
  String value;
  int isDay;

  ForecastItemWidget({
    required this.time,
    required this.value,
    required this.isDay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: EdgeInsets.only(right: 16, bottom: 16),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Color(0xff404446),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: isDay == 1
                ? Colors.yellow.withOpacity(0.6)
                : Colors.blue.withOpacity(0.6),
            blurRadius: 4,
            offset: Offset(4, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            time,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          Image.asset(
            "assets/images/${isDay == 1 ? 'sunny' : 'overcast'}.webp",
            height: 50,
          ),
          SizedBox(height: 8),
          Text(
            "$value °C",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
