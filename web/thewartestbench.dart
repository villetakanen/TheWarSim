import 'dart:html';
import 'game.dart';
import 'dart:math';
import 'package:angular/angular.dart';

/**
 * Angular controller for game running
 */
@NgController(
    selector: '[game-ctrl]',
    publishAs: 'ctrl')
class GameController{
  List<Map> gamelog=[];
  
  List<Strategy> strategies;
  
  GameController(){
    strategies=[new Strategy("-- default --"),
                new Strategy("Random Decicions")
                ];
    
    Game game=new Game();
    
    game.playTrough(seed:0);//new Random().nextInt(27000));
    
    gamelog=game.moves;
  }
  
  Function setStrategy(int player, Strategy strategy){
    
  }
  
  Function runWith(int seed){
    Game game=new Game();
    
    if (seed==null){
      //seed=0;
      //game.stateChange("controller forcing seed to 0");
      
    }
    
    game.playTrough();

    
  }
  
  Function noteHack(bool show){
    for (var elem in querySelectorAll('.note')) { // Find all elements for this OS.
      elem.hidden = show;      // Show or hide each element.
    }
  }
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


