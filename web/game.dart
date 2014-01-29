library game_library;

import 'dart:math';

part 'deck.dart';
part 'player.dart';

class Game{
 
  String gameState="None";
  int movecount=0;
  List<Player> players=[];
  List<Map> moves=[];
  List<Card> assetTrack=[];
  List<Card> assetDeck=[];
  
  Random random=null;
  
  Game(){
    stateChange("initialized");
  }
  
  Function stateChange(String state,{String p:"Game", String l:""}){
    this.gameState=state+"  -- "+movecount.toString();
    movecount++;
    this.moves.add({"move":movecount, "gamestate":state, "player":p, "level":l});
  }
  
  Function initalizePlayers(){
    this.players=[];
    this.players.add(new Player(this, "OV"));
    this.players.add(new Player(this, "FE", type:2));
    this.players.add(new Player(this, "FB", type:3));
    this.stateChange("Added players");
    
  }
  
  Function playTrough({int seed:0}){
    this.stateChange("Playtrough with seed "+seed.toString());
    this.random=new Random(seed);
    
    this.initalizePlayers(); 
    this.assetDeck=Deck.ASSET_DECK_3P;
    this.assetDeck.shuffle(this.random);
    
    
    bool gameOver=false;
    
    while (!gameOver){
      
      //Assume game over
      gameOver=true;
      
      //Loop players
      for (Player current in this.players){
        
        this.fillDraft();
        
        //Play the players turn
        current.playTurn();
        
        //If any of the players have turns left keep playing for more turns
        if (!current.lastTurn) gameOver=false;
 
      }
     
    }
    int maxPower=0;
    Player winner=null;
    for (Player player in players){
      if (player.endpower()>maxPower){
        winner=player;
        maxPower=winner.endpower();
      }
    }
    stateChange("Winner is "+winner.name +" with "+winner.endpower().toString()+" power");
    
  }
  
 
  Function fillDraft(){
    while(this.assetTrack.length<4&&this.assetDeck.isNotEmpty){
      this.assetTrack.add(this.assetDeck.removeLast());
    }
  }
}

