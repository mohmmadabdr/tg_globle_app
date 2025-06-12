import 'package:flutter/material.dart';

class Homecontroller with ChangeNotifier {
  final List<Map<String, String>> items = [
    {'name': 'Hotels', 'logo': 'assets/images/hotellogo.svg'},
    {'name': 'Restaurant', 'logo': 'assets/images/restlogo.svg'},
  ];
}
