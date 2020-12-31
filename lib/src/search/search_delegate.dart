import 'package:flutter/material.dart';
import 'package:movieapp_with_login/src/models/pelicula_model.dart';
import 'package:movieapp_with_login/src/providers/peliculas_providers.dart';

class BuscadordeDatos extends SearchDelegate {

  final variableBuscadordePeliculas = new PeliculasProvider();
  @override
  List<Widget> buildActions(BuildContext context) {
    //las acciones de nuestro AppBar
    return [
        IconButton(
          icon: Icon(Icons.clear) ,
          onPressed: () {
            
            query = '';
          },
        )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //icono a la izquierda del appBar
    return 
      IconButton(
        icon:AnimatedIcon(
        icon: AnimatedIcons.menu_arrow ,
        progress: transitionAnimation,
        ) ,
        onPressed: () {
          
        // Navigator.pushNamed(context, '/');
        // Navigator.pop(context);
        close(context, null);
        },
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    //los resultados que se van a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //las sugerencia que pareque aparece cuando la persona escribe

      if (query.isEmpty){

        return Container();
      }

      return FutureBuilder(
        future: variableBuscadordePeliculas.buscadordePeliculas(query),
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot <List<Pelicula>> snapshot) {

          
          if(snapshot.hasData){ 

             final peliculas = snapshot.data;

            return ListView(
                children: peliculas.map((pelicula) {

                    return ListTile(
                      leading: FadeInImage(
                        placeholder: AssetImage('assets/img/no-image.jpg'), 
                        image: NetworkImage(pelicula.getPosterImagen()),
                        width: 50.0,
                        fit: BoxFit.contain,
                        ),
                      title: Text(pelicula.title),
                      subtitle: Text(pelicula.originalTitle),
                      onTap: () {
                        
                        close(context, null);
                        Navigator.pushNamed(context, 'detalle',arguments: pelicula);
                      },
                      
                    );                    
                }).toList(),
            );
          }else{
            return Center(
              child: CircularProgressIndicator()
              );
          }
        },
      );


    // return Container();
    // return ListView.builder(
    //   itemCount: peliculasRecientes.,
    //   itemBuilder: (context, index) {
        
    //   },
    //   );
  }
}
