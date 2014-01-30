import 'dart:html';
//import 'dart:async';
import 'game.dart';
import 'dart:math';
import 'package:angular/angular.dart';


/**
 * Angular controller for running a game
 */

@NgController(
    selector: '[game-ctrl]',
    publishAs: 'ctrl')

class GameController{
 
  Game game; //Currently active game;
  List<Map> gamelog=[];
  List<Card> inplay=null;
  List<Card> inplay2=null;
  List<Card> inplay3=null;
  String result;
  List<Strategy> strategies;
  
  GameController(){
    strategies=[new Strategy("-- default --"),
                new Strategy("Random Decicions")
                ];
    
    game=new Game();
    
    game.playTrough(seed:0);//new Random().nextInt(27000));
    
    //gamelog=game.moves.where((Map i) => i["level"]!="note").toList();
    gamelog=game.moves;
    result=game.gameState;
    inplay=game.players[0].inplay.onTable;
    inplay2=game.players[1].inplay.onTable;
    inplay3=game.players[2].inplay.onTable;

  }
  
  
  
  Function setStrategy(int player, Strategy strategy){
    
  }
  
  Function runWith({int seed}){
    Game game=new Game();
    
    if (seed==null){
      int seed=new Random().nextInt(10000);
      game.stateChange("controller forcing seed to "+seed.toString());
      
    }
    
    game.initGame(seed:seed);
    gamelog=null;
    gamelog=game.moves;
    result=game.gameState;
    inplay=game.players[0].inplay.onTable;
    inplay2=game.players[1].inplay.onTable;
    inplay3=game.players[2].inplay.onTable;

    
  }
  Function playTurn(){
    if (game.simTurn()) game.endGame();
    gamelog=game.moves;
    result=game.gameState;
    inplay=game.players[0].inplay.onTable;
    inplay2=game.players[1].inplay.onTable;
    inplay3=game.players[2].inplay.onTable;
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
    //type(Profiler, implementedBy: Profiler); // comment out to enable profiling
  }
}

/**
 * 
 */
void main() {
  
  //Bootstrap Angular Framework
  ngBootstrap(module: new MyAppModule());

}


