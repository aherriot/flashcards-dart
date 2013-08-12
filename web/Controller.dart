part of flashcards;

class Controller implements ViewListener, ModelListener {
  
  Model _model;
  View _view;
  
  Controller(Model model, View view) {
    _model = model;
    _view = view;
    
    _model.addListener(this);
    _view.addListener(this);
    
    _model.loadNextCard(); //initialize and display the first card

  }
  
  //viewListener methods
  void viewCheckAnswer(String answer) {
    _view.displayAnswer(
        _model.currentCard.english, 
        _model.currentCard.farsi, 
        _model.currentCard.phonetic
    );
  }
  
  void viewRightAnswer() {
    
    _model.answeredRight();
    _model.loadNextCard();

    //modelDisplayCard();

  }
  
  void viewWrongAnswer() {
    
    _model.answeredWrong();
    _model.loadNextCard();
    
    //modelDisplayCard();
  }
  
  void viewTagsChanged(String tags) {
    _model.changeTags(tags);
    
  }
  
  //The source radio button has changed
  //Either Model.SOURCE_ENGLISH, model.SOURCE_FARSI, or Model.SOURCE_PHONETIC
  void viewSourceChanged(int source) {
    
    _model.changeSource(source);
    //modelDisplayCard();
  }
  
  void modelDisplayCard() {
    
    if(_model.currentCard == null)
      return;

    switch(_model.selectedSource) {
    case Model.SOURCE_ENGLISH:
      _view.displayQuestion(_model.currentCard.english);
      break;
    case Model.SOURCE_FARSI:
      _view.displayQuestion(_model.currentCard.farsi);
      break;
    case Model.SOURCE_PHONETIC:
      _view.displayQuestion(_model.currentCard.phonetic);
      break;
    }
  
  }
  
  void modelDisplayError(String message) {
    _view.displayError(message);    
  }

}