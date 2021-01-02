import 'package:flutter/material.dart';
import 'package:movieapp_with_login/src/bloc/movie_bloc.dart';

class BlocProvaider extends InheritedWidget {
  // elementos creados para que se lo que se escriba se guarde en la storage
  static BlocProvaider _instancia;
  // creamos un constructor de tipo factory de la clase para el almacenamiento local
  factory BlocProvaider({Key key, Widget child}) {
    // dentro del constructor se esta haciendo una condicion
    if (_instancia == null) {
      _instancia = new BlocProvaider._internal(key: key, child: child);
    }
    return _instancia;
  }
  BlocProvaider._internal({Key key, Widget child}) : super (key: key, child: child);

  final bloc = MovieBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MovieBloc of (BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<BlocProvaider>().bloc);
  }
}
