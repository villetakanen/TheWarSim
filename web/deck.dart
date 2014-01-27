part of game_library;

class Card{
  
  String name;
  int influence;
  int power;
  int veiled_power;
  int cost;
  String type;
  String subtype;
  
  Player owner;
  
  Card parent;
  List<Card> cardsOnCard=[];
  
  static const String ACTION="Action";
  static const String ASSET="Asset";
  
  static const String AGENT="Agent";
  static const String LOCATION="Location";
  static const String RUN="Run";
  static const String TRIFLE="Trifle";
  static const String Event="Event";
   
  Card(this.name, this.influence, this.power, this.veiled_power, this.cost, this.type, this.subtype);
  
  Function toPlay(Player a){
    a.inplay.add(this);
    this.owner=a;
  }
  
  Function playOn(Card a){
    if (!a.owner.inplay.contains(this)){
      this.toPlay(a.owner);
    }
    this.cardsOnCard.add(a);
  }
  
  Function burn(){
    for (Card child in cardsOnCard){
      child.burn();
    }
    this.cardsOnCard=[];
    parent.cardsOnCard.remove(this);
    if (this.owner!=null){
      owner.inplay.remove(this);
      owner.discard.add(this);
    }
    
  }
}
class Cards{
  
  static final Card Remover=new Card("Remover",            1,1,1,7, Card.ASSET,  Card.AGENT);
  
  static final Card LameSpy=new Card("Lame Spy",            1,1,1,5, Card.ASSET,  Card.AGENT);
  
  static final Card Demonstration     =new Card("Demonstrtation",       0,0,0,3, Card.ACTION, Card.TRIFLE);
  static final Card OneWayTicket      =new Card("One Way Ticket",       0,0,0,3, Card.ACTION, Card.RUN);
  static final Card ShadowPlay        =new Card("Shadow Play",          0,0,0,3, Card.ACTION, Card.TRIFLE);
  static final Card Protege           =new Card("Protege",              0,1,0,3, Card.ACTION, Card.TRIFLE);
  
  //Cards for the OV Starter Deck
  static final Card TheGrey           =new Card("The Grey",             0,0,0,3, Card.ASSET, Card.AGENT);
  static final Card Envoy             =new Card("Envoy",                0,0,0,3, Card.ASSET, Card.AGENT);
  static final Card CorruptPolitician =new Card("Corrupt Politician",   0,0,0,3, Card.ASSET, Card.AGENT);
  static final Card YoungIdealist     =new Card("Young Idealist",       0,0,0,3, Card.ASSET, Card.AGENT);
  
  static final Card London            =new Card("London",               0,0,0,3, Card.ASSET, Card.LOCATION);
  static final Card Munich            =new Card("Munich",               1,2,0,0, Card.ASSET, Card.LOCATION);
  static final Card TheTrenches       =new Card("The Trenches",         0,1,1,0, Card.ASSET, Card.LOCATION);
  
  static final Card WarCouncil        =new Card("War Council",          1,1,0,3, Card.ACTION, Card.EVENT);
  //->Protege
  static final Card PowerVacuum       =new Card("Power Vacuum",         0,0,0,3, Card.ACTION, Card.EVENT);
  
  //Cards for the FE Starter Deck
  static final Card Mary              =new Card("Mary, the Wolf Bride", 0,0,0,3, Card.ASSET, Card.AGENT);
  static final Card Oathbound         =new Card("The Oathbound",        0,0,0,3, Card.ASSET, Card.AGENT);
  static final Card Asatru            =new Card("Asàtrú Punk",          0,0,0,3, Card.ASSET, Card.AGENT);
  static final Card BikerGang         =new Card("Biker Gang",           0,0,0,3, Card.ASSET, Card.AGENT);
  
  static final Card Gothenburg        =new Card("Gothenburg",           0,0,0,3, Card.ASSET, Card.LOCATION);
  static final Card Edinburgh         =new Card("Edinburgh",            1,2,0,0, Card.ASSET, Card.LOCATION);
  static final Card LostPaths         =new Card("Lost Pathways",        0,1,1,0, Card.ASSET, Card.LOCATION);
  
  //-> Shadow Play
  //-> One Way Ticket
  //-> Demonstration
  
}
class Deck{
  
  static Function shuffle(Game game, List<Card> deck){
    
    int N=deck.length;
    
    for (int i = 0; i<N; i++) {
      int r = i + (game.random.nextInt(N-1));
      Card swap = deck[r];
      deck[r] = deck[i];
      deck[i] = swap;
    }
    
  }
  
  
  static final List<Card> OVSTARTER=[
    Cards.TheGrey,
    Cards.Envoy,
    Cards.CorruptPolitician,
    Cards.YoungIdealist,
    Cards.London,
    Cards.Munich,
    Cards.TheTrenches];
}