
class Peliculas {

  List<Pelicula> contenedorDePeliculasMapeadas = new List();
  
//constructor que recibe el mapa de todas las respuestas
//dichas respuestan se hacen en la funcion de Pelicula.fromJsonMap(Map<String, dynamic> json)

Peliculas.fromJsonList(List<dynamic> jsonList){
  if(jsonList == null) return;

  //la variable i tecnicamente recibe todos los datos del mapa 
    //es decir lo que viene de la peticion de la API 

    for(var i in jsonList){

      // esta variable pelicula de tipo final va a almacenar una nueva lista que viene del mapeo 
      final pelicula = new Pelicula.fromJsonMap(i);
      //el contenedor de la pelicula es la lista en donde van a estar todas las peliculas pero dichas peliculas tienen que venir de algun lugar
      // y ese lugar del cual vienen es de la clase Pelicula por eso se usa el metodo add para añadir eso a la lista que creamos con ese objetivo
      //para que contenga los datos de la peticion que se realizo 
      contenedorDePeliculasMapeadas.add(pelicula);
    }
}

}
class Pelicula {

  String uniqueId;

  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> json){

    popularity= json ['popularity']/1;
    voteCount= json ['vote_count'];
    video= json ['video'];
    posterPath= json ['poster_path'];
    id= json ['id'];
    adult= json ['adult'];
    backdropPath= json ['backdrop_path'];
    originalLanguage= json ['original_language'];
    originalTitle= json ['original_title'];
    genreIds= json ['genre_ids'].cast<int>();
    title= json ['title'];
    voteAverage= json ['vote_average']/1;
    overview= json ['overview'];
    releaseDate= json ['release_date'];

  }

  getPosterImagen(){
    if(posterPath == null){
      return 'https://sisterhoodofstyle.com/wp-content/uploads/2018/02/no-image-1.jpg';
    }else{
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }
  getBackgroundImagen() {
    if (backdropPath == null) {
      return 'https://sisterhoodofstyle.com/wp-content/uploads/2018/02/no-image-1.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }

}
