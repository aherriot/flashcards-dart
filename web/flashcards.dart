library flashcards;

import 'dart:html';
import 'dart:math' as Math;

part 'Card.dart';
part 'DataManager.dart';

void main() {  
  FlashCardsApp app = new FlashCardsApp();
  app.run();
}

class FlashCardsApp { 

  DataManager dataManager;
  List<Card> workingDictionary = [];
  
  Math.Random random = new Math.Random();
  
  static const int ENGLISH = 0;
  static const int FARSI = 1;
  static const int PHONETIC = 2;
  int selectedSource = ENGLISH;
  Card currentCard;
  
  RadioButtonInputElement englishRadioButton;
  RadioButtonInputElement farsiRadioButton;
  RadioButtonInputElement phoneticRadioButton;
  
  TextInputElement tagsInput;
  
  ButtonElement revealButton;
  ButtonElement rightButton;
  ButtonElement wrongButton;
  
  ParagraphElement cardDisplayArea;
  
  ParagraphElement errorParagraph;
  
  AnchorElement toggleDisplayDataAnchor;
  AnchorElement seedDataAnchor;
  AnchorElement clearDataAnchor;
  DivElement dataDisplayArea;
  DivElement loadingPanel;
  
  void run() {
    initialize(); 
  
    tagsChanged(new Event('MouseEvent'));
    englishSelected(new Event('MouseEvent'));
    
    loadingPanel.hidden = true;
    
    showNextCard();
  }
  
  void initialize() {
    
   loadingPanel = query("#loadingPanel");
   
   englishRadioButton = query("input[value=\"english\"]")
      ..onClick.listen(englishSelected)
      ..checked = true;
    
    farsiRadioButton = query("input[value=\"farsi\"]")
      ..onClick.listen(farsiSelected);
    
    phoneticRadioButton = query("input[value=\"phonetic\"]")
      ..onClick.listen(phoneticSelected);
    
    tagsInput = query("#tags")
      ..onChange.listen(tagsChanged);
    
    revealButton = query("#revealButton")
      ..onClick.listen(clickRevealButton);
    
    rightButton = query("#rightButton")
      ..hidden = true
      ..onClick.listen(clickRightButton);
    
    wrongButton = query("#wrongButton")
      ..hidden = true
      ..onClick.listen(clickWrongButton);
    
    cardDisplayArea = query("#cardDisplayArea");
    
    errorParagraph = query("#error");
    
    dataManager = new DataManager(displayError);
    
    //toggleDisplayDataAnchor = query("#toggleDisplayData")
    //  ..onClick.listen(displayData);
    
    //clearDataAnchor = query("#clearData")
    //  ..onClick.listen(dataManager.clearData);
      
    //seedDataAnchor = query("#seedData")
    //  ..onClick.listen(dataManager.seedData);
    
    dataDisplayArea = query("#dataDisplayArea");
  }
  
  void displayError(String errorMessage) {
    errorParagraph.text = errorMessage;
  }
  
  void englishSelected(Event e) {
    selectedSource = ENGLISH;
    workingDictionary.sort((Card e, Card e2) => e.compareEnglishScore(e2));
    showNextCard();
  }
  
  void farsiSelected(Event e) {
    selectedSource = FARSI;
    workingDictionary.sort((Card e, Card e2) => e.compareFarsiScore(e2));
    showNextCard();
  }
  
  void phoneticSelected(Event e) {
    selectedSource = PHONETIC;
    workingDictionary.sort((Card e, Card e2) => e.comparephoneticScore(e2));
    showNextCard();
  }
  
  //Event handler for when the tag filters are edited
  void tagsChanged(Event e) {
    e.preventDefault();
    
    workingDictionary = dataManager.getFilteredData(tagsInput.value);

    
    if(workingDictionary.length == 0) {
      errorParagraph.text = "No items match the filtering tags.";
    }
    else {
      errorParagraph.text = "";
    }
    
    showNextCard();
    //toggleDisplayDataAnchor.click(); //update the display data;
  }
  
  void clickRevealButton(MouseEvent e) {
    e.preventDefault();
    
    cardDisplayArea.innerHtml = "${currentCard.english}<br/>${currentCard.farsi}<br/>${currentCard.phonetic}";
    
    revealButton.hidden = true;
    rightButton.hidden = false;
    wrongButton.hidden = false;
  }
  
  void clickRightButton(MouseEvent e) {
    e.preventDefault();
    
    updateCard(1.4);    
    showNextCard();
  }
  
  void clickWrongButton(MouseEvent e) {
    e.preventDefault();

    updateCard(0.5);    
    showNextCard();
  }
  
  void updateCard(double scoreAdjustmentFactor)
  {
    
    workingDictionary.remove(currentCard);
    
    if(englishRadioButton.checked) {
      currentCard.englishScore *= scoreAdjustmentFactor;
      for(int i = 0; i < workingDictionary.length; i++) {
        if(currentCard.englishScore < workingDictionary[i].englishScore) {
          workingDictionary.insert(i, currentCard);
          break;
        }
        else if ( i >= workingDictionary.length -1)
        {
          workingDictionary.add(currentCard);
          break;
        }
      }
    }
    else if(farsiRadioButton.checked) {
      currentCard.farsiScore *= scoreAdjustmentFactor;
      for(int i = 0; i < workingDictionary.length; i++) {
        if(currentCard.farsiScore < workingDictionary[i].farsiScore) {
          workingDictionary.insert(i, currentCard);
          break;
        } 
        else if ( i >= workingDictionary.length -1)
        {
          workingDictionary.add(currentCard);
          break;
        }
      }
    }
    else if(phoneticRadioButton.checked) {
      currentCard.phoneticScore *= scoreAdjustmentFactor;
      for(int i = 0; i < workingDictionary.length; i++) {
        if(currentCard.phoneticScore <= workingDictionary[i].phoneticScore) {
          workingDictionary.insert(i, currentCard);
          break;
        }      
        else if ( i >= workingDictionary.length -1)
        {
          workingDictionary.add(currentCard);
          break;  
        }
      }
    }
  }
  
  void showNextCard() {
    
    //toggleDisplayDataAnchor.click();
    revealButton.hidden = false;
    rightButton.hidden = true;
    wrongButton.hidden = true;
    
    if (workingDictionary.length == 0)
      return;
    
    int nextInt = 0;
    if(workingDictionary.length > 1)
      nextInt = random.nextInt(Math.min(workingDictionary.length-1, 4));
    
    currentCard = workingDictionary[nextInt];
    

    if(englishRadioButton.checked) {
      cardDisplayArea.text = currentCard.english;    
    } 
    else if(farsiRadioButton.checked) {
      cardDisplayArea.text = currentCard.farsi;
    } 
    else if(phoneticRadioButton.checked) {
      cardDisplayArea.text = currentCard.phonetic; 
    } 
    
    displayData(new MouseEvent(''));
  }
  
  void displayData(MouseEvent e) {
    e.preventDefault();
  
    TableElement table = new TableElement();
    //TableRowElement header = table.addRow();
    // header.innerHtml = '<tr><td>English</td><td>Farsi</td><td>Phonetic<br/>Farsi</td><td>English<br/>Score</td><td>Ponetic<br/>Score</td><td>Farsi<br/>Score</td><td>Phonetic<br/>Farsi<br/>Score</td></tr>';
    workingDictionary.forEach((Card e) => table.append(e.toTableRowElement()));
    
    dataDisplayArea.innerHtml = '';
    dataDisplayArea.append(table);
    dataDisplayArea.innerHtml  += "Count: ${workingDictionary.length}"; // for debugging
  }

}
