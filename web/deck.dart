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
  static const String EVENT="Event";
   
  Card(this.name, this.influence, this.power, this.veiled_power, this.cost, this.type, this.subtype);
  
  Function toPlay(Player a){
    a.inplay.add(this);
    //print("card "+this.name+" owner set to "+a.name);
    this.owner=a;
  }
  
  Function playOn(Card a){
    if (!a.owner.inplay.contains(this)){
      this.toPlay(a.owner);
    }else{
      a.owner.announce("WTF!");
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
  
  /**
   * Count the height of card stack from this card
   */
  int stackHeight(){
    int i=1;
    for (Card child in cardsOnCard){
      i+=stackHeight();
    }
    return i;
  }
  
  Card clone(){
    return new Card(this.name, this.influence, this.power,
        this.veiled_power, this.cost, this.type, this.subtype);
  }
  
}
class Cards{
  
  static const String ConservativeTroll = "Conservative Troll";
  static const String Theorist = "Conspiracy Theorist";
  static const String YoungIdealist     ="Young Idealist";
  static final String CorruptPolitician ="Corrupt Politician";
  static final String Advocate ="Democracy Advocate";
  
  static final Card Remover=new Card("Remover",            1,1,1,7, Card.ASSET,  Card.AGENT);
  
  
  static final Card LameSpy=new Card("Lame Spy",            0,1,0,9, Card.ASSET,  Card.AGENT);
  static final Card ConsTroll         =new Card("Conservative Troll",   0,1,0,3, Card.ASSET,  Card.AGENT);
  //static final Card LameSpy=new Card("Lame Spy",            0,1,0,9, Card.ASSET,  Card.AGENT);
  //static final Card LameSpy=new Card("Lame Spy",            0,1,0,9, Card.ASSET,  Card.AGENT);
  //static final Card LameSpy=new Card("Lame Spy",            0,1,0,9, Card.ASSET,  Card.AGENT);
  
  static final Card Demonstration     =new Card("Demonstrtation",       0,0,0,3, Card.ACTION, Card.TRIFLE);
  static final Card OneWayTicket      =new Card("One Way Ticket",       0,0,0,3, Card.ACTION, Card.RUN);
  static final Card ShadowPlay        =new Card("Shadow Play",          0,0,0,3, Card.ACTION, Card.TRIFLE);
  static final Card Protege           =new Card("Protege",              0,1,0,3, Card.ACTION, Card.TRIFLE);
  
  //Cards for the OV Starter Deck
  static final Card TheGrey           =new Card("The Grey",             2,0,1,0, Card.ASSET, Card.AGENT);
  static final Card Envoy             =new Card("Envoy",                1,2,0,6, Card.ASSET, Card.AGENT);
  
  
  static final Card London            =new Card("London",               1,1,0,0, Card.ASSET, Card.LOCATION);
  static final Card Munich            =new Card("Munich",               0,2,0,0, Card.ASSET, Card.LOCATION);
  static final Card TheTrenches       =new Card("The Trenches",         0,1,1,0, Card.ASSET, Card.LOCATION);
  
  static final Card WarCouncil        =new Card("War Council",          1,1,0,3, Card.ACTION, Card.EVENT);
  //->Protege
  static final Card PowerVacuum       =new Card("Power Vacuum",         0,0,0,3, Card.ACTION, Card.EVENT);
  
  //Cards for the FE Starter Deck
  static final Card Mary              =new Card("Mary, the Wolf Bride", 1,1,1,0, Card.ASSET, Card.AGENT);
  static final Card Oathbound         =new Card("The Oathbound",        0,0,0,3, Card.ASSET, Card.AGENT);
  static final Card Asatru            =new Card("Asàtrú Punk",          0,0,0,3, Card.ASSET, Card.AGENT);
  static final Card BikerGang         =new Card("Biker Gang",           1,1,0,5, Card.ASSET, Card.AGENT);
  
  static final Card Gothenburg        =new Card("Gothenburg",           0,0,0,3, Card.ASSET, Card.LOCATION);
  static final Card Edinburgh         =new Card("Edinburgh",            1,2,0,0, Card.ASSET, Card.LOCATION);
  static final Card LostPaths         =new Card("Lost Pathways",        0,1,1,0, Card.ASSET, Card.LOCATION);
  
  //-> Shadow Play
  //-> One Way Ticket
  //-> Demonstration
  
  //Cards for the FB Starter deck
  static final Card ProtocolZero      =new Card("Protocol Zero",        0,2,1,0, Card.ASSET, Card.AGENT);
  static final Card SecOps            =new Card("SecOps",               0,2,0,0, Card.ASSET, Card.AGENT); 
  static final Card Operator          =new Card("Echelon Operator",     1,0,0,0, Card.ASSET, Card.AGENT); 
  
  static final Card HongKong          =new Card("Hong Kong",            2,1,0,0, Card.ASSET, Card.AGENT);
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
  
  
  static final List<Card> OV_STARTER=[
    new Card(Cards.YoungIdealist,0,0,1,1, Card.ASSET, Card.AGENT),
    new Card(Cards.CorruptPolitician,1,1,1,3, Card.ASSET, Card.AGENT),
                                      Cards.TheGrey.clone(),
                                      Cards.Envoy.clone() ,
                                      Cards.London.clone(),
                                      Cards.Munich.clone(),
                                      Cards.TheTrenches.clone(),
                                      Cards.WarCouncil.clone(),
                                      Cards.Protege.clone(),
                                      Cards.PowerVacuum.clone()];
  static final List<Card> FE_STARTER=[
                                      Cards.Mary.clone(),
                                      Cards.Oathbound.clone(),
                                      Cards.Asatru.clone() ,
                                      Cards.BikerGang.clone(),
                                      Cards.Gothenburg.clone(),
                                      Cards.Edinburgh.clone(),
                                      Cards.LostPaths.clone(),
                                      Cards.Demonstration.clone(),
                                      Cards.OneWayTicket.clone(),
                                      Cards.ShadowPlay.clone()];
  static final List<Card> FB_STARTER=[
                                      Cards.SecOps.clone(),
                                      Cards.ProtocolZero.clone(),
                                      Cards.HongKong.clone() ,
                                      Cards.Operator.clone(),
                                      Cards.London.clone(),
                                      Cards.Munich.clone(),
                                      Cards.TheTrenches.clone(),
                                      Cards.WarCouncil.clone(),
                                      Cards.Protege.clone(),
                                      Cards.PowerVacuum.clone()];
  static final List<Card> ASSET_DECK_3P=[
    new Card(Cards.ConservativeTroll, 0,1,0,3, Card.ASSET, Card.AGENT),
    new Card(Cards.Advocate,          0,1,0,3, Card.ASSET, Card.AGENT),
    new Card(Cards.Theorist,          0,1,1,4, Card.ASSET, Card.AGENT),
    new Card(Cards.CorruptPolitician, 1,1,1,3, Card.ASSET, Card.AGENT),
    
                                         Cards.Remover.clone(),
                                         Cards.Envoy.clone(),

                                         Cards.BikerGang.clone(),
                                         Cards.ConsTroll.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         Cards.LameSpy.clone(),
                                         ];
}