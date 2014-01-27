part of game_library;

class Player{
  
  Game game;
  String name;
  bool lastTurn=false;
  int influence=5;
  
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
  /**
   * Post game info to game log
   */
  Function announce(String remark){
    game.stateChange(this.name+": "+remark, p:"player",l:"PA");
  }
  /**
   * Post a remark to game log
   */
  Function remark(String remark){
    game.stateChange(" :: "+this.name+" ::  "+remark, l:"remark", p:"player");
  }
  /**
   * Make an AI mental note to the gamelog
   */
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
    
    this.playAssets();
    
    this.draft();
    
    this.influence+=influencePotential();
    this.remark("ending turn with "+this.influence.toString()+" influene");
    
  }
  int influencePotential(){
    int potential=0;
    for (Card card in this.inplay){
      potential+=card.influence;
      this.note(card.name+" for"+card.influence.toString());
    }
    return potential;
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
  
  Function playAssets(){
    
    int i=0;
    while (i<this.hand.length){
      Card card=this.hand[i];
      if(card.subtype==Card.LOCATION){
        this.hand.remove(card);
        card.toPlay(this);
        remark("Asset to play:"+card.name);
      }
      else i++;
    }
    
    List<Card> locationsInPlay=inplay.where((i) => i.subtype==Card.LOCATION).toList();
    
    i=0;
    while (i<this.hand.length){
      Card card=this.hand[i];
      if(card.subtype==Card.AGENT){
        this.hand.remove(card);
        int hval=10000;
        for (Card location in locationsInPlay){
          if (location.stackHeight()<hval){
            hval=location.stackHeight();
            
            print(location.name+" / "+card.name);
            
            card.playOn(location);
            remark("Agent "+card.name+" to play on "+location.name);
          }
        }
        if (hval==10000){
          card.toPlay(this);
          remark("Agent "+card.name+" to play as a Free Agent");
        }
      }
      else i++;
    }
    
  }
  
  Function draft(){
    
    if(this.game.assetDeck.isEmpty){
      this.lastTurn=true;
      return null;
    }
    
    Card card=this.chooseDraftAsset();
    
    if (card!=null && card.cost<=this.influence){
      
      this.game.assetTrack.remove(card);
      this.discard.add(card);
      card.owner=this;
      this.influence-=card.cost;
      this.announce("Drafted "+card.name+" with "+card.cost.toString());
      
    }
    else this.remark("Did not draft");
    
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
    if (chosen!=null) this.note("I chose "+chosen.name);
    else this.note("did not pick a card");
    return chosen;
  }
  
}

class RandomStrategyPlayer extends Player{
  RandomStrategyPlayer(Game game, String name, {int type: 0}):
    super (game, name,type:type){
    
    this.name+=" (using random strategy) ";
  }
   
  Card chooseDraftAsset(){
    note("Picking up a random card");
    if (this.game.assetDeck.isEmpty) return null;
    return this.game.assetTrack[this.game.random.nextInt(this.game.assetTrack.length-1)];
  }

}
