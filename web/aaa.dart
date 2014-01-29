div id="game_info_id">
    <div class="player_info">
      <h2>Ordo Vellum +{{ctrl.game.players[0].endpower()}}</h2>
      <h4>In play +{{ctrl.game.players[0].inplay.influencePotential()}}i</h4>
      <ul>
        <li ng-repeat="line in ctrl.inplay">{{line.name}}
          <ul>
            <li ng-repeat="line2 in line.cardsOnCard">{{line2.name}}</li>
          </ul>
        </li>
      </ul>
      <p></p>
      <h4>Hand</h4>
      <ul>
        <li ng-repeat="card in ctrl.game.players[0].hand">{{card.name}}</li>       
      </ul>
      <h4>Discard</h4>
      <ul>
        <li ng-repeat="card in ctrl.game.players[0].discard">{{card.name}}</li>
      </ul>
      <h4>Deck</h4>
      <ul>
        <li ng-repeat="card in ctrl.game.players[0].deck">{{card.name}}</li>
      </ul>
    </div>
    
    <div class="player_info">
      <h2>Cult of Fenrir +{{ctrl.game.players[1].endpower()}}</h2>
      <h4>In play +{{ctrl.game.players[1].inplay.influencePotential()}}i</h4>
      <ul>
        <li ng-repeat="line in ctrl.inplay2">{{line.name}}
          <ul>
            <li ng-repeat="line2 in line.cardsOnCard">{{line2.name}}</li>
          </ul>
        </li>
      </ul>
      <p></p>
      <h4>Hand</h4>
      <ul>
        <li ng-repeat="card in ctrl.game.players[1].hand">{{card.name}}</li>       
      </ul>
      <h4>Discard</h4>
      <ul>
        <li ng-repeat="card in ctrl.game.players[1].discard">{{card.name}}</li>
      </ul>
      <h4>Deck</h4>
      <ul>
        <li ng-repeat="card in ctrl.game.players[1].deck">{{card.name}}</li>
      </ul>
    </div>
    
    <div class="player_info">
      <h2>FB/AG +{{ctrl.game.players[2].endpower()}}</h2>
      <h4>In play +{{ctrl.game.players[2].inplay.influencePotential()}}i</h4>
      <ul>
        <li ng-repeat="line in ctrl.inplay3">{{line.name}}
          <ul>
            <li ng-repeat="line2 in line.cardsOnCard">{{line2.name}}</li>
          </ul>
        </li>
      </ul>
      <p></p>
      <h4>Hand</h4>
      <ul>
        <li ng-repeat="card in ctrl.game.players[2].hand">{{card.name}}</li>       
      </ul>
      <h4>Discard</h4>
      <ul>
        <li ng-repeat="card in ctrl.game.players[2].discard">{{card.name}}</li>
      </ul>
      <h4>Deck</h4>
      <ul>
        <li ng-repeat="card in ctrl.game.players[2].deck">{{card.name}}</li>
      </ul>
    </div>
    
    

  </div>