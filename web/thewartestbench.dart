import 'dart:html';
import 'game.dart';
import 'package:angular/angular.dart';

/**
 * Angular controller for game running
 */
@NgController(
    selector: '[game-ctrl]',
    publishAs: 'ctrl')
class GameController{
  
  List<String> strategies;
  
  GameController(){
    strategies=[
                "-- default --",
                "Random Decisions"
                ];
  }
  
  Function runWith(int seed){
    Game game=new Game();
    
    if (seed==null){
      seed=0;
      game.stateChange("controller forcing seed to 0");
    }
    
    game.playTrough();
    
    querySelector("#gamelog_id")
    ..innerHtml = listToDiv(game.moves);
    
  }
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

  Game game=new Game();
  
  game.playTrough();
  
  querySelector("#gamelog_id")
    ..innerHtml = listToDiv(game.moves);
}

/**
 * @Deprecated: this should not be done like this
 */
String listToDiv(List a){
  String rval="<div>";
  for (String line in a){
    rval+="<p>"+line+"</p>";
  }
  return rval+"</div>";
}
