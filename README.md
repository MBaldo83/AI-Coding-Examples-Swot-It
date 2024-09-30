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
5. Trying to add sticky scroll
  * "When the user scrolls this list up, I want the elements above it to collapse so that only the HStack with Cards: remains how should I go about this?"
  * "the value of scrollOffset is being set tto 0 when the view loads, but is never changed, so the functionality to collapse the VStack isn't working do you know why?"
  * "the closure in onPreferenceChange is not being called"
  * using the value of scrollOffset, I'd like this HStack to stick on screen above the scroll view when the user scrolls up
  * when the scrollOffset is greater than the height of the top VStack, this overlay should fade in
6. Adding a dotted line
  * "add a dotted line between the front and the back of the cards"
7. Threading Fix
  * Publishing changes from background threads is not allowed
  * how can i ensure that all publishe changes are performed on the main thread?
8. Making the cards equal width
  * how would I ensure that the 2 text fields in this view are both of equal width exactly half of the horizontal space available?
  * is there a way in swiftui to ensure views are an equal width without geometry reader?
  * between using geometry reader and using layoutPriority to make views of equal width, please asses each option pros and cons for performance and flexibility
9. Adjusting padding
  * "In BuildDeckView and its subviews I want to use the default system padding as space between elements, please simplify these views to use that"
  * "Actually I do want to add padding, but just the default size, please add back padding to all elements in the scrollView in the simplest possible way"
  * "is it not possible to add padding to the scrollView only?" (this is the container view)
  * Asked a question to double check understanding: "by adding .padding() to the scrollView should this be used by internal elements as well?"
    * This was interpreted as a request for new changes
10. Replacing text with system image
  * "Instead of a button with text is there a good system image to represent the buttons functionality to Generate Questions?"
11. Added border / shadow
  * "please add an outer border and a shadow to contain all the elements of CardInListView"
  * "Is there a way in swiftUI to add a RoundedRectangle to the card without adding it as an overlay? "
  * "what are the pros and cons of adding a RoundedRectangle as a background versus an overlay?"
