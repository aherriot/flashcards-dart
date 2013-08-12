library flashcards;

import 'dart:html';
import 'dart:math' as Math;
import 'dart:async';


part 'Model.dart';
part 'Card.dart';
part 'View.dart';
part 'Controller.dart';

void main() {  
  FlashCardsApp app = new FlashCardsApp();
}

class FlashCardsApp { 
  
  FlashCardsApp() {
    
    Model model = new Model();
    View view = new View();
    Controller controller = new Controller(model, view);
  
  }
}
