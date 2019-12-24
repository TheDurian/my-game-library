import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_game_library/database/database.dart';
import 'package:my_game_library/models/game.dart';
import 'package:intl/intl.dart';


class EditGameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>  _EditGameScreenState();
}

class _EditGameScreenState extends State<EditGameScreen> {
  final _formKey = GlobalKey<FormState>();
  final _game = Game();
  final db = GameDatabase();
  final _controller = TextEditingController();

  List<DropdownMenuItem> loadDropdownMenuItems(List itemList) {
    List<DropdownMenuItem> statusList = [];
    itemList.forEach((status) {
      statusList.add(
        DropdownMenuItem(
          child: Text(status),
          value: status,
        )
      );
    });
    return statusList;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Game"),),
      resizeToAvoidBottomPadding: true,
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Game Name", border: OutlineInputBorder()),
                      validator: (value) => (value.isEmpty) ? "Please enter a game name" : null,
                      onSaved: (val) => setState(() => _game.name = val),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: DropdownButtonFormField(
                            items: loadDropdownMenuItems(Game.ownedStatuses),
                            value: _game.ownedStatus,
                            onChanged: (value) => setState(() => _game.modifyOwnershipFields(value)),
                            decoration: InputDecoration(labelText: "Owned Status", border: OutlineInputBorder()),
                            validator: (value) => (value == null || value.isEmpty) ? "Please enter status" : null,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        ),
                        Expanded(
                          child: DropdownButtonFormField(
                            items: loadDropdownMenuItems(Game.platforms),
                            value: _game.platform,
                            onChanged: (value) => setState(() => _game.platform = value),
                            decoration: InputDecoration(labelText: "Platform", border: OutlineInputBorder()),
                            validator: (value) => (value == null || value.isEmpty) ? "Please enter platform" : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _game.isOwned() ? 
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5 ),
                      child: DropdownButtonFormField(
                        items: loadDropdownMenuItems(Game.playStatuses),
                        value: _game.playStatus,
                        onChanged: (value) => setState(() => _game.playStatus = value),
                        decoration: InputDecoration(labelText: "Play Status", border: OutlineInputBorder()),
                        validator: (value) => (value == null || value.isEmpty) ? "Please enter a play status" : null,
                      ),
                    ) : null,
                  _game.isOwned() ? 
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: TextFormField(
                        key: ValueKey("price-key"),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [LengthLimitingTextInputFormatter(6),],
                        decoration: InputDecoration(
                          labelText: "Amount Payed", 
                          border: OutlineInputBorder(), 
                          prefixIcon: Icon(Icons.attach_money)
                        ),
                        onSaved: (val) => setState(() => _game.price = double.parse(val)),
                        validator: (value) => (value != null && double.tryParse(value)!=null && double.parse(value) < 0) ?  "Please enter price" : null,
                      ),
                    ) : null,
                  _game.hasBeaten() ? 
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: TextFormField(

                        enableInteractiveSelection: false,
                        controller: _controller,
                        onTap: () { 
                          FocusScope.of(context).requestFocus(new FocusNode()); 
                          showDatePicker(
                            context: context,
                            firstDate: new DateTime(1980),
                            initialDate: DateTime.now(),
                            lastDate: DateTime.now()).then((DateTime dt) {
                              _game.dateOfLastCompletion = dt;
                              if (dt==null) {
                                _controller.clear();
                              } else {
                                _controller.text = "${DateFormat('yyyy-MM-dd').format(dt)}";
                              }
                              print(_controller.text);
                            },
                          );
                        },
                        decoration: InputDecoration(labelText: "Last Completion Date", border: OutlineInputBorder()),
                      ),
                    ) : null,
                  _game.ownedStatus != null && !_game.isOwned() ? 
                    Container(
                      key: ValueKey("price-key"),
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: TextFormField(
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [LengthLimitingTextInputFormatter(6),],
                        decoration: InputDecoration(
                          labelText: "Lowest Price Seen",
                          border: OutlineInputBorder(), 
                          prefixIcon: Icon(Icons.attach_money)
                        ),
                        onSaved: (val) => setState(() => _game.price = double.parse(val)),
                        validator: (value) => (value != null && double.tryParse(value)!=null && double.parse(value) < 0) ? "Please enter price" : null,
                      ),
                    ) : null,
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: TextFormField(
                      initialValue: _game.notes,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      //textInputAction: TextInputAction.,
                      decoration: InputDecoration(labelText: "Notes", border: OutlineInputBorder()),
                      //onSaved: (val) => setState(() => _game.notes = val),
                      onSaved: (val) => setState(() {
                        print(val);
                        _game.notes = val;
                      }),
                    ),
                  ),
                  
                ].where((item) => item != null).toList(),
              ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: RaisedButton(
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              print(_game);
              //Scaffold.of(context).showSnackBar(SnackBar(content: Text("Processing Data")));
              await db.addGame(_game);
              Navigator.pop(context);
            }
          },
          color: Theme.of(context).accentColor,
          child: Text('Add Game'),
        ),
      ),
    );
  }
}