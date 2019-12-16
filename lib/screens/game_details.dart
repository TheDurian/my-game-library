import 'package:flutter/material.dart';
import 'package:my_game_library/models/game.dart';

class GameDetailsScreen extends StatefulWidget {
  final Game game;

  GameDetailsScreen({this.game});


  @override
  State<StatefulWidget> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.game.name),),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(widget.game.name != null ? widget.game.name : ''),
            Text(widget.game.platform != null ? widget.game.platform : ''),
            Text(widget.game.ownedStatus != null ? widget.game.ownedStatus : ''),
            Text(widget.game.dateOfLastCompletion?.toString() != null ? widget.game.dateOfLastCompletion.toString() : ''),
            Text(widget.game.edition != null ? widget.game.edition : ''),
            Text(widget.game.notes != null ? widget.game.notes : ''),
            Text(widget.game.price != null ? widget.game.price.toString() : '')
          ],
        ),
      ),
    );
  }
}