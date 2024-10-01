# Prompts
--- Big prompt with details

```
I'd like to buiid a SwiftUI View with the following elements (top to bottom):
1. A title label with the text "What do you want to learn about?"
2. A text field with multiple lines to input with placeholder text "Enter topic here"
3. A HStack with text: "number of cards", an input box that accepts Integers only and a button to generate the cards
4. A scroll view containing the list of cards that are generated

This view should be contained inside a Tab Bar with 2 tabs, "Builder" (this view) and "Decks" (an empty view)
```

--- Small prompts creating iteratively

* "Please create a Swift UI VIew called BuilderView"
* "use builder view instead of content view when I laucnh the app"
* "at the top of BuilderView add a title to prompt the user with the text "What do you want to learn about?"
* "Benath the text "What do you want to learn about?", add a text field with the placeholder text "Enter topic here""
* "beneath the text field I want an HStack with Text "number of cards", a number entry box and a button to generate cards"
* "Under the HStack add a scrolling view to contain the generated cards"
* "are there any other ways to display a scrolling list of cards in swiftUI?"
* "I would like to go with the LazyVStack approach"
* "please remove Text("Builder View") from the bottom of the view"
* "this array of cards is not being displayed in the lazyVStack, only 1 card is being shown"
* "Add a tab bar with the existing BuilderView in tab 1, and a new view DecksView in tab 2. the tab bar should be contained withing a separate view called RootView"