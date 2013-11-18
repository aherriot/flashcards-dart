part of flashcards;

abstract class ModelListener {
  modelDisplayCard();
  modelDisplayError(String error);
  
}

class Model {
  
  static const int SOURCE_ENGLISH = 0;
  static const int SOURCE_FARSI = 1;
  static const int SOURCE_PHONETIC = 2;
  
  Storage localStorage;
  List<Card> workingCards;
  Set<Card> allCards;
  Card currentCard;
  int selectedSource;  
  
  Math.Random random;
  List<ModelListener> listeners;
  
  Model() {
    
    localStorage = window.localStorage;
    
    workingCards = new List<Card>();
    allCards = new Set<Card>();
   
    selectedSource = SOURCE_ENGLISH;
    random = new Math.Random();
    listeners = new List<ModelListener>();
    
    loadData();
   
  }
  
  void addListener(ModelListener listener) {
    listeners.add(listener);
  }
  
  void removeListener(ModelListener listener) {
    listeners.remove(listener);
  }
  
  void displayError(String message)
  {
    for(ModelListener listener in listeners) {
      listener.modelDisplayError(message);
    }
    
  }
  
  void changeSource(int source) {
    
    selectedSource = source;
    
    switch(selectedSource) {
    case Model.SOURCE_ENGLISH:
      workingCards.sort((Card e, Card e2) => e.compareEnglishScore(e2));
      break;
    case Model.SOURCE_FARSI:
      workingCards.sort((Card e, Card e2) => e.compareEnglishScore(e2));
      break;
    case Model.SOURCE_PHONETIC:
      workingCards.sort((Card e, Card e2) => e.compareEnglishScore(e2));
      break;
    }
  }
  
  void changeTags(String tagFilters) {
    if(tagFilters.isEmpty)
      workingCards =  new List.from(allCards);
    
    List<String> tags = tagFilters.split(",");
    workingCards =  new List.from(allCards)
      ..retainWhere((Card e) => e.hasTags(tags));
    
    loadNextCard();
    
  }
  
  void answeredWrong() {
    updateCardScore(0.5); //reduce the score for a wrong answer

  }
  
  void answeredRight() {
    updateCardScore(1.4); //increase the score for a right anwer
  }
  
  void loadNextCard() {
    
    if(workingCards.length == 0) {
      currentCard = null;
      displayError("No cards match your filters.");
      return;
      
    } 
    
    displayError("");
    int nextInt = 0;
    
    // select a number between 2 and 5
    nextInt = random.nextInt(3) + 2;
    
    // bound it by the length of the workingCards list
    nextInt = Math.min(workingCards.length-1, nextInt);
      
    
    currentCard = workingCards[nextInt];
    print(currentCard.toString());
    
    for(ModelListener listener in listeners) {
      listener.modelDisplayCard();
    }

  }
  
  void clearData()
  {
    localStorage.clear();
    allCards.clear();
  }
  
  void loadData() {
    
    allCards.clear();
    
    //load everything from local storage first
    localStorage.forEach((String key , String value){
      allCards.add(new Card.fromString(value));
    });
    
    //add words from the seed data that are not already in localStorage
    List<String> seedData = Data.getSeedData();
    for(String cardString in seedData) {
      
      Card newCard = new Card.fromString(cardString);
      if(!allCards.contains(newCard)) {
        allCards.add(newCard);       
        localStorage[newCard.getKey()] = cardString;
      }
      
    }
    
    changeTags("");
  }
  
  void updateCardScore(double scoreAdjustmentFactor) {
    
    workingCards.remove(currentCard);
    allCards.remove(currentCard);
    
    if(selectedSource == SOURCE_ENGLISH) {
      currentCard.englishScore *= scoreAdjustmentFactor;
      
      //find the insertion point in the sorted list
      for(int i = 0; i < workingCards.length; i++) { 
        
        //add it in the right place
        if(currentCard.englishScore < workingCards[i].englishScore) {
          workingCards.insert(i, currentCard);
          break;
        }
        //or at the end of the list
        else if ( i >= workingCards.length -1)
        {
          workingCards.add(currentCard);
          break;
        }
      }
    }
    else if(selectedSource == SOURCE_FARSI) {
      currentCard.farsiScore *= scoreAdjustmentFactor;

      //find the insertion point in the sorted list
      for(int i = 0; i < workingCards.length; i++) {
        
        //add it in the right place
        if(currentCard.farsiScore < workingCards[i].farsiScore) {
          workingCards.insert(i, currentCard);
          break;
          
        //or at the end of the list
        } else if ( i >= workingCards.length -1) {
          workingCards.add(currentCard);
          break;
        }
      }
    }
    else if(selectedSource == SOURCE_PHONETIC) {
      currentCard.phoneticScore *= scoreAdjustmentFactor;
      
      //find the insertion point in the sorted list
      for(int i = 0; i < workingCards.length; i++) {
        
        //add it in the right place
        if(currentCard.phoneticScore <= workingCards[i].phoneticScore) {
          workingCards.insert(i, currentCard);
          break;
          
        //or at the end of the list
        } else if ( i >= workingCards.length -1) {
          workingCards.add(currentCard);
          break;  
          
        }
      }
    }
    allCards.add(currentCard);
    localStorage[currentCard.getKey()] = currentCard.toString();

  }
  
  Set<String> getSetOfAllTags() {
    Set<String> setOfTags = new Set<String>();
    allCards.forEach((Card card){
        setOfTags.addAll(card.tags);  
    });
    
    return setOfTags;
    
  }
}



