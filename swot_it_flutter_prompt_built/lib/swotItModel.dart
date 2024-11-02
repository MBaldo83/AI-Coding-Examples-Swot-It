import 'package:swot_it_flutter_prompt_built/cardView.dart';


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

