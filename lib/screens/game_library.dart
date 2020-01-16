import 'package:flutter/material.dart';
import 'package:my_game_library/components/animated_fab.dart';
import 'package:my_game_library/components/filter_dialogs/ownership_filter_modal.dart';
import 'package:my_game_library/database/database.dart';
import 'package:my_game_library/models/game.dart';
import 'package:my_game_library/components/game_card.dart';
import 'package:my_game_library/models/filter.dart';
import 'game_details.dart';
import 'edit_game.dart';
import 'package:my_game_library/components/filter_dialogs/text_filter_modal.dart';
import 'package:my_game_library/components/filter_dialogs/platform_filter_modal.dart';
import 'package:my_game_library/components/filter_dialogs/play_status_filter_modal.dart';


class GameLibrary extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GameLibraryState();
}

class GameLibraryState extends State<GameLibrary> {
  final db = GameDatabase();
  Filter _filter = Filter();

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
        actions: <Widget>[Container()], // Remove hamburger icon and drag option for endDrawer
      ),
      drawerEdgeDragWidth: 0,
      endDrawer: _buildDrawer(context),

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
            builder: (BuildContext context){
              return FloatingActionButton(
                onPressed: () async { //TODO: See if I can close the fab animation when this is pressed
                  Scaffold.of(context).openEndDrawer();
                },
                child: Icon(Icons.filter_list),
                heroTag: null,
                tooltip: "Filter",
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
            tooltip: "Add Game",
          ),
        ],
      ),
    );
  }

  Widget _buildGameList(List<Game> gameList) {
    return Expanded(
      child: Scrollbar(
        child: ListView.builder(
          padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 60),
          itemCount: gameList.length,
          itemBuilder: (BuildContext context, int index) {
            return _filter.filter(gameList[index])
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
  
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(10),
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Filter",
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
          ListTile(
            leading: Icon(Icons.search),
            title: Text(
              "Text Search",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            subtitle: !_filter.textFilter.hasFilter() 
              ? null 
              : Text(
                _filter.textFilter.text,
                style: TextStyle(
                  color: Colors.blue,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            trailing: !_filter.textFilter.hasFilter() 
              ? null 
              : FlatButton(
                child: Icon(Icons.close),
                onPressed: () => setState(() => _filter.textFilter.reset()),
              ),
            onTap: () async {
              Navigator.of(context).pop();
              TextFilter textFilter = await Navigator.of(context).push(MaterialPageRoute<TextFilter>(
                builder: (BuildContext context) {
                  return TextFilterDialog(filter: TextFilter.fromFilter(_filter.textFilter),);
                },
                fullscreenDialog: true
              ));
              if (textFilter != null) {
                _filter.textFilter = textFilter;
              }
            },
          ),
          Divider(
            thickness: 5,
          ),
          ListTile(
            title: Text(
              "Platform Search",
              style: TextStyle(
                fontSize: 18
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            subtitle: !_filter.platformFilter.hasFilter()
              ? null
              : Text(
                _filter.platformFilter.selectedPlatforms.toString(),
                style: TextStyle(
                  color: Colors.blue
                ),
                overflow: TextOverflow.ellipsis,
              ),
            trailing: !_filter.platformFilter.hasFilter()
              ? null
              : FlatButton(
                child: Icon(Icons.close),
                onPressed: () => setState(() => _filter.platformFilter.reset()),
              ),
            onTap: () async {
              Navigator.of(context).pop();
              PlatformFilter platformFilter = await Navigator.of(context).push(MaterialPageRoute<PlatformFilter>(
                builder: (BuildContext context) {
                  return PlatformFilterDialog(filter: PlatformFilter.fromFilter(_filter.platformFilter),);
                },
                fullscreenDialog: true
              ));
              if (platformFilter != null) {
                _filter.platformFilter = platformFilter;
              }
            },
          ),
          Divider(
            thickness: 5,
          ),
          ListTile(
            title: Text(
              "Ownership Search",
              style: TextStyle(
                fontSize: 18
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            subtitle: !_filter.ownershipFilter.hasFilter()
              ? null
              : Text(
                _filter.ownershipFilter.selectedStatuses.toString(),
                style: TextStyle(
                  color: Colors.blue
                ),
                overflow: TextOverflow.ellipsis,
              ),
            trailing: !_filter.ownershipFilter.hasFilter()
              ? null
              : FlatButton(
                child: Icon(Icons.close),
                onPressed: () => setState(() => _filter.ownershipFilter.reset()),
              ),
            onTap: () async {
              Navigator.of(context).pop();
              OwnershipFilter ownershipFilter = await Navigator.of(context).push(MaterialPageRoute<OwnershipFilter>(
                builder: (BuildContext context) {
                  return OwnershipFilterDialog(filter: OwnershipFilter.fromFilter(_filter.ownershipFilter),);
                },
                fullscreenDialog: true
              ));
              if (ownershipFilter != null) {
                _filter.ownershipFilter = ownershipFilter;
              }
            },
          ),
          Divider(
            thickness: 5,
          ),
          ListTile(
            title: Text(
              "Play Status Search",
              style: TextStyle(
                fontSize: 18
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            subtitle: !_filter.playStatusFilter.hasFilter()
              ? null
              : Text(
                _filter.playStatusFilter.selectedStatuses.toString(),
                style: TextStyle(
                  color: Colors.blue
                ),
                overflow: TextOverflow.ellipsis,
              ),
            trailing: !_filter.playStatusFilter.hasFilter()
              ? null
              : FlatButton(
                child: Icon(Icons.close),
                onPressed: () => setState(() => _filter.playStatusFilter.reset()),
              ),
            onTap: () async {
              Navigator.of(context).pop();
              PlayStatusFilter playStatusFilter = await Navigator.of(context).push(MaterialPageRoute<PlayStatusFilter>(
                builder: (BuildContext context) {
                  return PlayStatusFilterDialog(filter: PlayStatusFilter.fromFilter(_filter.playStatusFilter),);
                },
                fullscreenDialog: true
              ));
              if (playStatusFilter != null) {
                _filter.playStatusFilter = playStatusFilter;
              }
            },
          ),
          Divider(
            thickness: 5,
          )
        ],
      ),
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
