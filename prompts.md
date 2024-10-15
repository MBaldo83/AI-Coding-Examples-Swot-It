prompt variables:

$$ui-platform$$
- "SwiftUI"
- "Flutter"
- "Android"

---
I'd like to build a Flutter View with the following elements (top to bottom):
1. A title label with the text "What do you want to learn about?"
2. A text field (topic) with multiple lines to input with placeholder text "Enter topic here"
  - The value of this text (topic) should be bound to a variable that can be used when performing an action
3. A Horizontal Stack with text: "number of cards", an input box (numberOfCards) that accepts Integers only and a button to generate the cards
- The value of the numberOfCards input box should be bound to an integer variable that can be used when performing an action
4. A scroll view containing the list of cards that are generated

This view should be contained inside a Tab Bar with 2 tabs, "Builder" (this view) and "Decks" (an empty view)

Please ensure:
1. That the Scrolling List View of cards is performant when rendering any number of cards on the screen
2. The View to represent a Card in the list is refactored so that it can be modified independently of the the containing List view

---

The UI to display a Card in the scrolling list view should be:
Card Dimensions height: 200, width: filling the screen with padding of 10
The card should be divided vertically down the centre with a dotted line 1 point wide
The Card should have 2 not-editable text fields one on the left of the dotted line and the other on the right of the dotted line filling the space with a padding of 10
To render a card you should provide 2 static strings, front (left side of card) and back (right side of card)
The card should have a subtle drop shadow

---

Using the 'Model View' Architecture Pattern Implement a SwotItModel API that the view can call to generate cards
API Definition:
* There should be a method called generate cards.
* This should take 2 arguments from the UI; topic (String) and numberOfCards (Int)
* This method should return asynchronously
* When this method completes, it should update the scrolling list of cards in the UI
* The implementation of this method should return a hard coded list of Card Models tha can be displayed by the View

