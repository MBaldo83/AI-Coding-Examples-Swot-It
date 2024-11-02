import 'package:flutter/material.dart';
import 'package:swot_it_flutter_prompt_built/cardView.dart';
import 'package:swot_it_flutter_prompt_built/swotItModel.dart';

class BuilderView extends StatefulWidget {
  const BuilderView({Key? key}) : super(key: key);

  @override
  _BuilderViewState createState() => _BuilderViewState();
}

class _BuilderViewState extends State<BuilderView> {
  String topic = '';
  int numberOfCards = 0;
  List<CardModel> generatedCards = []; // Array to hold generated CardModels

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text('What do you want to learn about?'),
          TextField(
            onChanged: (value) {
              setState(() {
                topic = value; // Bind topic variable
              });
            },
            decoration: const InputDecoration(
              hintText: 'Enter topic here',
            ),
            maxLines: null, // Allow multiple lines
          ),
          Row(
            children: [
              const Text('Number of cards:'),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      numberOfCards = int.tryParse(value) ?? 0; // Bind numberOfCards variable
                    });
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final model = SwotItModel();
                  final cards = await model.generateCards(topic, numberOfCards);
                  // Update the state to display the generated cards
                  setState(() {
                    generatedCards = cards; // Populate the array with generated cards
                  });
                },
                child: const Text('Generate Cards'),
              ),
            ],
          ),
          // Scrollable list of cards
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), // Disable scrolling for the ListView
            itemCount: generatedCards.length, // Use the length of generatedCards
            itemBuilder: (context, index) {
              return CardView(
                front: generatedCards[index].front, // Use front from generated cards
                back: generatedCards[index].back, // Use back from generated cards
              );
            },
          ),
        ],
      ),
    );
  }
}