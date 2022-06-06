import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() => runApp( const AppState());

class MyAPP extends StatelessWidget {
  const MyAPP({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
    
      home: HomePage(),
    );
  }
}
