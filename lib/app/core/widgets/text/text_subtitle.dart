import 'package:flutter/material.dart';

class TextSubtitle extends StatelessWidget {
  const TextSubtitle({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis),
    );
  }
}
