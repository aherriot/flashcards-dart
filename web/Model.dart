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
    
    if(localStorage.isEmpty)
    {
      seedData();
    }
    else
    {      
      loadData();
    }
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
    nextInt = random.nextInt(Math.max(1, Math.min(workingCards.length-1, 1)));
    
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
    localStorage.forEach((String key , String value){
      allCards.add(new Card.fromString(value));
    });
    
    changeTags("");
  }
    
  void seedData() {
    allCards.clear();
    
    //Letter
    allCards.add(new Card("alef", "ﺍ", "alef", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("be", "ب", "be", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("pe", "پ", "pe", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("te", "ﺕ", "te", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("se", "ﺙ", "se", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("jim", "ﺝ", "jim", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("che", "ﭺ", "che", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("he", "ﺡ", "he", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("khe", "ﺥ", "khe", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("daal", "ﺩ", "daal", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("zaal", "ﺫ", "zaal", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("re", "ﺭ", "re", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("ze", "ﺯ", "ze", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("zhe", "ژ", "zhe", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("sin", "ﺱ", "sin", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("shin", "ﺵ", "shin", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("saad", "ﺹ", "saad", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("zaad", "ﺽ", "zaad", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("ta", "ﻁ", "ta", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("za", "ﻅ", "za", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("ein", "ﻉ", "ein", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("ghein", "ﻍ", "ghein", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("fe", "ﻑ", "fe", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("qaaf", "ﻕ", "qaaf", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("kaaf", "ک", "kaaf", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("gaaf", "گ", "gaaf", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("laam", "ﻝ", "laam", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("mim", "ﻡ", "mim", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("noon", "ﻥ", "noon", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("vav", "و", "vav", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("he", "ﻩ", "he", 1.0, 1.0, 1.0, ["letter"]));
    allCards.add(new Card("ye", "ﻯ", "ye", 1.0, 1.0, 1.0, ["letter"]));
    
    //Digit
    allCards.add(new Card("0", "۰", "sefr", 1.0, 1.0, 1.0, ["digit"]));
    allCards.add(new Card("1", "۱", "yek", 1.0, 1.0, 1.0, ["digit"]));
    allCards.add(new Card("2", "۲", "do", 1.0, 1.0, 1.0, ["digit"]));
    allCards.add(new Card("3", "۳", "seh", 1.0, 1.0, 1.0, ["digit"]));
    allCards.add(new Card("4", "۴", "char", 1.0, 1.0, 1.0, ["digit"]));
    allCards.add(new Card("5", "۵", "panj", 1.0, 1.0, 1.0, ["digit"]));
    allCards.add(new Card("6", "۶", "sheesh", 1.0, 1.0, 1.0, ["digit"]));
    allCards.add(new Card("7", "۷", "haft", 1.0, 1.0, 1.0, ["digit"]));
    allCards.add(new Card("8", "۸", "hasht", 1.0, 1.0, 1.0, ["digit"]));
    allCards.add(new Card("9", "۹", "noh", 1.0, 1.0, 1.0, ["digit"]));
    allCards.add(new Card("10", "ده", "dah", 1.0, 1.0, 1.0, ["digit"]));
    allCards.add(new Card("11", "یازده", "yazdah", 1.0, 1.0, 1.0, ["digit", "number"]));
    allCards.add(new Card("12", "دوازده", "davaazdah", 1.0, 1.0, 1.0, ["digit", "number"]));
    allCards.add(new Card("13", "سیزده", "sizdah", 1.0, 1.0, 1.0, ["digit", "number"]));
    allCards.add(new Card("14", "چهارده", "chardah", 1.0, 1.0, 1.0, ["digit", "number"]));
    allCards.add(new Card("15", "پانزده", "panzdah", 1.0, 1.0, 1.0, ["digit", "number"]));
    allCards.add(new Card("16", "شانزده", "shanzdah", 1.0, 1.0, 1.0, ["digit", "number"]));
    allCards.add(new Card("17", "هفده", "hefdah", 1.0, 1.0, 1.0, ["digit", "number"]));
    allCards.add(new Card("18", "هجده", "hejdah", 1.0, 1.0, 1.0, ["digit", "number"]));
    allCards.add(new Card("19", "نوزده", "noozdah", 1.0, 1.0, 1.0, ["digit", "number"]));
    allCards.add(new Card("20", "بیست", "bist", 1.0, 1.0, 1.0, ["digit", "number"]));
    allCards.add(new Card("21", "بیست و یک", "bist o yek", 1.0, 1.0, 1.0, ["digit", "number"]));
   
    //Food
    allCards.add(new Card("water", "آب", "ab", 1.0, 1.0, 1.0, ["noun", "food"]));
    allCards.add(new Card("juice", "آبمیوه", "abmiveh", 1.0, 1.0, 1.0, ["noun", "food"]));
    allCards.add(new Card("beer", "آبجو", "abjo", 1.0, 1.0, 1.0, ["noun", "food"]));
    allCards.add(new Card("wine", "شراب", "sharab", 1.0, 1.0, 1.0, ["noun", "food"]));
    allCards.add(new Card("milk", "شیر", "shir", 1.0, 1.0, 1.0, ["noun", "food"]));
    allCards.add(new Card("olive", "زیتون", "zeitoon", 1.0, 1.0, 1.0, ["noun", "food"]));
    allCards.add(new Card("chicken", "جوجه", "joojeh", 1.0, 1.0, 1.0, ["noun", "food", "animal"]));
    allCards.add(new Card("beef", "گوشت گاو", "goosht e gav", 1.0, 1.0, 1.0, ["noun", "food"]));
    allCards.add(new Card("lamb", "بره", "barreh", 1.0, 1.0, 1.0, ["noun", "food",]));

    //Animal
    allCards.add(new Card("bear", "خرس", "khers", 1.0, 1.0, 1.0, ["noun", "animal"]));
    allCards.add(new Card("tiger", "ببر", "babr", 1.0, 1.0, 1.0, ["noun", "animal"]));
    allCards.add(new Card("goat", "بز", "boz", 1.0, 1.0, 1.0, ["noun", "animal"]));
    allCards.add(new Card("sheep", "گوسفند", "goosfand", 1.0, 1.0, 1.0, ["noun", "animal"]));
    allCards.add(new Card("duck", "اردک", "ordak", 1.0, 1.0, 1.0, ["noun", "animal"]));
    allCards.add(new Card("cow", "گاو", "gav", 1.0, 1.0, 1.0, ["noun", "animal"]));
    allCards.add(new Card("fish", "ماهی", "mahi", 1.0, 1.0, 1.0, ["noun", "animal"]));

    //Time
    allCards.add(new Card("Monday", "دوشنبه", "doshanbeh", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("Tuesday", "سه شنبه", "seshanbeh", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("Wednesday", "چهارشنبه", "charshanbeh", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("Thursday", "پنج شنبه", "panjshanbeh", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("Friday", "جمعه", "jome", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("Saturday", "شنبه", "shanbeh", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("Sunday", "یکشنبه", "yekshanbeh", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("yesterday", "ديروز", "dirooz", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("today", "امروز", "emrooz", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("tomorrow", "فردا", "fardaa", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("day", "روز", "rooz", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("night", "شب", "shab", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("week", "هفته", "hafteh", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("month", "ماه", "maah", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("year", "سال", "saal", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("second", "ثانيه", "saaniyeh", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("minute", "دقيقه", "daghigheh", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("hour", "ساعت", "saa'at", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("morning", "صبح", "sobh", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("evening", "عصر", "asr", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("noon", "ظهر", "zohr", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("afternoon", "بعد از ظهر", "ba'ad az zohr", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("midnight", "نصفه شب", "nesfeh shab", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("now", "حالا", "haalaa", 1.0, 1.0, 1.0, ["noun", "time"]));
    allCards.add(new Card("later", "بعداً", "badan", 1.0, 1.0, 1.0, ["noun", "time"]));
    
    //Colour
    allCards.add(new Card("black", "سیاه", "seeyah", 1.0, 1.0, 1.0, ["adjective", "colour"]));
    allCards.add(new Card("blue", "آبی", "abi", 1.0, 1.0, 1.0, ["adjective", "colour"]));
    allCards.add(new Card("brown", "قهوه ای", "ghah-ve-yee", 1.0, 1.0, 1.0, ["adjective", "colour"]));
    allCards.add(new Card("grey", "خاکستری", "khakestari", 1.0, 1.0, 1.0, ["adjective", "colour"]));
    allCards.add(new Card("green", "سبز", "sabz", 1.0, 1.0, 1.0, ["adjective", "colour"]));
    allCards.add(new Card("orange", "نارنجی", "naarenji", 1.0, 1.0, 1.0, ["adjective", "colour"]));
    allCards.add(new Card("purple", "بنفش", "banafsh", 1.0, 1.0, 1.0, ["adjective", "colour"]));
    allCards.add(new Card("red", "قرمز", "ghermez", 1.0, 1.0, 1.0, ["adjective", "colour"]));
    allCards.add(new Card("white", "سفيد", "sefeed", 1.0, 1.0, 1.0, ["adjective", "colour"]));
    allCards.add(new Card("yellow", "زرد", "zard", 1.0, 1.0, 1.0, ["adjective", "colour"]));
    allCards.add(new Card("pink", "صورتی", "soorati", 1.0, 1.0, 1.0, ["adjective", "colour"]));
    
    //Size
    allCards.add(new Card("big", "بزرگ", "bozorg", 1.0, 1.0, 1.0, ["adjective", "size"]));
    allCards.add(new Card("small", "کوچک", "koochek", 1.0, 1.0, 1.0, ["adjective", "size"]));
    allCards.add(new Card("deep", "گود", "god", 1.0, 1.0, 1.0, ["adjective", "size"]));
    allCards.add(new Card("shallow", "کم عمق", "kam omgh", 1.0, 1.0, 1.0, ["adjective", "size"]));
    allCards.add(new Card("long", "دراز", "deraaz", 1.0, 1.0, 1.0, ["adjective", "size"]));
    allCards.add(new Card("short", "کوتاه", "kootaah", 1.0, 1.0, 1.0, ["adjective", "size"]));
    allCards.add(new Card("wide", "پهن", "pahn", 1.0, 1.0, 1.0, ["adjective", "size"]));
    allCards.add(new Card("narrow", "باريک", "baarik", 1.0, 1.0, 1.0, ["adjective", "size"]));
    allCards.add(new Card("thick", "کلفت", "koloft", 1.0, 1.0, 1.0, ["adjective", "size"]));
    allCards.add(new Card("thin", "نازک", "naazok", 1.0, 1.0, 1.0, ["adjective", "size"]));
    
    //Taste
    allCards.add(new Card("bitter", "تلخ", "talkh", 1.0, 1.0, 1.0, ["adjective", "taste"]));
    allCards.add(new Card("fresh", "تازه", "taazeh", 1.0, 1.0, 1.0, ["adjective", "taste"]));
    allCards.add(new Card("salty", "شور", "shoor", 1.0, 1.0, 1.0, ["adjective", "taste"]));
    allCards.add(new Card("sour", "ترش", "torsh", 1.0, 1.0, 1.0, ["adjective", "taste"]));
    allCards.add(new Card("sweet", "شيرين", "shirin", 1.0, 1.0, 1.0, ["adjective", "taste"]));
    allCards.add(new Card("spicy", "تند", "tond", 1.0, 1.0, 1.0, ["adjective", "taste"]));
    
    //Qualities
    allCards.add(new Card("good", "خوب", "khoob", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("bad", "بد", "bad", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("clean", "تميز", "tamiz", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("dirty", "کثيف", "kasif", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("light (illumination)", "چراغ", "cheraagh", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("dark", "تاریک", "taarik", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("easy", "آسان", "aasoon", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("difficult", "سخت", "sakht", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("dry", "خشک", "Khoshk", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("wet", "خیس", "khis", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("full", "پر", "por", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("empty", "خالی", "khaali", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("cheap", "ارزان", "arzoon", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("expensive", "گران", "geroon", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("fast", "سريع", "sari", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("slow", "آهسته", "aahesteh", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("foreign", "خارجی", "khaariji", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("local", "محلی", "mahalli", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("hard (firm)", "سفت", "seft", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("soft", "نرم", "narm", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("heavy", "سنگين", "sangin", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("light (weight)", "سبک", "sabok", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("new", "جدید", "jadid", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("old (thing)", "کهنه", "kohneh", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("young (person)", "جوان", "javoon", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("old (person)", "پير", "peer", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("noisy (person)", "پرحرف", "porharf", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("quiet (person)", "بی سروصدا", "bi saro sedaa", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("noisy (sound)", "بلند", "boland", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("quiet (sound)", "آرام", "aaroom", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("powerful", "قوی", "qavi", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("weak", "ضعيف", "zaeef", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("correct", "درست", "dorost", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("wrong", "غلط", "ghalat", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    
    //Quantities
    allCards.add(new Card("few", "کم", "kam", 1.0, 1.0, 1.0, ["adjective", "quantity"]));
    allCards.add(new Card("many", "زياد", "zeeyaad", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    //allCards.add(new Card("some", "", "", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    //Some / A few (male form)  chan taa / kamee / ba'azee  چن تا / کمی / بعضی
    allCards.add(new Card("very", "خيلی", "kheylee", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("part", "قسمت", "qesmat", 1.0, 1.0, 1.0, ["adjective", "quality"]));
    allCards.add(new Card("whole", "همه", "hamey", 1.0, 1.0, 1.0, ["adjective", "quality"]));

    //Phrase
    allCards.add(new Card("Hi", "سلام", "salam", 1.0, 1.0, 1.0, ["phrase"]));
    allCards.add(new Card("Good morning", "صبح بخیر", "Sobh Be kheyr", 1.0, 1.0, 1.0, ["phrase"]));
    allCards.add(new Card("Good evening", "عصر بخیر", "Asr be kheyr", 1.0, 1.0, 1.0, ["phrase"]));
    allCards.add(new Card("Good night", "شب بخیر", "Shab be kheyr", 1.0, 1.0, 1.0, ["phrase"]));
    allCards.add(new Card("Welcome", "خوش آمدید", "Khosh Amadid", 1.0, 1.0, 1.0, ["phrase"]));
    allCards.add(new Card("How are you?", "حال شما چطور هست", "Haleh shoma chetor hast?", 1.0, 1.0, 1.0, ["phrase"]));
    allCards.add(new Card("Thank you", "ممنون", "Mamnoon", 1.0, 1.0, 1.0, ["phrase"]));
    allCards.add(new Card("You're welcome", "خواهش میکنم", "Khahesh mikonam", 1.0, 1.0, 1.0, ["phrase"]));
    allCards.add(new Card("See you later", "بعدأ میبینمت", "Ba’adan mibinamet", 1.0, 1.0, 1.0, ["phrase"]));
    allCards.add(new Card("Nice to meet you", "از ملاقات شما خوش وقتم", "Az molaghat e sham khosh vaghtam", 1.0, 1.0, 1.0, ["phrase"]));
    allCards.add(new Card("Good luck", "موفق باشید", "Mo’afagh bashed", 1.0, 1.0, 1.0, ["phrase"]));
    allCards.add(new Card("Congratulations", "تبریک می گویم", "Tabrik migoyam", 1.0, 1.0, 1.0, ["phrase"]));
    allCards.add(new Card("Sorry", "ببخشید", "Bebakhshid", 1.0, 1.0, 1.0, ["phrase"]));
    allCards.add(new Card("No Problem", "مشکلی نیست", "Moshkeli nist", 1.0, 1.0, 1.0, ["phrase"]));
    allCards.add(new Card("I need to practice my Persian", "من باید فارسی رو بیشتر تمرین کنم", "Man bayad farsi ro bishtar tamrin konam", 1.0, 1.0, 1.0, ["phrase"]));
    allCards.add(new Card("What?", "چی؟", "Chi?", 1.0, 1.0, 1.0, ["phrase"]));
    allCards.add(new Card("Where?", "کجا؟", "Koja?", 1.0, 1.0, 1.0, ["phrase"]));
    allCards.add(new Card("Why?", "چرا؟", "Chara?", 1.0, 1.0, 1.0, ["phrase"]));
    allCards.add(new Card("Who?", "کی؟", "Ki?", 1.0, 1.0, 1.0, ["phrase"]));
    allCards.add(new Card("When", "کی؟", "Kei?", 1.0, 1.0, 1.0, ["phrase"]));
    allCards.add(new Card("I love you", "دوست دارم", "Doset daram", 1.0, 1.0, 1.0, ["phrase"]));

    allCards.forEach((Card card){
      localStorage[card.getKey()] = card.toString();
    });
    
    
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



