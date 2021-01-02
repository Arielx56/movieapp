import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  // declarar una variable del tipo de la clase
  static final AppPreferences _insta = new AppPreferences._internal();

  factory AppPreferences() {
    return _insta;
  }
  AppPreferences._internal();

  // creamos una variable de tipo shared preferences
  SharedPreferences _preferences;

  //  la inicializamos para obtener los metodos getter and setter

  initPrefs() async {
    this._preferences = await SharedPreferences.getInstance();
  }

  // Una vez inicializado podemos comenzar a crear los getter and setter DE LA LIBRERIA SHARED PREFERENCES

  get token {
    return _preferences.getString('token') ?? '';
  }

  set token(String value) {
    _preferences.setString('token', value);
  }

}
