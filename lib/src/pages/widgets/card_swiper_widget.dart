import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movieapp_with_login/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  //En esta parte queda definido que cuando se llame la clase CardSwiper
  //tiene que tener un argumento en este caso ese argumento es una lista
  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container( //Esto es de la tarjeta grande 
      height: _screenSize.height * 0.6,
      padding: EdgeInsets.only(top: 5.0),
      child: new Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {

          peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';

          return Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'detalle',arguments: peliculas[index]);
                    },
                    child: FadeInImage(
                    image: NetworkImage(peliculas[index].getPosterImagen()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                )),
          );
        },
        itemCount: peliculas.length,
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    );
      
  }
}
