import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Impresion extends StatefulWidget {
  String country;
  String province;
  String date;
  int active;
  int deaths;
  int confirmed;

  Impresion(this.country, this.province,
   this.date, this.active, this.deaths,
      this.confirmed,
      {Key? key})
      : super(key: key);

  @override
  State<Impresion> createState() => _ImpresionState();
}

class _ImpresionState extends State<Impresion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(176, 217, 46, 30),
          title: const Text('Covid19 Tracker')),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/fondo2.jpg'), fit: BoxFit.cover)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 70.0),
            margin: const EdgeInsets.symmetric(vertical: 170.0,horizontal: 5.0),   
            decoration: const BoxDecoration(shape: BoxShape.circle,color: Color.fromARGB(47, 242, 140, 15), ),
          alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Text.rich(TextSpan(children: <TextSpan>[
            const TextSpan( text: 'Pais: ',style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20)),
            TextSpan(text: widget.country +"\n\n", style: const TextStyle(fontSize: 20)),
             const TextSpan( text: 'Estado: ',style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20)),
            TextSpan(text: widget.province +"\n\n", style: const TextStyle(fontSize: 20)),
             const TextSpan( text: 'Fecha: ',style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20)),
            TextSpan(text: widget.date +"\n\n", style: const TextStyle(fontSize: 20)),
             const TextSpan( text: 'Casos Activos: ',style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20)),
            TextSpan(text: widget.active.toString() +"\n\n", style: const TextStyle(fontSize: 20)),
             const TextSpan( text: 'Casos Confirmados: ',style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20)),
            TextSpan(text: widget.confirmed.toString() +"\n\n", style: const TextStyle(fontSize: 20)),
             const TextSpan( text: 'Muertes: ',style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20)),
            TextSpan(text: widget.deaths.toString() +"\n\n", style: const TextStyle(fontSize: 20)),
          ]))
                
              ],
            ),
          )
        ],
      ),
    );
  }
}
