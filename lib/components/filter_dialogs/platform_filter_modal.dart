import 'package:flutter/material.dart';
import 'package:my_game_library/models/filter.dart';
import 'package:my_game_library/models/game.dart';

class PlatformFilterDialog extends StatefulWidget {
  final PlatformFilter filter;

  PlatformFilterDialog({this.filter});

  @override
  PlatformFilterDialogState createState() => PlatformFilterDialogState();
}

class PlatformFilterDialogState extends State<PlatformFilterDialog> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Platform Filter"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(5, 15, 20, 0),
              child: Text(
                "Include",
                style: TextStyle(
                  fontSize: 30
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Row(
            //   children: <Widget>[

            //   ],
            // ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    style: BorderStyle.solid
                  )
                ),
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: Game.platforms.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: CheckboxListTile(
                          onChanged: (bool value) {
                            if (value) setState(()=>widget.filter.selectedPlatforms.add(Game.platforms[index]));
                            else setState(()=>widget.filter.selectedPlatforms.remove(Game.platforms[index])); 
                          },
                          value: widget.filter.selectedPlatforms.contains(Game.platforms[index]),
                          title: Text(
                            Game.platforms[index]
                          ),
                          controlAffinity: ListTileControlAffinity.leading,                        
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: SizedBox(
                width: 200,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Text("Update Filter"), 
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    Navigator.of(context).pop(widget.filter);
                  },
                ),
              ),
            ),
            // ListView.builder(
            //   itemCount: Game.platforms.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     return Container(
            //       child: CheckboxListTile(
            //         onChanged: (bool value) {}, 
            //         //value: widget.filter.selectedPlatforms.contains(Game.platforms[index]),
            //         value: true,
            //         title: Text(
            //           Game.platforms[index]
            //         ),
            //         controlAffinity: ListTileControlAffinity.leading,              
            //       )
            //     );
            //   },
            // ),
          ],
        )
      ),
    );
  }
}