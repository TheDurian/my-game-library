import 'package:flutter/material.dart';
import 'package:my_game_library/models/filter.dart';
import 'package:my_game_library/models/game.dart';

class OwnershipFilterDialog extends StatefulWidget {
  final OwnershipFilter filter;

  OwnershipFilterDialog({this.filter});

  @override
  OwnershipFilterDialogState createState() => OwnershipFilterDialogState();
}

class OwnershipFilterDialogState extends State<OwnershipFilterDialog> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ownership Filter"),
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
                    itemCount: Game.ownedStatuses.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: CheckboxListTile(
                          onChanged: (bool value) {
                            if (value) setState(()=>widget.filter.selectedStatuses.add(Game.ownedStatuses[index]));
                            else setState(()=>widget.filter.selectedStatuses.remove(Game.ownedStatuses[index]));
                          },
                          value: widget.filter.selectedStatuses.contains(Game.ownedStatuses[index]),
                          title: Text(
                            Game.ownedStatuses[index]
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
            )
          ],
        ),
      ),
    );
  }
}