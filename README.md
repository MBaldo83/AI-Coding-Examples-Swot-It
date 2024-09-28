# swot.it
A Swift UI App to generate flashcards based on a subject you want to swot up on!

## Prompts and Approach

Using images to describe UI

1. Used image including boxes that were meant to be tab in a tab bar
  * "Make a swift UI view implementing the design in this image"
  * AI implemented them as buttons
2. Revised solution to implement them as tabs
  * "these should not be buttons, but different tabs in a tab bar"
  * Used image again to implement the design for the view
    * "Implement the design shown in the image in the BuildView struct"
3. refer to article for architecture: Using the MV pattern described @https://azamsharp.com/2023/02/28/building-large-scale-apps-swiftui.html What structure should my Model layer have?
  * Result: summarised article
  * further prompts "given that approach, what Models would you recommend for this app where we want to generate a list of questions from a given topic, we then want to save that list of questions as a Deck, in another part of the applicaiton I want to be able to retrieve a list of decks"
    * Result: produced models
4. Adding the model dependency to the View
  * "I want BuildView to have access to SwotItModel, using the MV architecture pattern described here, how should BuildView access this model"
5. Adding a dotted line
  * "add a dotted line between the front and the back of the cards"
