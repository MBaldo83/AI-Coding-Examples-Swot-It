import 'package:flutter/material.dart';
import 'package:swot_it_flutter_prompt_built/builderView.dart';

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
