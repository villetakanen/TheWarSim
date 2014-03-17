import 'dart:html';
import 'dart:async';
import 'game.dart';
//import 'dart:math';
import 'package:angular/angular.dart';
import 'package:polymer/polymer.dart';
import 'player_info.dart';
import 'game_info.dart';

/**
 * Angular controller for running a game
 */

@NgController(
    selector: '[game-ctrl]',
    publishAs: 'ctrl')

class GameController{
 
  Game game; //Currently active game;
  bool gameActive=false;
  String gameState="";
    
  GameController(){

  }
  
  void initGame({int seed:0}){
    game=new Game(seed:seed);
    gameActive=true;
    this.gameState=game.gameState;
    refreshPlayerInfo();
  }
  
  void refreshPlayerInfo(){
    for (Player player in this.game.players){
      
      String info_id='#'+player.name+'pi';
      PlayerInfo info = querySelector(info_id);
      
      info.influence=player.influence;
      info.influencePotential=player.inplay.influencePotential();
      info.power=player.inplay.power();
      
      info.hand=player.hand.cards.toList(growable: false);
      info.play=player.inplay.inPlay.cards.toList(growable: false);
      
    }
    
    GameInfo game_i = querySelector('#game_log');
    List<String> l=[];
    game.moves.forEach((move) => l.add(move['player']+" :: "+move['gamestate']));
    game_i.log=l.reversed.toList();
    
    scheduleMicrotask(Observable.dirtyCheck);
  }
  
  
  
  Function playTurn(){
    if (game.simTurn()) game.endGame();
    this.gameState=game.gameState;
    
    refreshPlayerInfo();
  }
  
  
  /**
   * Workaround for unimplemented AngularDart features
   */
  Function noteHack(bool show){
    for (var elem in querySelectorAll('.note')) { // Find all elements for this OS.
      elem.hidden = show;      // Show or hide each element.
    }
  }
  
  /**
   * Workaround for unimplemented AngularDart features
   */
  Function remarkHack(bool show){
    for (var elem in querySelectorAll('.remark')) { // Find all elements for this OS.
      elem.hidden = show;      // Show or hide each element.
    }
  }
}


class Strategy{
  String name;
  Strategy(this.name);
}

class MyAppModule extends Module {
  MyAppModule() {
    type(GameController);

  }
}

/**
 * 
 */
void main() {
  
  initPolymer();
  
  //Bootstrap Angular Framework
  ngBootstrap(module: new MyAppModule());

}


