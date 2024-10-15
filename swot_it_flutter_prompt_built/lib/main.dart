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
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.inversePrimary, // Use the primary color from the color scheme
          title: const Text('Swot It'),
        ),
      ),
    );
  }
}
