import 'package:flutter/material.dart';

class ForecastItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16, bottom: 16),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Color(0xff404446),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.6),
            blurRadius: 4,
            offset: Offset(4, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "00:00",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          Image.asset(
            "assets/images/overcast.webp",
            height: 50,
          ),
          SizedBox(height: 8),
          Text(
            "5.5 °C",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
