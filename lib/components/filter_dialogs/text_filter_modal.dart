import 'package:flutter/material.dart';
import 'package:my_game_library/models/filter.dart';

class TextFilterDialog extends StatefulWidget {

  final TextFilter filter;
  

  TextFilterDialog({this.filter});

  @override
  TextFilterDialogState createState() => TextFilterDialogState();
}

class TextFilterDialogState extends State<TextFilterDialog> {
  
  final _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.filter.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                onChanged: (bool value) => setState(()=>widget.filter.includeName=value), 
                value: widget.filter.includeName,
              ),
            ),
            Container(
              child: CheckboxListTile(
                title: Text("Search Notes"),
                onChanged: (bool value) => setState(()=>widget.filter.includeNotes=value), 
                value: widget.filter.includeNotes,
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
                    setState(() => widget.filter.text = _controller.text);
                    Navigator.of(context).pop(widget.filter);
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