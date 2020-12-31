import 'package:flutter/material.dart';
import 'package:movieapp_with_login/src/pages/widgets/card_swiper_widget.dart';
import 'package:movieapp_with_login/src/pages/widgets/movie_horizontal.dart';
import 'package:movieapp_with_login/src/providers/peliculas_providers.dart';
import 'package:movieapp_with_login/src/search/search_delegate.dart';

class HomePage extends StatelessWidget {
  final peliculasProvaider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvaider.getPopulares();

    return Scaffold(
        appBar: AppBar(
          title: Text('Peliculas en cines'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: BuscadordeDatos());
                })
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[_swiperTarjetas(), _footer(context)],
          ),
        ));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvaider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Populares',
                  style: Theme.of(context).textTheme.subtitle1)),
          SizedBox(
            height: 20.0,
          ),
          StreamBuilder(
            // el StreamBuilder se va a ejecutar cada vez que se emita un valor en el Stream --- el Future solo se ejecuta una vez
            stream: peliculasProvaider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              //snapshot.data?.forEach((p) => print(p.title));

              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculasHorizontal: snapshot.data,
                  siguienteListaDePeliculas: peliculasProvaider.getPopulares,
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
