library game_library;

import 'dart:math';
//import 'package:polymer/polymer.dart';
//import 'thewartestbench.dart';

import 'card.dart';
part 'deck.dart';
part 'player.dart';
//part 'player_info.dart';

class Game{
 
  String gameState="None";
  int movecount=0;
  List<Player> players=[];
  List<Map> moves=[];
  List<Card> assetTrack=[];
  Deck assetDeck=null;
  List<Card> actionTrack=[];
  Deck actionDeck=null;
  
  Random random=null;
  
  Game({int seed:0}){
    
    //Init game object with given seed 
    this.random=new Random(seed);
    
    //Player initialization:
    this.initalizePlayers();
    
    //Init decks.
    this.assetDeck=DeckFactory.assetDeck();
    this.assetDeck.shuffle(this.random);
    
    this.actionDeck=DeckFactory.actionDeck();
    this.actionDeck.shuffle(this.random);
    
    stateChange("Initialized with seed "+seed.toString());   
    
  }
  
  Function stateChange(String state,{String p:"Game", String l:""}){
    this.gameState=state;
    movecount++;
    this.moves.add({"move":movecount, "gamestate":state, "player":p, "level":l});
  }
  
  Function initalizePlayers(){
    this.players=[];
    this.players.add(new Player(this, "ov", type:0));
    this.players.add(new Player(this, "fe", type:1));
    this.players.add(new Player(this, "fb", type:2));
    this.stateChange("Added players");
    
  }
  
  Function playTrough({int seed:0}){
    
    initGame();
    
    
    bool gameOver=false;
    
    while (!gameOver){
      gameOver=simTurn();
     
    }
    
    endGame();
    
  }
  Function endGame(){
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
  
  Function initGame({int seed:0}){
    
    
    
    
  }
  
  /** 
   * Simulate single turn for all players.
   * 
   * Return true if this was the last turn of the game.
   */
  bool simTurn(){
    //Assume game over
    bool gameOver=true;
    bool dominance=false;
    
    //Loop players
    for (Player current in this.players){
      
      this.fillDraft();
      
      //Play the players turn
      current.playTurn();
      
      //If any of the players have turns left keep playing for more
      if (!current.lastTurn) gameOver=false;
      
    }
    return gameOver || dominance;
    
  }
  
 
  Function fillDraft(){
    while(this.assetTrack.length<4&&!this.assetDeck.isEmpty()){
      this.assetTrack.add(this.assetDeck.removeLast());
    }
  }
}

