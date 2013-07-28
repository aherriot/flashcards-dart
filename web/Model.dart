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
    else
    {      
      loadData();
    }
  }
  
  List<Card> getFilteredData(String tagFilters) {
    
    if(tagFilters.isEmpty)
      return new List.from(cards);
    
    List<String> tags = tagFilters.split(",");
    return new List.from(cards)
      ..retainWhere((Card e) => e.hasTags(tags));
  }
  
  void clearData()
  {
    localStorage.clear();
    cards.clear();
  }
  
  void loadData() {
    cards.clear();
    localStorage.forEach((String key , String value){
      cards.add(new Card.fromString(value));
    });
  }
  
  void loadCard(Card card)
  {
    String key = card.getKey();
    
    if(localStorage.containsKey(key))
    {
      Card localStorageCard = new Card.fromString(localStorage[key]);
      cards.add(localStorageCard);
    }
    else {
      localStorage[key] = card.toString();
      cards.add(card);
    }
  }
  
  void seedData() {
    cards.clear();
//    cards.add(new Card("alef", "ﺍ", "alef", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("be", "ب", "be", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("pe", "پ", "pe", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("te", "ﺕ", "te", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("se", "ﺙ", "se", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("jim", "ﺝ", "jim", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("che", "ﭺ", "che", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("he", "ﺡ", "he", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("khe", "ﺥ", "khe", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("daal", "ﺩ", "daal", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("zaal", "ﺫ", "zaal", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("re", "ﺭ", "re", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("ze", "ﺯ", "ze", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("zhe", "ژ", "zhe", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("sin", "ﺱ", "sin", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("shin", "ﺵ", "shin", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("saad", "ﺹ", "saad", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("zaad", "ﺽ", "zaad", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("ta", "ﻁ", "ta", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("za", "ﻅ", "za", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("ein", "ﻉ", "ein", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("ghein", "ﻍ", "ghein", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("fe", "ﻑ", "fe", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("qaaf", "ﻕ", "qaaf", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("kaaf", "ک", "kaaf", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("gaaf", "گ", "gaaf", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("laam", "ﻝ", "laam", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("mim", "ﻡ", "mim", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("noon", "ﻥ", "noon", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("vav", "و", "vav", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("he", "ﻩ", "he", 1.0, 1.0, 1.0, ["letter"]));
//    cards.add(new Card("ye", "ﻯ", "ye", 1.0, 1.0, 1.0, ["letter"]));
//    
//    cards.add(new Card("0", "۰", "sefr", 1.0, 1.0, 1.0, ["digit"]));
//    cards.add(new Card("1", "۱", "yek", 1.0, 1.0, 1.0, ["digit"]));
//    cards.add(new Card("2", "۲", "do", 1.0, 1.0, 1.0, ["digit"]));
//    cards.add(new Card("3", "۳", "seh", 1.0, 1.0, 1.0, ["digit"]));
//    cards.add(new Card("4", "۴", "char", 1.0, 1.0, 1.0, ["digit"]));
//    cards.add(new Card("5", "۵", "panj", 1.0, 1.0, 1.0, ["digit"]));
//    cards.add(new Card("6", "۶", "sheesh", 1.0, 1.0, 1.0, ["digit"]));
//    cards.add(new Card("7", "۷", "haft", 1.0, 1.0, 1.0, ["digit"]));
//    cards.add(new Card("8", "۸", "hasht", 1.0, 1.0, 1.0, ["digit"]));
//    cards.add(new Card("9", "۹", "noh", 1.0, 1.0, 1.0, ["digit"]));
    cards.add(new Card("10", "ده", "dah", 1.0, 1.0, 1.0, ["digit"]));
    cards.add(new Card("11", "یازده", "yazdah", 1.0, 1.0, 1.0, ["digit", "number"]));
    cards.add(new Card("12", "دوازده", "davaazdah", 1.0, 1.0, 1.0, ["digit", "number"]));
    cards.add(new Card("13", "سیزده", "sizdah", 1.0, 1.0, 1.0, ["digit", "number"]));
//    cards.add(new Card("14", "چهارده", "chardah", 1.0, 1.0, 1.0, ["digit", "number"]));
//    cards.add(new Card("15", "پانزده", "panzdah", 1.0, 1.0, 1.0, ["digit", "number"]));
//    cards.add(new Card("16", "شانزده", "shanzdah", 1.0, 1.0, 1.0, ["digit", "number"]));
//    cards.add(new Card("17", "هفده", "hefdah", 1.0, 1.0, 1.0, ["digit", "number"]));
//    cards.add(new Card("18", "هجده", "hejdah", 1.0, 1.0, 1.0, ["digit", "number"]));
//    cards.add(new Card("19", "نوزده", "noozdah", 1.0, 1.0, 1.0, ["digit", "number"]));
//    cards.add(new Card("20", "بیست", "bist", 1.0, 1.0, 1.0, ["digit", "number"]));
//    cards.add(new Card("21", "بیست و یک", "bist o yek", 1.0, 1.0, 1.0, ["digit", "number"]));
//    

//    cards.add(new Card("water", "آب", "ab", 1.0, 1.0, 1.0, ["noun", "food"]));
//    cards.add(new Card("juice", "آبمیوه", "abmiveh", 1.0, 1.0, 1.0, ["noun", "food"]));
//    cards.add(new Card("beer", "آبجو", "abjo", 1.0, 1.0, 1.0, ["noun", "food"]));
//    cards.add(new Card("wine", "شراب", "sharab", 1.0, 1.0, 1.0, ["noun", "food"]));
//    cards.add(new Card("milk", "شیر", "shir", 1.0, 1.0, 1.0, ["noun", "food"]));
//    cards.add(new Card("olive", "زیتون", "zeitoon", 1.0, 1.0, 1.0, ["noun", "food"]));
//    cards.add(new Card("chicken", "جوجه", "joojeh", 1.0, 1.0, 1.0, ["noun", "food", "animal"]));
//    cards.add(new Card("beef", "گوشت گاو", "goosht e gav", 1.0, 1.0, 1.0, ["noun", "food"]));
//    cards.add(new Card("lamb", "بره", "barreh", 1.0, 1.0, 1.0, ["noun", "food",]));
//
//    cards.add(new Card("bear", "خرس", "khers", 1.0, 1.0, 1.0, ["noun", "animal"]));
//    cards.add(new Card("tiger", "ببر", "babr", 1.0, 1.0, 1.0, ["noun", "animal"]));
//    cards.add(new Card("goat", "بز", "boz", 1.0, 1.0, 1.0, ["noun", "animal"]));
//    cards.add(new Card("sheep", "گوسفند", "goosfand", 1.0, 1.0, 1.0, ["noun", "animal"]));
//    cards.add(new Card("duck", "اردک", "ordak", 1.0, 1.0, 1.0, ["noun", "animal"]));
//    cards.add(new Card("cow", "گاو", "gav", 1.0, 1.0, 1.0, ["noun", "animal"]));
//    cards.add(new Card("fish", "ماهی", "mahi", 1.0, 1.0, 1.0, ["noun", "animal"]));
//    
//    cards.add(new Card("Hi", "سلام", "salam", 1.0, 1.0, 1.0, ["phrase"]));
//    cards.add(new Card("Good morning", "صبح بخیر", "Sobh Be kheyr", 1.0, 1.0, 1.0, ["phrase"]));
//    cards.add(new Card("Good evening", "عصر بخیر", "Asr be kheyr", 1.0, 1.0, 1.0, ["phrase"]));
//    cards.add(new Card("Good night", "شب بخیر", "Shab be kheyr", 1.0, 1.0, 1.0, ["phrase"]));
//    cards.add(new Card("Welcome", "خوش آمدید", "Khosh Amadid", 1.0, 1.0, 1.0, ["phrase"]));
//    cards.add(new Card("How are you?", "حال شما چطور هست", "Haleh shoma chetor hast?", 1.0, 1.0, 1.0, ["phrase"]));
//    cards.add(new Card("Thank you", "ممنون", "Mamnoon", 1.0, 1.0, 1.0, ["phrase"]));
//    cards.add(new Card("You're welcome", "خواهش میکنم", "Khahesh mikonam", 1.0, 1.0, 1.0, ["phrase"]));
//    cards.add(new Card("See you later", "بعدأ میبینمت", "Ba’adan mibinamet", 1.0, 1.0, 1.0, ["phrase"]));
//    cards.add(new Card("Nice to meet you", "از ملاقات شما خوش وقتم", "Az molaghat e sham khosh vaghtam", 1.0, 1.0, 1.0, ["phrase"]));
//    cards.add(new Card("Good luck", "موفق باشید", "Mo’afagh bashed", 1.0, 1.0, 1.0, ["phrase"]));
//    cards.add(new Card("Congratulations", "تبریک می گویم", "Tabrik migoyam", 1.0, 1.0, 1.0, ["phrase"]));
//    cards.add(new Card("Sorry", "ببخشید", "Bebakhshid", 1.0, 1.0, 1.0, ["phrase"]));
//    cards.add(new Card("No Problem", "مشکلی نیست", "Moshkeli nist", 1.0, 1.0, 1.0, ["phrase"]));
//    cards.add(new Card("I need to practice my Persian", "من باید فارسی رو بیشتر تمرین کنم", "Man bayad farsi ro bishtar tamrin konam", 1.0, 1.0, 1.0, ["phrase"]));
//    cards.add(new Card("What?", "چی؟", "Chi?", 1.0, 1.0, 1.0, ["phrase"]));
//    cards.add(new Card("Where?", "کجا؟", "Koja?", 1.0, 1.0, 1.0, ["phrase"]));
//    cards.add(new Card("Why?", "چرا؟", "Chara?", 1.0, 1.0, 1.0, ["phrase"]));
//    cards.add(new Card("Who?", "کی؟", "Ki?", 1.0, 1.0, 1.0, ["phrase"]));
//    cards.add(new Card("When", "کی؟", "Kei?", 1.0, 1.0, 1.0, ["phrase"]));
//    cards.add(new Card("I love you", "دوست دارم", "Doset daram", 1.0, 1.0, 1.0, ["phrase"]));
//    //cards.add(new Card("", "", "", 1.0, 1.0, 1.0, ["phrase"]));
//    
//    cards.add(new Card("Black", "سیاه", "seeyah", 1.0, 1.0, 1.0, ["adjective", "colour"]));
//    cards.add(new Card("Blue", "آبی", "abi", 1.0, 1.0, 1.0, ["adjective", "colour"]));
//    cards.add(new Card("Brown", "قهوه ای", "gah-ve-yee", 1.0, 1.0, 1.0, ["adjective", "colour"]));
//    cards.add(new Card("Grey", "خاکسری", "khakestari", 1.0, 1.0, 1.0, ["adjective", "colour"]));
//    cards.add(new Card("Green", "سبز", "sabz", 1.0, 1.0, 1.0, ["adjective", "colour"]));
//    cards.add(new Card("Orange", "نارنجی", "narenji", 1.0, 1.0, 1.0, ["adjective", "colour"]));
//    cards.add(new Card("Purple", "بنفش", "banafsh", 1.0, 1.0, 1.0, ["adjective", "colour"]));
//    cards.add(new Card("Red", "قرمز", "ghermez", 1.0, 1.0, 1.0, ["adjective", "colour"]));
//    cards.add(new Card("White", "سفيد", "sefeed", 1.0, 1.0, 1.0, ["adjective", "colour"]));
//    cards.add(new Card("Yellow", "زرد", "zard", 1.0, 1.0, 1.0, ["adjective", "colour"]));
//    
    cards.forEach((Card card){
      localStorage[card.getKey()] = card.toString();
    });
    
  }
  
  Set<String> getListOfAllTags() {
    Set<String> list = new Set<String>();
    cards.forEach((Card card){
      
    });
    
  }
}


