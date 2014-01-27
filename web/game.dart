library game_library;

import 'dart:math';

part 'deck.dart';
part 'player.dart';

class Game{
 
  String gameState="None";
  List<Player> players=[];
  List<String> moves=[];
  Random random=null;
  
  Game(){
    stateChange("initialized");
  }
  
  Function stateChange(String state){
    this.gameState=state;
    this.moves.add(state);
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
    
    bool gameOver=false;
    
    while (!gameOver){
      
      //Assume game over
      gameOver=true;
      
      //Loop players
      for (Player current in this.players){
        
        //Play the players turn
        current.playTurn();
        
        //If any of the players have turns left keep playing for more turns
        if (!current.lastTurn) gameOver=false;
 
      }
     
    }
    
  }
}

