import 'package:flutter/material.dart';
import 'package:my_game_library/database/database.dart';
import 'package:my_game_library/models/game.dart';
import 'package:my_game_library/components/game_card.dart';

import 'edit_game_screen.dart';

class GameLibrary extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GameLibraryState();
}

class GameLibraryState extends State<GameLibrary> {
  final db = GameDatabase();
  
  List<Game> games = [];

  @override
  void initState() {
    super.initState();
    setupList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Game List"),
        actions: <Widget>[
          Icon(Icons.filter_list)
        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            _buildAddButton(),
            _buildGameList(games)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context, MaterialPageRoute(builder: (context) => EditGameScreen())
          );
          print(result);
          setupList();
        }
      ),
    );
  }

  Widget _buildGameList(List<Game> gameList) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(5.0),
        itemCount: gameList.length,
        
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: GameCard(
              game: gameList[index],
            ),
            onLongPress: () => onDelete(gameList[index].id, gameList[index].name),
          ); 
        },
      ),
    );
  }

  onDelete(int id, String name) async {
    print("Removing $id : $name from database.");
    await db.removeGame(id);

    setupList();
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Deleted game $name")));
  }

  void setupList() async {
    var _games = await db.fetchAll();
    setState(() {
      games = _games;
    });
  }

  Widget _buildAddButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            child: Text('Debug Print All'),
            onPressed: () {
              print(games);
            },
          )
        ),
        Expanded(
          child:  RaisedButton(
            child: Text("Generate Samples"),
            onPressed: () async {
              var game1 = Game(name: "Dark Souls 1", platform: "PS4", ownedStatus: "Wishlist");
              var game2 = Game(name: "Legend of Zelda: Breath of the Wild", platform: "Switch", ownedStatus: "Wishlist");
              var game3 = Game(name: "Nier Automata", platform: "PS4", ownedStatus: "Wishlist");
              var game4 = Game(name: "Legend of Zelda: Link's Awakening", platform: "Switch", ownedStatus: "Wishlist");
              var game5 = Game(name: "Luigis Mansion 3", platform: "Switch", ownedStatus: "Wishlist");
              await db.addGame(game1);
              await db.addGame(game2);
              await db.addGame(game3);
              await db.addGame(game4);
              await db.addGame(game5);
              var _games = await db.fetchAll();
              setState(() {
                games = _games;
              });
            },
          ),
        )
        
      ],
    );
  }
  
  
}