import 'package:flutter/material.dart';
import 'package:skywatch/app/core/widgets/text/text_title.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextTitle(text: "SkyWatch"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
        child: GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/weather');
      },
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.lightBlue,
        ),
        child: const Center(
          child: Text(
            'Check the weather',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_a_photo),
          onPressed: () {
            Navigator.of(context).pushNamed("/camera");
          }),
    );
  }
}
