part of game_library;

class Player{
  
  
  Game game;           //Backlink to the game object
  String name;         //This players name for loggin etc.
  bool lastTurn=false; //Boolean info "is it my last turn"
  bool hasDominance=false;
  int influence=5;     //Current infuence pool, starts at 5
  
  InPlay inplay;       //Wrapper object for all things this player has in play
  
  //Cards in hand
  List<Card>hand=[];
  
  //Cards in my deck.
  List<Card>deck=[];
  
  //Cards in my discard
  List<Card>discard=[];
  
  Player(Game this.game, String this.name, {int type: 0}){
    
    this.inplay=new InPlay(this);   //Create new in play area for this player.
    
    this.initDecks(type);           //Initialize hand, discard and deck
    
    this.name+="/"+type.toString(); //Add deck type to name
    
    this.draw();                    //Draw up to handsize
    
    this.remark("Initialized");
    
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
  
  /**
   * Initialize player's decks. Called by the constructor.
   */
  Function initDecks(int type){
    
    this.hand=[];
    this.deck=[];
    this.discard=[];
    
    switch (type){
      case 0:
        this.deck=DeckFactory.ordoVellumStarter();
        break;
      case 1:
        this.deck=DeckFactory.cultOfFenrirStarter();
        break;
      case 2:
        this.deck=DeckFactory.F_BStarter();
        break;
      default:
        throw new ArgumentError("Trying to init deck without a valid type");
    }
    
    this.deck.shuffle(game.random);
   
  }
  
  Function playTurn(){
    if (lastTurn==true) return null;
    
    remark("Starting turn");
    
    //Fill hand up to ~5 cards
    draw();
    
    playAssets();
    
    draft();
    
    this.influence+=inplay.influencePotential();
    
    remark("ending turn with "+this.influence.toString()+" influene");
    
  }
  
  
  
  
  
  int endpower(){
    int p=inplay.power();
    for (Card card in this.hand){
      p+=card.power;
    }
    return p;
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
        
    }
    note ("my hand is "+hand.toString());
    
  }
  
  Function playAssets(){
    
    int i=0;
    while (i<this.hand.length){
      Card card=this.hand[i];
      if(card.subtype==Card.LOCATION){
        this.hand.remove(card);
        inplay.toTable(card);
        remark("Asset to play:"+card.name);
      }
      else i++;
    }
    
    //Go tr
    i=0;
    while (i<this.hand.length){
      Card card=this.hand[i];
      Card target=null;
      if(card.subtype==Card.AGENT){
        this.hand.remove(card);
        int hval=10000;
        for (Card location in inplay.getLocations()){
          if (location.stackHeight()<hval){
            hval=location.stackHeight();            
            target=location;
          }
        }
        if (target!=null){
          card.playOn(target);
        }
        else{
          this.inplay.toTable(card);
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
      double cval=0.0;
      if (inplay.influencePotential()<6) cval=(card.influence*2+card.power)/(card.cost+27);
      else cval=(card.power*2+card.veiled_power)/(card.cost+27);
      
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
/**
 * Helper class for cards in play (on the table or on a card on the table)
 */
class InPlay{
  
  List<Card> inPlay=[];
  List<Card> onTable=[];
  Player player;
  
  InPlay(this.player);
 
  Function toPlay(Card card){
    inPlay.add(card);
    card.owner=player;
  }
  
  Function toTable(Card card){
    onTable.add(card);
    toPlay(card);
  }
  
  bool contains(Card card){
    return inPlay.contains(card);
  }
  
  Function burn(Card card){
    if (!this.inPlay.contains(card)) throw new ArgumentError("Can not burn a card not in play");
    
    for (Card child in card.cardsOnCard){
      burn(child);
    }
    
    onTable.remove(card);
    inPlay.remove(card);
    player.discard.add(card);
  }
  List<Card> getLocations(){
    return this.onTable.where((Card i) => i.subtype==Card.LOCATION).toList();
    
  }
  int influencePotential(){
    int potential=0;
    for (Card card in this.inPlay){
      potential+=card.influence;
    }
    return potential;
  }
  int power(){
    int p=0;
    for (Card card in this.inPlay){
      p+=card.power;
    }
    return p;
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
