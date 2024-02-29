import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('com.yourcompany.papilonidrecognition/channel');

  Future<void> _showCameraView() async {
    try {
      final dynamic result = await platform.invokeMethod('showCameraView');
      print('ID Document Detection Results: $result');
    } on PlatformException catch (e) {
      print("Failed to show camera view: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Papilon ID Recognition'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _showCameraView,
          child: Text('Show Camera View'),
        ),
      ),
    );
  }
}
