import 'package:flutter/material.dart';
import 'package:my_game_library/database/database.dart';
import 'package:my_game_library/models/game.dart';
import 'package:my_game_library/components/game_card.dart';
import 'game_details.dart';
import 'edit_game.dart';

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
      // endDrawer: SizedBox(
      //   width: 200,
      //   child: Drawer(
      //     child: ListView(
      //       padding: EdgeInsets.zero,
      //       children: <Widget>[
      //       DrawerHeader(
      //         child: Container(
      //           alignment: Alignment.bottomCenter,
      //           child: Text(
      //             'Filter Menu',
      //             style: TextStyle(
      //               fontSize: 24,
      //               color: Colors.white
      //             ),
      //           ),
      //         ),
      //         decoration: BoxDecoration(
      //           color: Theme.of(context).primaryColor,
      //         ),
      //       ),
      //       ListTile(
      //         //leading: Text('Item 1'),
      //         title: TextFormField(
      //           decoration: InputDecoration(
      //             labelText: "label text" 
      //           ),
      //         ),
      //         onTap: () {
      //           // Update the state of the app
      //           // ...
      //           // Then close the drawer
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         title: Text('Item 2'),
      //         onTap: () {
      //           // Update the state of the app
      //           // ...
      //           // Then close the drawer
      //           Navigator.pop(context);
      //         },
      //       ),
      //     ],
      //     ),
      //     elevation: 6,
      //   ),
      // ),
      appBar: AppBar(
        title: Text("My Game List"),
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
          //print(result);
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
            onLongPress: () async {
              await db.removeGame(gameList[index].id);
              setupList();
              _showDialog(context, "${gameList[index].name} has been deleted");
            },
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GameDetailsScreen(game: gameList[index]))),
          ); 
        },
      ),
    );
  }

  onDelete(int id, String name) async {
    print("Removing $id : $name from database.");
    await db.removeGame(id);

    setupList();
    
  }

  void setupList() async {
    var _games = await db.fetchAll();
    setState(() {
      games = _games;
    });
  }

  _showDialog(BuildContext context, String message) => Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  

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