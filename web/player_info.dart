library the_war_polymer_ui;
import 'card.dart';
import 'package:polymer/polymer.dart';

@CustomTag('player-info')
class PlayerInfo extends PolymerElement{
  
  @observable int influence=0;
  @observable int power=0;
  @observable int influencePotential=0;
  @observable List<Card> hand=[];
  @observable List<Card> play=[]; 
  
  //TODO: Make player moves interceptable to player info element
  //@observable List<String> moves=[];
 
  PlayerInfo.created(): super.created();

}
