import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swot_it_flutter_prompt_built/cardView.dart';

class SwotItAPI {
  final String baseUrl;

  SwotItAPI({required this.baseUrl});

  Future<List<CardModel>> generateCards(String topic, int numberOfCards) async {
    final response = await http.post(
      Uri.parse('$baseUrl/generateCards'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'topic': topic,
        'numberOfCards': numberOfCards,
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((card) => CardModel.fromJson(card)).toList();
    } else {
      throw Exception('Failed to load cards');
    }
  }
} 