import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidgets extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Modular.navigatorKey,
      title: 'Search Movies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Modular.initialRoute,
      onGenerateRoute: Modular.generateRoute,
    );
  }
}