import 'package:flutter/material.dart';
import 'package:tg_globle_app/controller/homecontroller.dart';
import 'package:tg_globle_app/controller/hotelcontroller.dart';
import 'package:tg_globle_app/controller/restaurantcontroller.dart';
import 'package:tg_globle_app/view/myapp.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Homecontroller()),
        ChangeNotifierProvider(create: (_) => Hotelcontroller()),
        ChangeNotifierProvider(create: (_) => Restaurantcontroller()),
      ],
      child: MyApp(),
    ),
  );
}
