import 'package:flutter/material.dart';

class Card extends StatefulWidget {
  const Card({required Key key}) : super(key: key);

  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<Card> {
  @override
  Widget build(BuildContext context) {
    return const Text('card');
  }
}
