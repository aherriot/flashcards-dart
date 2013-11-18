part of flashcards;

class Card
{
  String english;
  String farsi;
  String phonetic;
  
  double englishScore;
  double farsiScore;
  double phoneticScore;
  
  List<String> tags;
  
  Card(this.english, this.farsi, this.phonetic, this.englishScore, this.farsiScore, this.phoneticScore, this.tags);
  Card.fromString(String data) {
    
    List<String> dataItems = data.split("|");
    
    if(dataItems.length == 7) {    
      english = dataItems[0];
      farsi = dataItems[1];
      phonetic = dataItems[2];
      
      englishScore = double.parse(dataItems[3]);
      farsiScore = double.parse(dataItems[4]);
      phoneticScore = double.parse(dataItems[5]);
      
      tags = dataItems[6].split(",");
      
    } else if (dataItems.length == 4) {
      
      english = dataItems[0];
      farsi = dataItems[1];
      phonetic = dataItems[2];
      
      englishScore = farsiScore = phoneticScore = 1.0;
      
      tags = dataItems[3].split(",");
    }
    
  }
  
  int compareEnglishScore(Card other) {
    if(englishScore < other.englishScore)
      return -1;
    else if(englishScore == other.englishScore)
      return 0;
    else
      return 1;
  }
  
  int compareFarsiScore(Card other) {
    if(farsiScore < other.farsiScore)
      return -1;
    else if(farsiScore == other.farsiScore)
      return 0;
    else
      return 1;
  }
  
  int comparephoneticScore(Card other) {
    if(phoneticScore < other.phoneticScore)
      return -1;
    else if(phoneticScore == other.phoneticScore)
      return 0;
    else
      return 1;
  }
  
  String toString() {
    return "$english|$farsi|$phonetic|$englishScore|$farsiScore|$phoneticScore|${tagsAsCSV()}";
  }
  
  //Return a string with an html representation of this object for editing. 
  TableRowElement toTableRowElement() {
    TableRowElement row = new TableRowElement();
    
    TableCellElement cell = row.addCell();    
    cell.innerHtml = '<input type="text" name="english" size="6" placeholder="english" value="$english">\n';

    cell = row.addCell();
    cell.innerHtml = '<input type="text" name="farsi" size= "6" placeholder="farsi" value="$farsi">\n';

    cell = row.addCell();
    cell.innerHtml = '<input type="text" name="phonetic" size= "6" placeholder="Latin Farsi" value="$phonetic">\n';
    
    cell = row.addCell();
    cell.innerHtml = '<input type="text" name="englishScore" size= "1" placeholder="English Score" value="$englishScore">\n';
        
    cell = row.addCell();
    cell.innerHtml = '<input type="text" name="farsiScore" size= "1" placeholder="Farsi Score" value="$farsiScore">\n';
    
    cell = row.addCell();
    cell.innerHtml = '<input type="text" name="phoneticScore" size= "1" placeholder="Latin Farsi Score" value="$phoneticScore">\n';
    
    cell = row.addCell();
    cell.innerHtml = '<input type="text" name="tags" size= "20" placeholder="Filter tags" value="${tagsAsCSV()}">\n';
    return row;
  }
  
  //return true if this card matches All of the tags in the list tagsToFilter
  bool hasTags(List<String> tagsToFilter)
  {
    
    for(String tag in tagsToFilter) {
      tag = tag.trim();
      
      if (tag.isEmpty)
        continue;
      
      if(!tags.contains(tag)) {
        return false;
      }
    }
    return true;
  }
  
  //return string
  String tagsAsCSV() {
    
    return tags.join(",");
  }
  
  String getKey() {
    return "Card:" + english;
  }
  
  //hashCode function inspired by the Dart documentation
  int get hashCode {
    int result = 17;
    result = 37 * result + english.hashCode;
    result = 37 * result + farsi.hashCode;
    result = 37 * result + phonetic.hashCode;
    return result;
  }
  
  bool operator==(other) {
    
    return (
      other.english == english && 
      other.farsi == farsi &&
      other.phonetic == phonetic
    );
  }
  

}