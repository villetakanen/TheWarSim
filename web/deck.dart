part of game_library;


class Cards{
  
  static const String ConservativeTroll = "Conservative Troll";
  static const String Theorist = "Conspiracy Theorist";
  static const String YoungIdealist     ="Young Idealist";
  static final String CorruptPolitician ="Corrupt Politician";
  static final String Advocate ="Democracy Advocate";
  static final String Barcelona="Barcelona";
  
  static final String Immateria="Immateria";
  static final String NewYork="New York";
  static final String Shanghai="Shanghai";
  static final String StPetersburg="St. Petersburg";
  static final String Tokyo="Tokyo";
  static final String Warsaw="Warsaw";
  
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
    
    new Card(Cards.Barcelona,         1,1,2,5, Card.ASSET, Card.LOCATION),
    new Card(Cards.Immateria,         0,1,2,5, Card.ASSET, Card.LOCATION),
    new Card(Cards.NewYork,           1,3,0,7, Card.ASSET, Card.LOCATION),
    new Card(Cards.Shanghai,          1,3,0,7, Card.ASSET, Card.LOCATION),
    new Card(Cards.StPetersburg,      1,4,0,9, Card.ASSET, Card.LOCATION),
    new Card(Cards.Tokyo,             0,2,0,5, Card.ASSET, Card.LOCATION),
    new Card(Cards.Warsaw,            1,2,0,6, Card.ASSET, Card.LOCATION),
    
                                         ];
}