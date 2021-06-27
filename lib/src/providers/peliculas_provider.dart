import 'dart:convert';

import 'package:watu_ppp2_flutter/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider {
  String _apikey = '4e3c2742d7cac62ecffb820ccdd05d83';
  String _url = 'api.themoviedb.org';
  String _language = 'ES';

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });
    final resp = await http.get(url);
    //Decodificar la resp
    final decodeData = json.decode(resp.body); //resp.body es el {} como string

    final peliculas = new Peliculas.fromJsonList(decodeData['results']);
    print(peliculas.items[3].title);
    return peliculas.items;
  }
}
