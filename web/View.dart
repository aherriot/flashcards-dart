part of flashcards;

abstract class ViewListener {
  void viewCheckAnswer(String answer);
  void viewRightAnswer();
  void viewWrongAnswer();
  void viewTagsChanged(String tags);
  void viewSourceChanged(int source);
  
}

class View {
    
  RadioButtonInputElement englishRadioButton;
  RadioButtonInputElement farsiRadioButton;
  RadioButtonInputElement phoneticRadioButton;
  
  TextInputElement tagsInput;
  
  ButtonElement checkButton;
  ButtonElement rightButton;
  ButtonElement wrongButton;
  
  ParagraphElement cardDisplayArea;
  
  ParagraphElement errorParagraph;
  
  AnchorElement toggleDisplayDataAnchor;
  AnchorElement seedDataAnchor;
  AnchorElement clearDataAnchor;
  DivElement dataDisplayArea;
  DivElement loadingPanel;
  
  List<ViewListener> listeners;
  
  Card currentCard;
  
  View() {
    
    listeners = new List<ViewListener>();
    initialize();
    
    loadingPanel.hidden = true;
    
  }
  
  void initialize() {
   loadingPanel = query("#loadingPanel");
   
   englishRadioButton = query("input[value=\"english\"]")
      ..onClick.listen(sourceChanged)
      ..checked = true;
    
    farsiRadioButton = query("input[value=\"farsi\"]")
      ..onClick.listen(sourceChanged);
    
    phoneticRadioButton = query("input[value=\"phonetic\"]")
      ..onClick.listen(sourceChanged);
    
    tagsInput = query("#tags")
      ..onChange.listen(tagsChanged);
    
    checkButton = query("#checkButton")
      ..onClick.listen(checkAnswer);
    
    rightButton = query("#rightButton")
      ..style.display = "none"
      ..onClick.listen(rightAnswer);
    
    wrongButton = query("#wrongButton")
      ..style.display = "none"
      ..onClick.listen(wrongAnswer);
    
    cardDisplayArea = query("#cardDisplayArea");    
    errorParagraph = query("#error");    
    dataDisplayArea = query("#dataDisplayArea");
    
  }
  
  //signals
  void checkAnswer(MouseEvent e) {
    e.preventDefault();
    
    for(ViewListener listener in listeners) {
      listener.viewCheckAnswer("");
    }
  }
  
  void rightAnswer(MouseEvent e) {
    e.preventDefault();
    
    for(ViewListener listener in listeners) {
      listener.viewRightAnswer();
    }
  }
  
  void wrongAnswer(MouseEvent e) {
    e.preventDefault();
    
    for(ViewListener listener in listeners) {
      listener.viewWrongAnswer();
    }
  }
  
  void tagsChanged(Event e) {
    e.preventDefault();
    
    for(ViewListener listener in listeners) {
      listener.viewTagsChanged(tagsInput.value);
    }
  }
  
  void sourceChanged(MouseEvent e) {
    //e.preventDefault();
    
    int source = Model.SOURCE_ENGLISH;
    
    if(englishRadioButton.checked) {
      source = Model.SOURCE_ENGLISH;
    } 
    else if(farsiRadioButton.checked) {
      source = Model.SOURCE_FARSI;
    } 
    else if(phoneticRadioButton.checked) {
      source = Model.SOURCE_PHONETIC;
    } 
    
    
    for(ViewListener listener in listeners) {
      listener.viewSourceChanged(source);
    }
  }
  
  //slots  
  void displayQuestion(String question) {
    cardDisplayArea.text = question;
    show(checkButton);
    hide(rightButton);
    hide(wrongButton);
  }
  
  void displayAnswer(String english, String farsi, String phonetic) {
    
    cardDisplayArea.innerHtml = "${english}<br/>${farsi}<br/>${phonetic}";
    hide(checkButton);
    show(rightButton);
    show(wrongButton);
  }
  
  void displayError(String message) {
    errorParagraph.text = message;
  }

  //listener methods
  void addListener(ViewListener listener) {
    listeners.add(listener);
    
  }
  
  void removeListener(ViewListener listener) {
    listeners.remove(listener);
  }
  
  //html manipulation methods
  void hide(Element e) {
    e.style.display = "none";
  }
  
  void show(Element e) {
    e.style.display = "";  
  }
  
}
