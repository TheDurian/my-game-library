import 'package:flutter/material.dart';
import 'package:my_game_library/components/animated_fab.dart';
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
  bool _textFilterIncludeNames = true;
  bool _textFilterIncludeNotes = false;
  final _textFilterController = TextEditingController();
  String _textFilter = "";
  
  List<Game> games = [];
  bool _displayTextSearchDrawer = false;

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
        actions: <Widget>[Container()], // Remove hamburger icon and drag option for endDrawer
      ),
      drawerEdgeDragWidth: 0,
      endDrawer: _displayTextSearchDrawer ? _buildTextSearchDrawer(context) : _buildFilterDrawer(),

      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            _buildAddButton(),
            _buildGameList(games),
            
          ],
        ),
      ),
      floatingActionButton: AnimatedFloatingActionButton(
        startingAnimationColor: Theme.of(context).accentColor,
        endingAnimationColor: Colors.red,
        fabButtons: <Widget>[
          Builder(
            builder: (BuildContext context) {
              return FloatingActionButton(
                onPressed: () async { //TODO: See if I can close the fab animation when this is pressed
                  setState(() {
                    _displayTextSearchDrawer = true;
                  });
                  Scaffold.of(context).openEndDrawer();
                },
                child: Icon(Icons.search),
                heroTag: null,
              );
            }
          ),
          Builder(
            builder: (BuildContext context){
              return FloatingActionButton(
                onPressed: () async { //TODO: See if I can close the fab animation when this is pressed
                  setState(() {
                    _displayTextSearchDrawer = false;
                  });
                  // Scaffold.of(context).openEndDrawer();
                  _showDialog(context, "Notice", "Filter drawer has not yet been added.");
                },
                child: Icon(Icons.filter_list),
                heroTag: null,
              );
            }
          ),
          FloatingActionButton(
            onPressed: () async { //TODO: See if I can close the fab animation when this is pressed
              await Navigator.push(context, MaterialPageRoute(builder: (context) => EditGameScreen()));
              setupList();
            },
            heroTag: null,
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _buildGameList(List<Game> gameList) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 60),
        itemCount: gameList.length,
        itemBuilder: (BuildContext context, int index) {
          return _textFilterController == null || _textFilter=="" 
            ? GestureDetector(
              child: GameCard(
                game: gameList[index],
              ),
              onLongPress: () async {
                await db.removeGame(gameList[index].id);
                setupList();
                _showSnackBar(context, "${gameList[index].name} has been deleted");
              },
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GameDetailsScreen(game: gameList[index]))),
            )
            :  _checkIfItemInFilter(gameList[index])
              ? GestureDetector(
                child: GameCard(
                  game: gameList[index],
                ),
                onLongPress: () async {
                  await db.removeGame(gameList[index].id);
                  setupList();
                  _showSnackBar(context, "${gameList[index].name} has been deleted");
                },
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GameDetailsScreen(game: gameList[index]))),
              )
              : Container();
        },
      ),
    );
  }

  Widget _buildAddButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            child: Text('Debug Print All'),
            onPressed: () {
              _showDialog(context, "Notice", "This button does not do anything, it is only there for testing.");
            },
          )
        ),
        Expanded(
          child:  RaisedButton(
            child: Text("Generate Samples"),
            onPressed: () async {
              var game1 = Game(
                name: "Dark Souls 1",
                platform: "PS4", 
                ownedStatus: "Wishlist",
                notes: "This will be a very long post This will be a very long post This will be a very long post"
                  "This will be a very long post This will be a very long post This will be a very long post This will "
                  "be a very long post This will be a very long post This will be a very long post This will be a very "
                   "long post This will be a very long post This will be a very long post This will be a very long post "
                    "This will be a very long post This will be a very long post This will be a very long post This will "
                    "be a very long post This will be a very long post This will be a very long post This will be a very "
                    "long post This will be a very long post",
                dateOfLastCompletion: DateTime.now(),
                edition: "Steelbook",
                playStatus: "Playing",
                price: 25.11
              );
              var game2 = Game(
                name: "Legend of Zelda: Breath of the Wild", 
                platform: "Switch", 
                ownedStatus: "Wishlist",
                dateOfLastCompletion: DateTime.now(),
                edition: "Standard",
                playStatus: "Backlog",
                price: 11.11
              );
              var game3 = Game(
                name: "Nier Automata", 
                platform: "PS4", 
                ownedStatus: "Wishlist"
              );
              var game4 = Game(
                name: "Legend of Zelda: Link's Awakening", 
                platform: "Switch", 
                ownedStatus: "Wishlist"
              );
              var game5 = Game(
                name: "Luigis Mansion 3", 
                platform: "Switch", 
                ownedStatus: "Wishlist"
              );
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
  
  Widget _buildTextSearchDrawer(BuildContext context) {
    return Drawer(
      key: ValueKey("TextSearch"),
      child: Column(
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(10),
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Text Filter",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor
            ),
          ),
          Container( //TODO: Add a [X] icon to the text field which can erase the contents. Use a stack to overlay
            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                border: OutlineInputBorder(),
                hintText: "Text to look for..."
              ),
              controller: _textFilterController,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(5, 15, 20, 0),
            child: Text(
              "Include:",
              style: TextStyle(
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            child: CheckboxListTile(
              title: Text("Search Names"),
              onChanged: (bool value) => setState(()=>_textFilterIncludeNames=value), 
              value: _textFilterIncludeNames,
            ),
          ),
          Container(
            child: CheckboxListTile(
              title: Text("Search Notes"),
              onChanged: (bool value) => setState(()=>_textFilterIncludeNotes=value), 
              value: _textFilterIncludeNotes,
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: SizedBox(
                width: 200,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Text("Update Search"), 
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    setState(() => _textFilter = _textFilterController.text);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFilterDrawer() {
    return Drawer(
      key: ValueKey("Filter"),
    );
  }

  onDelete(int id, String name) async {
    print("Removing $id : $name from database.");
    await db.removeGame(id);

    setupList();
    
  }

  setupList() async {
    var _games = await db.fetchAll();
    setState(() {
      games = _games;
    });
  }

  bool _checkIfItemInFilter(Game game) {    


    //TODO: When added, include other filter logic in this section
    if (_textFilterIncludeNames && game.name.toLowerCase().contains(_textFilter.toLowerCase())) return true;
    if (_textFilterIncludeNotes && game.notes != null && game.notes.toLowerCase().contains(_textFilter.toLowerCase())) return true;
    return false;
    
  }

  _showSnackBar(BuildContext context, String message) => Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  
  _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      } 
    );
  }
  
}


// new ListView.builder(
//   itemCount: items.length,
//   itemBuilder: (BuildContext context, int index) {
//   return filter == null || filter == "" 
//     ? new Card(
//       child: new Text(items[index])
//     ) 
//     : items[index].contains(filter) 
//       ? new Card(
//         child: new Text(items[index])
//       ) 
//       : new Container();
// },
// ),