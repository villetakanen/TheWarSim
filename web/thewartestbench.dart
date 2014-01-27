import 'dart:html';
import 'game.dart';

void main() {

  Game game=new Game();
  
  game.playTrough();
  
  querySelector("#gamelog_id")
    ..innerHtml = listToDiv(game.moves);
}



String listToDiv(List a){
  String rval="<div>";
  for (String line in a){
    rval+="<p>"+line+"</p>";
  }
  return rval+"</div>";
}
