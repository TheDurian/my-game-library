import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:listr/database/database.dart';
import 'package:listr/models/game.dart';
import 'package:intl/intl.dart';


class EditGameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>  _EditGameScreenState();
}

class _EditGameScreenState extends State<EditGameScreen> {
  final _formKey = GlobalKey<FormState>();
  final _game = Game();
  final db = GameDatabase();

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

  

  Widget generateBasedOnOwnership() {
    if (_game.isOwned()) {
      return Column(
        children: <Widget>[
          DropdownButtonFormField(
            items: loadDropdownMenuItems(Game.playStatuses),
            value: _game.playStatus,
            onChanged: (value) => setState(() => _game.playStatus = value),
            decoration: InputDecoration(labelText: "Play Status", border: OutlineInputBorder()),
            validator: (value) {
              if (value == null || value.isEmpty) return "Please enter a play status";
            },
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
          ),
          TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [LengthLimitingTextInputFormatter(6),],
            decoration: InputDecoration(
              labelText: "Amount Payed", 
              border: OutlineInputBorder(), 
              prefixIcon: Icon(Icons.attach_money)
            ),
            onSaved: (val) => setState(() => _game.price = double.parse(val)),
            validator: (value) {
              if (double.tryParse(value)!=null && double.parse(value) < 0) return "Please enter a valid price";
            },
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
          ),
          DateTimePickerFormField(
            inputType: InputType.date,
            format: DateFormat('MMMM d, yyyy'),
            editable: false,
            decoration: InputDecoration(labelText: "Last Completion Date", border: OutlineInputBorder()),
            onSaved: (val) => _game.dateOfLastCompletion = val,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
          ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [LengthLimitingTextInputFormatter(6),],
            decoration: InputDecoration(
              labelText: "Lowest Price Seen",
              border: OutlineInputBorder(), 
              prefixIcon: Icon(Icons.attach_money)
            ),
            onSaved: (val) => setState(() => _game.price = double.parse(val)),
            validator: (value) {
              if (double.tryParse(value)!=null && double.parse(value) < 0) return "Please enter a valid price";
            },
          ),
        ],
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Game"),),
      resizeToAvoidBottomPadding: false,
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Builder(
            builder: (context) => Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: "Game Name", border: OutlineInputBorder()),
                    validator: (value) {
                      if (value.isEmpty) return "Please enter a game name";
                    },
                    onSaved: (val) => setState(() => _game.name = val),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonFormField(
                          items: loadDropdownMenuItems(Game.ownedStatuses),
                          value: _game.ownedStatus,
                          onChanged: (value) => setState(() => _game.modifyOwnershipFields(value)),
                          decoration: InputDecoration(labelText: "Owned Status", border: OutlineInputBorder()),
                          validator: (value) {
                            if (value == null || value.isEmpty) return "Please enter an ownership status";
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Expanded(
                        child: DropdownButtonFormField(
                          items: loadDropdownMenuItems(Game.platforms),
                          value: _game.platform,
                          onChanged: (value) => setState(() => _game.platform = value),
                          decoration: InputDecoration(labelText: "Platform", border: OutlineInputBorder()),
                          validator: (value) {
                            if (value == null || value.isEmpty) return "Please enter a platform";
                          },
                        ),
                      ),
                      
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  generateBasedOnOwnership(),
                  Padding(
                    padding: EdgeInsets.all(30),
                  ), 
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0
                    ),
                    child: RaisedButton(
                      child: Text("Submit new game."),
                      onPressed: () => _handleSubmissionOfGame(context),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  void _handleSubmissionOfGame(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(_game);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Processing Data")));
      
      var a = await db.addGame(_game);
      print(a);
      Navigator.pop(context, "This is a value");
    }
  }

}


// TextField(
//   onSubmitted: (String userInput) {
//     setState(() {
//       debugPrint("This is in setting state");
//       nameCity = userInput;
//     });
//   },
// ),
