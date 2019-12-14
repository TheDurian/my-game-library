import 'package:flutter/material.dart';
import 'package:my_game_library/models/game.dart';


class GameCard extends StatelessWidget {
  final Game game;
  
  GameCard({this.game});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Card(
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(4)
            ),
            Expanded(
              child: Text(game.name),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(game.platform),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4),
            )
          ],
        ),
      )
    );
  }
}

class ExpandedGameCard extends StatelessWidget {
  final Game game;
  
  ExpandedGameCard({@required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(game.name),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(game.platform),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

