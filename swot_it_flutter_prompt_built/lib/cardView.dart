import 'package:flutter/material.dart';

// New widget for individual card representation
class CardView extends StatelessWidget {
  final String front; // New parameter for the left side text
  final String back;  // New parameter for the right side text

  const CardView({Key? key, required this.front, required this.back}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Subtle drop shadow
      child: Container(
        height: 200, // Card height
        padding: const EdgeInsets.all(10), // Padding around the card
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10), // Padding for left text
                child: Text(
                  front, // Left side text
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const VerticalDivider(
              width: 1, // Width of the divider
              thickness: 1, // Thickness of the divider
              color: Colors.black, // Color of the divider
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10), // Padding for right text
                child: Text(
                  back, // Right side text
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// New model class for Card
class CardModel {
  final String front;
  final String back;

  CardModel({required this.front, required this.back});

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      front: json['front'],
      back: json['back'],
    );
  }
}