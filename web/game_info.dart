library the_war_polymer_ui_game;

import 'package:polymer/polymer.dart';

@CustomTag('game-info')
class GameInfo extends PolymerElement{
  
  @observable List<String> log=[]; 
  
  //TODO: Make player moves interceptable to player info element
  //@observable List<String> moves=[];
 
  GameInfo.created(): super.created();

}