import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/weather");
            },
            child: const Text("To weather")),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_a_photo),
          onPressed: () {
            Navigator.of(context).pushNamed("/camera");
          }),
    );
  }
}
