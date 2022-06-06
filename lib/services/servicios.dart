
import 'dart:convert';
import 'package:final_prueba/models/modelos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Servicios extends ChangeNotifier{

final String _urlBase='api.covid19api.com';
List<Info> salida = [];
Servicios(){
  getService();
}
 getService() async {

  final url = Uri.https(_urlBase, '/live/country/mexico/status/confirmed');
  final respuesta = await http.get(url);
List listainfo = jsonDecode(respuesta.body);
/*recorrer la lista*/
for (var i = 0; i < listainfo.length; i++) {
      Info info1 =
          Info(country: listainfo[i]['Country'], 
          province: listainfo[i]['Province'] ,
          confirmed: listainfo[i]['Confirmed'],
          deaths: listainfo[i]['Deaths'],
          active: listainfo[i]['Active'],
          date:  listainfo[i]['Date']
          );
        
      salida.add(info1);
    }
  /*actualizar**/
notifyListeners();
}

}
