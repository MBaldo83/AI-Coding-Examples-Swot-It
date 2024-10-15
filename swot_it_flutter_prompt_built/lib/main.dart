import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Define a color scheme using fromSeed inside the build method
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.orange, // Use a seed color to generate the color scheme
      // You can customize other colors if needed
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: colorScheme.inversePrimary,
            title: const Text('Swot It'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Builder'),
                Tab(text: 'Decks'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              BuilderView(), // New view for the Builder tab
              Center(child: Text('Empty View')), // Placeholder for Decks tab
            ],
          ),
        ),
      ),
    );
  }
}

// New widget for the Builder view
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
}

// New model class for SwotIt
class SwotItModel {
  Future<List<CardModel>> generateCards(String topic, int numberOfCards) async {
    // Simulate a delay for asynchronous operation
    await Future.delayed(const Duration(seconds: 1));

    // Hardcoded list of CardModels based on the number of cards requested
    return List.generate(numberOfCards, (index) {
      return CardModel(
        front: 'Front $index for $topic',
        back: 'Back $index for $topic',
      );
    });
  }
}
