
# My Game Library

An App to keep track of your games and which to buy.

## Bugs
 * Price Number format-er needs work
	 * Number can have multiple periods
	 * Number can be in the thousands
	 * The number can have 3+ decimal values
	 * Price does not need to be provided, and will error if left blank
 * 
## Ideas I want to implement
 * Playtime
 * Notes (some general stuff)
 * Filtering on your game list
	 * start typing and it will only list the ones you have in the filter
	 * have some default filters that you can click 
 * Icons for games (box art?)
 * AppBar
	 * Left side is a hamburger menu
		 * Filters - These pull out a menu from the side that let you click in the drop downs
		 * Other garbage like settings
 * Do something cool with the floating action button
 * Have different views for the cards. Small/Big
## Links and Resources

Here are the associated links for ideas I want to add.

### SQLite and Databases:

 * https://github.com/PharosProduction/tutorial-flutter-sqflite/blob/master/lib/src/screens/main_page.dart
 * https://flutter.dev/docs/cookbook/persistence/sqlite

### Forms

  * https://flutter.dev/docs/cookbook/forms/validation
 * https://medium.com/flutter-community/realistic-forms-in-flutter-part-1-327929dfd6fd

### Layouts
 * https://medium.com/flutter-community/flutter-layout-cheat-sheet-5363348d037e
 * https://medium.com/flutter-community/a-deep-dive-into-flutter-textfields-f0e676aaab7a

### Cards
 * https://sergiandreplace.com/planets-flutter-from-design-to-app/
 * https://sergiandreplace.com/planets-flutter-creating-a-planet-card/

### Floating Action Buttons
 * https://medium.com/@agungsurya/create-a-simple-animated-floatingactionbutton-in-flutter-2d24f37cfbcc
 * https://pub.dev/packages/animated_floatactionbuttons

### Themes
 * https://flutter.dev/docs/cookbook/design/themes

### State
 * https://flutter.dev/docs/development/ui/interactive#stateful-and-stateless-widgets

### Filtering a list
 * https://medium.com/@thedome6/how-to-create-a-searchable-filterable-listview-in-flutter-4faf3e300477

### Appbar Settings
 * https://github.com/RobertBrunhage/Youtube-Tutorials/blob/master/settings_button/lib/main.dart

## Widgets that seem cool and i want to try and use
 * Dismissible
	* https://www.youtube.com/watch?v=iEMgjrfuc58&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG&index=29

## Code segments i may be interested in

~~~
 showDialog(
	context: context,
	child: new AlertDialog(
		title: new Text("Details"),
		//content: new Text("Hello World"),
		content: new SingleChildScrollView(
			child: new ListBody(
				children: <Widget>[
					new Text("Name : " + data.name),
					new Text("Phone : " + data.phone),
					new Text("Email : " + data.email),
					new Text("Age : " + data.age),
				],
			),
		),
		actions: <Widget>[
			new FlatButton(
				child: new Text('OK'),
				onPressed: () {
					Navigator.of(context).pop();
				},
			),
		],
	)
);
~~~