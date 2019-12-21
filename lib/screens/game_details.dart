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
  Widget build(BuildContext context) => MediaQuery.of(context).orientation == Orientation.portrait ? portrait(context) : landscape(context);

  Widget portrait(BuildContext context) {
    Widget titleSection = Container(
      child: Row(
        children: <Widget>[
          Placeholder(// Picture on left
            fallbackWidth: 125,
          ), 
          Padding(
            padding: EdgeInsets.only(left: 10),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all()
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.amberAccent
                      ),
                      child: Center(
                        child: Text(
                          widget.game.name, 
                          textAlign: TextAlign.center,  
                        ),
                      ),
                    )
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.blueAccent
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text("aaa"),
                          ),
                          Expanded(
                            flex: 2,
                            child: Placeholder(),
                          )
                        ],
                      ),
                    )
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.greenAccent
                      ),
                    )
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );

    Widget middleSection = Container(
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      //child: ,
    );

    Widget bottomSection = Container(
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          border: Border.all()
      ),
      child: ListView(
        children: <Widget>[
          Center(
            child: Text(
              "Notes",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(4),
            child: Text(
              widget.game.notes==null ? '' : widget.game.notes
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: titleSection,
            ),
            Expanded(
              child:middleSection,
            ),
            Expanded(
              child:bottomSection,
            )
          ],
        ),
      ),
    );
  }

  Widget landscape(BuildContext context) {
    return Container(child: Text("I dont have a landscape view yet"),);
  }


  Widget _buildTitleRow(String label, dynamic value) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15
              ),
            ),
          ),
          Container(
            child: Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 15
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


}





          // Text(
          //   widget.game.name != null ? widget.game.name : '',
          //   style: TextStyle(
          //     fontSize: 30
          //   ),
          // ),
          // Text(widget.game.platform != null ? widget.game.platform : ''),
          // Text(widget.game.ownedStatus != null ? widget.game.ownedStatus : ''),
          // Text(widget.game.dateOfLastCompletion?.toString() != null ? widget.game.dateOfLastCompletion.toString() : ''),
          // Text(widget.game.edition != null ? widget.game.edition : ''),
          // Text(widget.game.notes != null ? widget.game.notes : ''),
          // Text(widget.game.price != null ? widget.game.price.toString() : '')