import 'package:flutter/material.dart';
import 'package:my_game_library/models/text_filter.dart';

class TextFilterDialog extends StatefulWidget {

  final TextFilter textFilter;

  TextFilterDialog({this.textFilter});

  @override
  TextFilterDialogState createState() => TextFilterDialogState();
}

class TextFilterDialogState extends State<TextFilterDialog> {
  
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.textFilter.text;
    return Scaffold(
      appBar: AppBar(
        title: Text("Text Filter"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  border: OutlineInputBorder(),
                  hintText: "Text to look for..."
                ),
                controller: _controller,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5, 15, 20, 0),
              child: Text(
                "Include",
                style: TextStyle(
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              child: CheckboxListTile(
                title: Text("Search Names"),
                onChanged: (bool value) => setState(()=>widget.textFilter.includeName=value), 
                value: widget.textFilter.includeName,
              ),
            ),
            Container(
              child: CheckboxListTile(
                title: Text("Search Notes"),
                onChanged: (bool value) => setState(()=>widget.textFilter.includeNotes=value), 
                value: widget.textFilter.includeNotes,
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
                  child: Text("Update Filter"), 
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    setState(() => widget.textFilter.text = _controller.text);
                    Navigator.of(context).pop(widget.textFilter);
                  },
                ),
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
  
}