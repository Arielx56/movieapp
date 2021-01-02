import 'package:flutter/material.dart';
import 'package:movieapp_with_login/src/models/pelicula_model.dart';
import 'package:movieapp_with_login/src/pages/pelicula_detallada.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculasHorizontal;

  final Function siguienteListaDePeliculas;  //para la siguiente lista de peliculas que se deben de cargar 

  MovieHorizontal({@required this.peliculasHorizontal, @required this.siguienteListaDePeliculas});

    final _controladorDePaginas = new PageController(
          initialPage: 1,
          viewportFraction: 0.3
    );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;
    
    _controladorDePaginas.addListener( (){  //metodo que nos sirve cuando al deslizar y la lista este por terminar su primer recorrido vaya añadiendo los elementos restantes

      if(_controladorDePaginas.position.pixels >= _controladorDePaginas.position.maxScrollExtent -200){

        // print('cargar la siguiente lista de peliculas');
        siguienteListaDePeliculas();
      }

    } );

    return Container(
      height: _screenSize.height * 0.2,
      //nos permite para poder deslizar como widget o paginas
      child: PageView.builder(  //PageView renderiza todos los elementos que contengan mis peliculas, todos los que esten en el listado 
      //el PageView.builder va a renderiza los que sean necesarios es decir no toda la lista de golpe (los va creando bajo demanda)
        pageSnapping: false,
        // children: _tarjetas(context),
        controller: _controladorDePaginas,
        itemBuilder: (context, i) {
          
          return _tarjetaParaPageviewbuilder(context, peliculasHorizontal[i]);
        },
        itemCount: peliculasHorizontal.length,
      ),
    );
  }

  Widget _tarjetaParaPageviewbuilder (BuildContext context, Pelicula peliculaIndividual){

          peliculaIndividual.uniqueId = '${peliculaIndividual.id}-poster';


    final datosdelaPelicula = Container(
        margin: EdgeInsets.only(right: 16.0,),
        child: Column(
          children: <Widget>[
            //Para poder dar bordes a las imagenes eso justifica el uso del ClipRRect
            Hero(
              tag: peliculaIndividual.uniqueId,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(peliculaIndividual.getPosterImagen()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 132.0,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              peliculaIndividual.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );

        return GestureDetector(
          child: datosdelaPelicula,
          onTap: () {

            print('El nombre de la pelicula ${peliculaIndividual.title}');

            Navigator.pushNamed(context, 'detalle', arguments: peliculaIndividual);
            // Navigator.of(context).pushNamed(routeName)
            
          },
        );
  }

  // List<Widget> _tarjetas(BuildContext context) {

  //   return peliculasHorizontal.map((peliculaIndividual) {

  //     return Container(
  //       margin: EdgeInsets.only(right: 16.0),
  //       child: Column(
  //         children: <Widget>[
  //           //Para poder dar bordes a las imagenes eso justifica el uso del ClipRRect
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(20.0),
  //             child: FadeInImage(
  //               image: NetworkImage(peliculaIndividual.getPosterImagen()),
  //               placeholder: AssetImage('assets/img/no-image.jpg'),
  //               fit: BoxFit.cover,
  //               height: 150.0,
  //             ),
  //           ),
  //           SizedBox(height: 2.0),
  //           Text(
  //             peliculaIndividual.title,
  //             overflow: TextOverflow.ellipsis,
  //             style: Theme.of(context).textTheme.caption,
  //           )
  //         ],
  //       ),
  //     );
  //   }).toList();
  // }
}
