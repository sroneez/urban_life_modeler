import 'package:flutter/material.dart';

import 'injection_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(UrbanLIfeModelerApp());
}

class UrbanLIfeModelerApp extends StatelessWidget {
  const UrbanLIfeModelerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: ,   //no need for now
    );
  }
}
