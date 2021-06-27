import 'package:flutter/material.dart';
import 'package:watu_ppp2_flutter/src/models/pelicula_model.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10,
              ),
              _posterTitulo(context, pelicula)
            ]),
          )
        ],
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
    print("adsad ${pelicula.uniqueId}");
    return Container(
      child: Row(
        children: [
          Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(
                child: Image(
                  image: NetworkImage(pelicula.getPosterImg()),
                  height: 150,
                ),
              ))
        ],
      ),
    );
  }
}
