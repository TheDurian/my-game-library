import 'package:flutter/material.dart';
import 'package:my_game_library/models/game.dart';
import 'package:intl/intl.dart';

class GameDetailsScreen extends StatefulWidget {
  final Game game;

  GameDetailsScreen({this.game});


  @override
  State<StatefulWidget> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {

  bool _notesIsMinimized = true;

  @override
  Widget build(BuildContext context) => MediaQuery.of(context).orientation == Orientation.portrait ? portrait(context) : landscape(context);

  Widget portrait(BuildContext context) {
    Widget titleSection = Container(
      child: Row(
        children: <Widget>[
          Placeholder(
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
                        //color: Colors.amberAccent
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
                        //color: Colors.blueAccent
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Platform",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              widget.game.platform,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        //color: Colors.greenAccent
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Status",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              widget.game.ownedStatus,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
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

  //These need to be added in the middle section
  // String edition;
  // double price; 
  // String playStatus;
  // DateTime dateOfLastCompletion;
  // int playtime;


    Widget middleSection = Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(width: 1))
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1))
                        ),
                        child: _createTableCell("Edition", widget.game.edition),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1))
                        ),
                        child: _createTableCell("Price",widget.game.price==null ? null : "\$${widget.game.price}"),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: _createTableCell("Status", widget.game.playStatus),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1))
                        ),
                        child: _createTableCell("Completed", widget.game.dateOfLastCompletion==null ? "N/A" : DateFormat("yyyy-MM-dd").format(widget.game.dateOfLastCompletion)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1))
                        ),
                        child: _createTableCell("Playtime", widget.game.playtime),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      
    );

    Widget bottomSection = Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: Center(
              child: Text(
                "Notes",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
            ),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1))
            ),
          ),
          Flexible(
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.game.notes==null ? "" : widget.game.notes,
                textAlign: TextAlign.start,
                overflow: _notesIsMinimized ? TextOverflow.fade : null,
              ),
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
              flex: 1,
            ),
            Expanded(
              child: middleSection, 
              flex: 1,
            ),
            Expanded(
              child: bottomSection, 
              flex: 2,
            ), 
          ],
        ),
      ),
    );
  }

  Widget _createTableCell(String label, dynamic value) {
    if (value == null) value = "N/A";
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 3),
          child: Text(
            "$label",
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(right: 3),
            child: Text(
              "$value",
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }

  Widget landscape(BuildContext context) {
    return Container(child: Text("I dont have a landscape view yet"),);
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