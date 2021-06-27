import 'package:flutter/material.dart';
import 'package:watu_ppp2_flutter/src/providers/peliculas_provider.dart';
import 'package:watu_ppp2_flutter/src/widgets/card_swiper.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('App de peliculas'),
          backgroundColor: Colors.indigoAccent,
          actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              _swipperTarjetas(),
            ],
          ),
        ));
  }

  Widget _swipperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            peliculas: snapshot.data,
          );
        } else {
          return Container(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
