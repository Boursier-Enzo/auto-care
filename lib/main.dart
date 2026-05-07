import 'package:flutter/material.dart';

void main() {
  runApp(autoCareApp());
}

class autoCareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoCare',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text('AutoCare Accueil')),
        body: Center(
          child: Column(
            children: [
              Text('Bon retour sur AutoCare!', style: TextStyle(fontSize: 24)),
              Text(
                'Votre carnet d\'entretien numérique.',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
