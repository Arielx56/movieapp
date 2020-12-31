import 'package:flutter/material.dart';
import 'package:movieapp_with_login/src/models/actores_model.dart';
import 'package:movieapp_with_login/src/models/pelicula_model.dart';
import 'package:movieapp_with_login/src/providers/peliculas_providers.dart';

class PeliculaDetalle extends StatelessWidget {
  
// final Pelicula pelicula;
// PeliculaDetalle(this.pelicula);

  @override
  Widget build(BuildContext context) {

    final Pelicula datosdelalistadePeliculas= ModalRoute.of(context).settings.arguments;

    // final Actordata datosdelosActores= ModalRoute.of(context).settings.arguments;

    return Scaffold(

      body: CustomScrollView(
        slivers: <Widget>[
          
          _appBarpersionalizado(datosdelalistadePeliculas),
          SliverList(
            delegate: SliverChildListDelegate(

              [
                SizedBox(height: 10.0),
                _posterTitulo(context, datosdelalistadePeliculas),
                _descripcionPelicula(datosdelalistadePeliculas),
                _descripcionPelicula(datosdelalistadePeliculas),
                _descripcionPelicula(datosdelalistadePeliculas),
                _descripcionPelicula(datosdelalistadePeliculas),
                _pageViewCastingdeActores(datosdelalistadePeliculas)
        
              ]

            ) ,)
        ],
      ),

    );
  }

  Widget  _appBarpersionalizado(Pelicula pelicula){

    return SliverAppBar(

      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
      title: Text(pelicula.title,
       style:TextStyle(
         color: Colors.white, fontSize: 16.0),
         ),
      background: FadeInImage(
        image: NetworkImage(pelicula.getBackgroundImagen()),
        placeholder: AssetImage('assets/img/loading.gif'),
        // fadeInDuration: Duration(microseconds: 250),
        fit: BoxFit.cover
        ),
      
      ),
      
    
    

    );

  }

  Widget _posterTitulo(BuildContext context ,Pelicula pelicula) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
        Hero(
        tag: pelicula.id,
        child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
              image: NetworkImage(pelicula.getPosterImagen()),
              height: 150.0),
          ),
        ),
        SizedBox(width: 20.0,),
        Flexible(  // se adapta al espacio restante que se tiene dentro del scaffold 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, //para que el texto este parejo 
            children: <Widget>[
              Text(pelicula.title,style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis),
              Text(pelicula.originalTitle,style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis),
              Row(
                children: <Widget>[
                  Icon(Icons.star_border),
                  Text(pelicula.voteAverage.toString())
                ],
              )
            ],
          ),
          )
        ],
      ),
    );
  }

    Widget _descripcionPelicula (Pelicula pelicula){

      return Container(
        padding: EdgeInsets.symmetric(horizontal:10.0 ,vertical:20.0 ),
        child: Column(
          children: <Widget>[

            Text(pelicula.overview,
            textAlign: TextAlign.justify)
          ],
        ),
      );
    }

    Widget _pageViewCastingdeActores(Pelicula pelicula ){

      final metodopeliculaProvaider= new PeliculasProvider();

      // final prueba = actorModel.name;

      // actorModel.getFotoActor();

      return FutureBuilder(
        future: metodopeliculaProvaider.getActor(pelicula.id.toString()),
        // initialData: InitialData,
        builder: (context, AsyncSnapshot<List> snapshot) {

          //---------------------- IMPORTANTE----------------------

          //El snapshot.hasData es el que ve si hay datos y el snapshot.data es el que ya tiene dichos datos y con el que ya podemos comenzar a llamar dicha informacion para
          //que se muestre en nuestra aplicacion 
          
          if(snapshot.hasData){

            // return _crearActoresPageView(snapshot.data);
            //  List <Actordata> actores= new List();
             List <Actordata> actores=  snapshot.data;
              //  final actorModel = Actordata();

            return SizedBox(
              height: 150.0,
              child: PageView.builder(
                controller: PageController(
                  initialPage: 1,
                  viewportFraction: 0.3
                ),
                pageSnapping: false,
                itemCount: actores.length,
                itemBuilder: (context, i) {

                //  return Text(actores[i].name);
                  return Container(
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: FadeInImage(
                          placeholder: AssetImage('assets/img/no-image.jpg'), 
                          image: NetworkImage(actores[i].getFotoActor()),
                          height: 130.0,
                          fit: BoxFit.cover,
                          ),
                        ),
                        Text(actores[i].name, overflow: TextOverflow.ellipsis)
                      ],
                    ),
                  );
                  
                },
              ),
            );
          }else{
           return Center(child: CircularProgressIndicator());
          }
        },
      );
    }

    // Widget _crearActoresPageView( List<Actordata> actores){

    //   return Container(
    //     child: PageView.builder(
    //       itemCount: actores.length,
    //       controller: PageController(
    //         initialPage: 1,
    //         viewportFraction: 0.3
    //       ),
    //       itemBuilder: (context, i) {
            
    //         return Text('chupalo maldita');

    //       },),
    //   );
    // }
}