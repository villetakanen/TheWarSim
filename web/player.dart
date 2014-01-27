part of game_library;

class Player{
  
  Game game;
  String name;
  bool lastTurn=false;
  int influence=0;
  
  List<Card>hand=[];
  List<Card>deck=[];
  List<Card>discard=[];
  List<Card>inplay=[];
  
  Player(Game this.game, String this.name, {int type: 0}){
    
    
    //Choose starting deck type
    switch (type){
      case 3:
        this.name+="/3";
        this.initDeck(Deck.FB_STARTER);
        break;
      case 2:
        this.name+="/2";
        this.initDeck(Deck.FE_STARTER);
        break;
      default:
        this.name+="/0";
        this.initDeck(Deck.OV_STARTER);
    }
    
    this.draw();
    this.remark("initialized");
    
  }
  
  Function remark(String remark){
    game.stateChange(" :: "+this.name+" ::  "+remark, l:"remark", p:"player");
  }
  Function note(String remark){
    game.stateChange(" ## "+this.name+" ->  "+remark, l:"note",p:"player");
  }
  
  Function initDeck(List<Card> a){
    this.deck=[];
      this.deck.addAll(a);
   
  }
  
  Function playTurn(){
    this.remark("Starting turn");
    
    //Fill hand up to ~5 cards
    this.draw();
    
    this.draft();
    
  }
  
  Function draw(){
   
    while (!(this.deck.isEmpty 
        && this.discard.isEmpty)
        && this.hand.length<5){
      
      if (this.deck.isEmpty){
        this.note("Shuffling the discard to deck");
        
        List <Card> temp=this.deck;
        this.deck=this.discard;
        this.discard=temp;
        
        this.deck.shuffle(this.game.random);
      }
      
      
      this.hand.add(this.deck.removeLast());
      this.note("drew "+this.hand.last.name);
        
    }
    
  }
  
  Function draft(){
    this.influence+=4;
    
    if(this.game.assetDeck.isEmpty){
      this.lastTurn=true;
      return null;
    }
    
    Card card=this.chooseDraftAsset();
    
    if (card!=null && card.cost<=this.influence){
      this.game.assetTrack.remove(card);
      this.discard.add(card);
      card.owner=this;
      this.remark("Drafted "+card.name);
    }
    else this.remark("");
    
  }

  /**
   * Method for choosing the card to draft. Override for alternative strategy.
   */
  Card chooseDraftAsset(){
    Card chosen=null;
    double hval=-1.0;
    for (Card card in game.assetTrack){
      double cval=(card.influence+card.power+card.veiled_power)/(card.cost+27);
      if (card.cost<=this.influence && cval>hval){
        hval=cval;
        chosen=card;
        this.note("eval "+cval.toString()+" for "+card.name);
      }
    }
    if (chosen!=null) this.remark("I chose "+chosen.name);
    return chosen;
  }
  
}

class RandomStrategyPlayer extends Player{
  RandomStrategyPlayer(Game game, String name, {int type: 0}):
    super (game, name,type:type){
    
    this.name+=" (using random strategy) ";
  }
   
  Card chooseDraftAsset(){
    remark("Picking up a random card");
    return this.game.assetTrack[this.game.random.nextInt(this.game.assetTrack.length-1)];
  }

}
