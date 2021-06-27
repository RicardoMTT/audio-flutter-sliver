import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watu_ppp2_flutter/src/pages/home_page.dart';
import 'package:watu_ppp2_flutter/src/pages/pelicula_detalle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detalle': (BuildContext context) => PeliculaDetalle(),
      },
    );
  }
}
