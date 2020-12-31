
class Actores{

   List<Actordata> actores = new List();

   Actores.fromJsonList(List<dynamic> listaJson) {

     if(listaJson == null) return;

     for(var i in listaJson){

       final actor = new Actordata.frommapJson(i); //esto queremos que se añada
       actores.add(actor); // => aca !!!! en esta parte 
     }
   }
}


class Actordata {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actordata({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actordata.frommapJson(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  getFotoActor() {
    if (profilePath == null) {
      return 'https://i.dlpng.com/static/png/6728146_preview.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
