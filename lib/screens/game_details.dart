import 'package:flutter/material.dart';
import 'package:my_game_library/models/game.dart';

class GameDetailsScreen extends StatefulWidget {
  final Game game;

  GameDetailsScreen({this.game});


  @override
  State<StatefulWidget> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {

  int _topSectionFlex = 1;
  int _middleSectionFlex = 2;
  int _bottomSectionFlex = 1;
  bool _notesIsMinimized = true;
  bool _dataIsMinimized = false;
  Duration _duration = Duration(seconds: 10);

  @override
  Widget build(BuildContext context) => MediaQuery.of(context).orientation == Orientation.portrait ? portrait(context) : landscape(context);

  Widget portrait(BuildContext context) {
    var data = MediaQuery.of(context);
    double height = data.size.height - data.padding.top - kToolbarHeight - data.padding.bottom - 20;
    var topHeight = (_topSectionFlex * height) / (_topSectionFlex + _middleSectionFlex + _bottomSectionFlex);
    var middleHeight = (_middleSectionFlex * height) / (_topSectionFlex + _middleSectionFlex + _bottomSectionFlex);
    var bottomHeight = (_bottomSectionFlex * height) / (_topSectionFlex + _middleSectionFlex + _bottomSectionFlex);

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

    Widget middleSection = Container(
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      
    );

    Widget bottomSection = GestureDetector(
      onTap: () {
        setState(() {
          _middleSectionFlex = _middleSectionFlex == 1 ? 2 : 1;
          _bottomSectionFlex = _bottomSectionFlex == 1 ? 3 : 1;
          _notesIsMinimized = !_notesIsMinimized;
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 20),
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
              //fit: BoxFit.contain,
              child: Text(
                widget.game.notes==null ? "" : widget.game.notes,
                //softWrap: true,
                textAlign: TextAlign.start,
                overflow: _notesIsMinimized ? TextOverflow.fade : null,
                // maxLines: _notesIsMinimized ? 5 : null,
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
      ),
      
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 100),
              height: topHeight,
              child: titleSection,
              curve: Curves.easeInOut,
            ),
            AnimatedContainer(
              height: middleHeight,
              duration: Duration(milliseconds: 100),
              curve: Curves.easeInOut,
              child: middleSection
            ),
            AnimatedContainer(
              curve: Curves.easeInOut,
              height: bottomHeight,
              duration: Duration(milliseconds: 100),
              child: bottomSection, 
            )
          ],
        ),
      ),
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