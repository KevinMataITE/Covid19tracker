// ignore_for_file: deprecated_member_use

import 'package:final_prueba/main.dart';
import 'package:final_prueba/pages/impresion.dart';
import 'package:final_prueba/services/servicios.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Servicios(),
        )
      ],
      child: const MyAPP(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final estado = TextEditingController();
final fecha = TextEditingController();

String estadofinal = '';
String fechafinal = '';

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final servicios = Provider.of<Servicios>(context);

    if (servicios.salida.isEmpty) {
      return Container(
        color: Colors.amber.shade200,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        ),
      );
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffBFAC9B),
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: const Color.fromARGB(176, 217, 46, 30),
            title: const Text('Covid19 Tracker')),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/fondo1.jpg'),
                      fit: BoxFit.cover)),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      'Bienvenid@, Por favor rellene el formulario',
                      style: TextStyle(
                        fontSize: 20,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3
                          ..color = Colors.black,
                      ),
                    ),
                    // Solid text as fill.
                    const Text(
                      'Bienvenid@, Por favor rellene el formulario',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                _estadoTextField(),
                const SizedBox(
                  height: 20,
                ),
                _fechaTextField(),
                const SizedBox(
                  height: 80,
                ),
                
                RaisedButton(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80.0, vertical: 15.0),
                      child: const Text('Buscar'),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 10.0,
                    color: const Color.fromARGB(218, 217, 46, 30),
                    hoverColor: Colors.amber,
                    onPressed: () {
                      setState(() {
                        estadofinal = estado.text;
                        fechafinal = fecha.text;

                        String fechasalida = fechafinal + "T00:00:00Z";

                        if (estadofinal.isEmpty || fechafinal.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: const Text('Error'),
                                    content: const Text(
                                        'El formulario esta incompleto'),
                                    elevation: 24.0,
                                    backgroundColor: const Color(0xffBFAC9B),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: const BorderSide(
                                            width: 2,
                                            color: Color(0xffD92E1E))),
                                  ));
                        }
                        for (int i = 0; i < servicios.salida.length; i++) {
                          if (servicios.salida[i].province == estadofinal &&
                              servicios.salida[i].date == fechasalida) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => Impresion(
                                        servicios.salida[i].country,
                                        servicios.salida[i].province,
                                        servicios.salida[i].date,
                                        servicios.salida[i].active,
                                        servicios.salida[i].deaths,
                                        servicios.salida[i].confirmed))));
                            estadofinal = '';
                            fechasalida = '';
                            estado.clear();
                            fecha.clear();
                          }
                        }
                      });
                    }),
                const SizedBox(
                  height: 70,
                ),
                RaisedButton(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80.0, vertical: 15.0),
                      child: const Text('Ayuda'),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 10.0,
                    color: const Color.fromARGB(218, 217, 46, 30),
                    hoverColor: Colors.amber,
                    onPressed: () {
                      setState(() {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: const Text('Ayuda'),
                                  content: const Text.rich(
                                      TextSpan(children: <TextSpan>[
                                     TextSpan(
                                        text: 'Los estados deben de ser introducidos SIN acentos y respetando espacios\n\n',
                                        style: TextStyle(
                                            
                                            fontSize: 20)),
                                    TextSpan(
                                        text:  'Las fechas se deben de introducir respetando el formato, ejemplo: 2022-01-01\n\n',
                                        style:  TextStyle(fontSize: 20)),
                                         TextSpan(
                                        text:  'Nota: los registros en la API son a partir del 2021-06-25 por lo que una fecha anterior a esa es invalida.',
                                        style:  TextStyle(fontSize: 20))
                                    
                                  ])),
                                  elevation: 24.0,
                                  backgroundColor: const Color(0xffBFAC9B),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: const BorderSide(
                                          width: 2, color: Color(0xffD92E1E))),
                                ));
                      });
                    }),
              ]),
            ),
          ],
        ));
  }
}

Widget _estadoTextField() {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: estado,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            icon: Icon(Icons.add_location_alt_rounded),
            hintText: 'Estado de la republica',
            labelText: 'Estado '),
        onChanged: (value) {},
      ),
    );
  });
}

Widget _fechaTextField() {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: fecha,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today),
            hintText: 'yyyy-mm-dd',
            labelText: 'Fecha'),
        onChanged: (value) {},
      ),
    );
  });
}
