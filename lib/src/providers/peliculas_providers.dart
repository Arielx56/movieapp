import 'dart:async';
import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:movieapp_with_login/src/models/actores_model.dart';
import 'package:movieapp_with_login/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _api_key = 'dd2e4ccb3c865c1f649b670dcb1dedeb';
  String _url = 'api.themoviedb.org';
  String _lenguage = 'es-Es';

  int _popularesPage = 0;
  bool _cargando = false;

  //el STREAM tiene que ser una corriente de datos que va a transmitir
  //dentro de ella van a ser la coleccion de peliculas (un listado de peliculas)

  List<Pelicula> _populares = new List();

  //lo que va a fluir en este rio de informacion que es el stream es una lista de pelicula
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();
  // el brodcast es para que ambos widget puedan hacer la accion del listem
  //sino seria como que uno solo esta escuchando

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  //_popularesStream.sink.add ==== lo que hace esta funcion es apuntar a la funcion del StreamController
  //sink y de esa manera con el add agrego peliculas al afluente de peliculas que maneja este Stream

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  //metodo necesario para que los string si es que no se los cierra y digamos
  //que entraran en la pantalla una y otra vez, esto crearia multiples streams
  //y hay que ocupar cerrarlos cuando no estemos ya trabjando con ellos

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    //esto va a retornar toda la respuesta http
    // lo que mas importa es el resultado de http.get(url)
    //y se coloca el await esperar a que haga esa solicitud
    final respuesta = await http.get(url);

    //que hace aqui el json.decode
    final decodeData = json.decode(respuesta.body);

    final peliculas = new Peliculas.fromJsonList(decodeData['results']);

    return peliculas.contenedorDePeliculasMapeadas;
  }

  // UN FUTURE que sera un listado de peliculas
  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _api_key,
      'language': _lenguage,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) {
      return [];
    }

    _cargando = true;

    //incrementando
    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _api_key,
      'language': _lenguage,
      'page': _popularesPage.toString()
    });

    //la lista de pelicula que se procesa en el metodo procesarRespuesta
    //es lo que necesitamos que pase por el streamBuilder

    final respuestaDeListapopular = await _procesarRespuesta(url); //lista de peliculas

    _populares.addAll(respuestaDeListapopular);
    //se añade la informacion mediante este sink
    popularesSink(_populares);

    _cargando = false;
    return respuestaDeListapopular;
  }

  Future<List<Actordata>> getActor(String peliculaId) async {

    final url = Uri.https(_url, '3/movie/$peliculaId/credits',{
      'api_key': _api_key,
      'language': _lenguage
    });

    final resp = await http.get(url);

    final decodeData= json.decode(resp.body); // el body se lo usa para transforma resp en un mapa en donde crea toda la iformacion

    //creamos una nueva instancia de la clase Actores (esto lo habiamos ya creado en el actores_model)

    final actoresCast= new Actores.fromJsonList(decodeData['cast']);

    return actoresCast.actores;

    
  }

  Future<List<Pelicula>> buscadordePeliculas(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _api_key,
      'language': _lenguage,
      'query'   : query
    });

    return await _procesarRespuesta(url);
  }

}
