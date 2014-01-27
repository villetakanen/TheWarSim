part of game_library;

class Player{
  
  Game game;
  String name;
  bool lastTurn=true;
  
  List<Card>hand=[];
  List<Card>deck=[];
  List<Card>discard=[];
  List<Card>inplay=[];
  
  Player(Game this.game, String this.name, {int type: 0}){
    
    
    //Choose starting deck type
    switch (type){
      case 3:
        this.name+="/3";
        break;
      case 2:
        this.name+="/2";
        break;
      default:
        this.name+="/0";
        this.initDeck(Deck.OV_STARTER);
    }
    
    this.draw();
    this.remark("initialized");
    
  }
  
  Function remark(String remark){
    game.stateChange("&nbsp;&nbsp;&nbsp;:: "+this.name+" ::  "+remark);
  }
  Function note(String remark){
    game.stateChange("&nbsp;&nbsp;&nbsp;## "+this.name+" ->  "+remark);
  }
  
  Function initDeck(List<Card> a){
    this.deck=[];
      this.deck.addAll(a);
   
  }
  
  Function playTurn(){
    this.remark("Starting turn");
    
    //Fill hand up to ~5 cards
    this.draw();
    
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

  /**
   * Function for choosing the card to draft. Override for alternative strategy.
   */
  Function chooseDraft(){
    return null;
  }
  
}