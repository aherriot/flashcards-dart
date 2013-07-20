part of flashcards;

class DataManager {
  
  Storage localStorage;
  List<Card> cards;
  Function displayErrorFunc;
  
  DataManager(this.displayErrorFunc) {
    
    cards = new List<Card>();
    
    localStorage = window.localStorage; 
    
    if(localStorage.isEmpty)
    {
      seedData();
    }
  }
  
  List<Card> getFilteredData(String tagFilters) {
    List<String> tags = tagFilters.split(",");
    return new List.from(cards)
      ..retainWhere((Card e) => e.hasTags(tags));
  }
  
  void clearData()
  {
    localStorage.clear();
    cards.clear();
  }
  
  void seedData() {
    cards.clear();
    cards.add(new Card("alef", "ﺍ", "alef", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("be", "ب", "be", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("pe", "پ", "pe", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("te", "ﺕ", "te", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("se", "ﺙ", "se", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("jim", "ﺝ", "jim", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("che", "ﭺ", "che", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("he", "ﺡ", "he", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("khe", "ﺥ", "khe", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("daal", "ﺩ", "daal", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("zaal", "ﺫ", "zaal", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("re", "ﺭ", "re", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("ze", "ﺯ", "ze", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("zhe", "ژ", "zhe", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("sin", "ﺱ", "sin", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("shin", "ﺵ", "shin", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("saad", "ﺹ", "saad", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("zaad", "ﺽ", "zaad", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("ta", "ﻁ", "ta", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("za", "ﻅ", "za", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("ein", "ﻉ", "ein", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("ghein", "ﻍ", "ghein", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("fe", "ﻑ", "fe", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("qaaf", "ﻕ", "qaaf", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("kaaf", "ک", "kaaf", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("gaaf", "گ", "gaaf", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("laam", "ﻝ", "laam", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("mim", "ﻡ", "mim", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("noon", "ﻥ", "noon", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("vav", "و", "vav", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("he", "ﻩ", "he", 1.0, 1.0, 1.0, ["letter"]));
    cards.add(new Card("ye", "ﻯ", "ye", 1.0, 1.0, 1.0, ["letter"]));
    
    cards.add(new Card("0", "۰", "sefr", 1.0, 1.0, 1.0, ["digit"]));
    cards.add(new Card("1", "۱", "yek", 1.0, 1.0, 1.0, ["digit"]));
    cards.add(new Card("2", "۲", "do", 1.0, 1.0, 1.0, ["digit"]));
    cards.add(new Card("3", "۳", "seh", 1.0, 1.0, 1.0, ["digit"]));
    cards.add(new Card("4", "۴", "chahaar", 1.0, 1.0, 1.0, ["digit"]));
    cards.add(new Card("5", "۵", "panj", 1.0, 1.0, 1.0, ["digit"]));
    cards.add(new Card("6", "۶", "shesh", 1.0, 1.0, 1.0, ["digit"]));
    cards.add(new Card("7", "۷", "haft", 1.0, 1.0, 1.0, ["digit"]));
    cards.add(new Card("8", "۸", "hasht", 1.0, 1.0, 1.0, ["digit"]));
    cards.add(new Card("9", "۹", "noh", 1.0, 1.0, 1.0, ["digit"]));

    cards.add(new Card("water", "آب", "ab", 1.0, 1.0, 1.0, ["noun", "food"]));
    cards.add(new Card("juice", "آبمیوه", "abmiveh", 1.0, 1.0, 1.0, ["noun", "food"]));
    cards.add(new Card("beer", "آبجو", "abjo", 1.0, 1.0, 1.0, ["noun", "food"]));
    cards.add(new Card("wine", "شراب", "sharab", 1.0, 1.0, 1.0, ["noun", "food"]));
    cards.add(new Card("milk", "شیر", "shir", 1.0, 1.0, 1.0, ["noun", "food"]));

    cards.add(new Card("olive", "زیتون", "zeitoon", 1.0, 1.0, 1.0, ["noun", "food"]));

    cards.add(new Card("chicken", "جوجه", "joojeh", 1.0, 1.0, 1.0, ["noun", "food", "animal"]));
    cards.add(new Card("beef", "گوشت گاو", "goosht e gav", 1.0, 1.0, 1.0, ["noun", "food"]));
    cards.add(new Card("lamb", "بره", "barreh", 1.0, 1.0, 1.0, ["noun", "food",]));

    cards.add(new Card("bear", "خرس", "khers", 1.0, 1.0, 1.0, ["noun", "animal"]));
    cards.add(new Card("tiger", "ببر", "babr", 1.0, 1.0, 1.0, ["noun", "animal"]));
    cards.add(new Card("goat", "بز", "boz", 1.0, 1.0, 1.0, ["noun", "animal"]));
    cards.add(new Card("sheep", "گوسفند", "goosfand", 1.0, 1.0, 1.0, ["noun", "animal"]));
    cards.add(new Card("duck", "اردک", "ordak", 1.0, 1.0, 1.0, ["noun", "animal"]));
    cards.add(new Card("cow", "گاو", "gav", 1.0, 1.0, 1.0, ["noun", "animal"]));
    cards.add(new Card("fish", "ماهی", "mahi", 1.0, 1.0, 1.0, ["noun", "animal"]));

  }
}



