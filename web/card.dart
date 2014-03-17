library CardLibrary;
import 'game.dart';

class Card{
  
  String name;
  int influence;
  int power;
  int veiled_power;
  int cost;
  String type;
  String subtype;
  
  Player owner;
  Game game;
  
  Card parent;
  List<Card> cardsOnCard=[];
  
  static const String ACTION="Action";
  static const String ASSET="Asset";
  
  static const String AGENT="Agent";
  static const String LOCATION="Location";
  static const String RUN="Run";
  static const String TRIFLE="Trifle";
  static const String EVENT="Event";
   
  Card(this.name, this.influence, this.power, this.veiled_power, this.cost, this.type, this.subtype);
  
  Function playOn(Card a){
    if (a.owner==null) throw new ArgumentError("trying to play a card on an uncontrolled card");
    a.owner.inplay.toPlay(this);
    a.cardsOnCard.add(this);
    //print(a.name+" has "+a.cardsOnCard.toString());
  }
  
  /**
   * Count the height of card stack from this card
   */
  int stackHeight(){
    int i=1;
    for (Card child in cardsOnCard){
      i+=child.stackHeight();
    }
    return i;
  }
  
  Card clone(){
    return new Card(this.name, this.influence, this.power,
        this.veiled_power, this.cost, this.type, this.subtype);
  }
  
  String toString(){
    return this.name;
  }
  
}