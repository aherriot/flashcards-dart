part of flashcards;

class Card
{
  String english;
  String farsi;
  String latinFarsi;
  
  double englishScore;
  double farsiScore;
  double latinFarsiScore;
  
  List<String> tags;
  
  Card(this.english, this.farsi, this.latinFarsi, this.englishScore, this.farsiScore, this.latinFarsiScore, this.tags);
  Card.fromString(String data) {
    
    List<String> dataItems = data.split("|");
    
    english = dataItems[0];
    farsi = dataItems[1];
    latinFarsi = dataItems[2];
    
    englishScore = double.parse(dataItems[3]);
    farsiScore = double.parse(dataItems[4]);
    latinFarsiScore = double.parse(dataItems[5]);
    
    tags = dataItems[6].split(",");
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
  
  int compareLatinFarsiScore(Card other) {
    if(latinFarsiScore < other.latinFarsiScore)
      return -1;
    else if(latinFarsiScore == other.latinFarsiScore)
      return 0;
    else
      return 1;
  }
  
  String toString() {
    return "$english|$farsi|$latinFarsi|$englishScore|$farsiScore|$latinFarsiScore|${tagsAsCSV()}";
  }
  
  //Return a string with an html representation of this object for editing. 
  TableRowElement toTableRowElement() {
    TableRowElement row = new TableRowElement();
    
    TableCellElement cell = row.addCell();    
    cell.innerHtml = '<input type="text" name="english" size="6" placeholder="english" value="$english">\n';

    cell = row.addCell();
    cell.innerHtml = '<input type="text" name="farsi" size= "6" placeholder="farsi" value="$farsi">\n';

    cell = row.addCell();
    cell.innerHtml = '<input type="text" name="latinFarsi" size= "6" placeholder="Latin Farsi" value="$latinFarsi">\n';
    
    cell = row.addCell();
    cell.innerHtml = '<input type="text" name="englishScore" size= "1" placeholder="English Score" value="$englishScore">\n';
        
    cell = row.addCell();
    cell.innerHtml = '<input type="text" name="farsiScore" size= "1" placeholder="Farsi Score" value="$farsiScore">\n';
    
    cell = row.addCell();
    cell.innerHtml = '<input type="text" name="latinFarsiScore" size= "1" placeholder="Latin Farsi Score" value="$latinFarsiScore">\n';
    
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
    String csv = tags.toString();
    
    //delete the outer brackets from the string i.e. "[]"
    if(tags.length > 0)
      csv = csv.substring(1, csv.length-1);
    
    return csv;  
  }

}