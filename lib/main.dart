import 'package:flutter/material.dart';
import 'package:listr/app_screens/edit_game_screen.dart';
import 'package:listr/app_screens/game_library.dart';

/*
First Screen
----------
Pick One of the Big Categories
Ex:
  * Television
  * Games
  * Movies
Label for category:
  Name | Icon?

Have a (+) button that we can make a new category
 */

/*
Click to create a new category
- Opens new window 
 - This window itself has plus sign, which gives options like
   - New label?
   - New checkbox
*/


/*
Bug List:
  Price number formatter needs work.
    * the number can have multiple periods
    * the number can be in the thouasands
    * the number can have 3+ decimal values
  Price does not need to be provided, and will error if left blank since cant parse null to double

*/
//SQLite
//https://github.com/PharosProduction/tutorial-flutter-sqflite/blob/master/lib/src/screens/main_page.dart
//https://flutter.dev/docs/cookbook/persistence/sqlite

//Forms
//https://flutter.dev/docs/cookbook/forms/validation
//https://medium.com/flutter-community/realistic-forms-in-flutter-part-1-327929dfd6fd

//Layout
//https://medium.com/flutter-community/flutter-layout-cheat-sheet-5363348d037e
//https://medium.com/flutter-community/a-deep-dive-into-flutter-textfields-f0e676aaab7a

//Cards
//https://sergiandreplace.com/planets-flutter-from-design-to-app/
//https://sergiandreplace.com/planets-flutter-creating-a-planet-card/

//Floating Action Buttons
//https://pub.dev/packages/animated_floatactionbuttons
//https://medium.com/@agungsurya/create-a-simple-animated-floatingactionbutton-in-flutter-2d24f37cfbcc

//Themes
//https://flutter.dev/docs/cookbook/design/themes

//State
//https://flutter.dev/docs/development/ui/interactive#stateful-and-stateless-widgets

//Filter the list
//https://medium.com/@thedome6/how-to-create-a-searchable-filterable-listview-in-flutter-4faf3e300477

//Appbar Settings
//https://github.com/RobertBrunhage/Youtube-Tutorials/blob/master/settings_button/lib/main.dart


/*
ICON | Name
Owned Status (dropdown)
  * Physical
  * Digital
  * Wishlist
Edition
  * Physical
  * Digital
  * Steelbook
  * Metalcase/other
Price (dollar input)
Platform (dropdown)
  * PSX
  * PS2
  * PS3
  * PS4
  * NES
  * SNES
  * N64
  * Gamecube
  * Wii
  * Wii U
  * Switch
  * Xbox
  * Xbox 360
  * Xbox One
  * GBC
  * GBA
  * DS
  * 3DS
  * PSP
  * Vita
Game Status
  * Backlog
  * On Hold
  * Playing
  * Beaten
  * Polishing
  * Platinum/All Achievements
  * 100% 
Date of Last Completion (date)
Playtime (days, hours, minutes, seconds, ms)
Notes (textfield)
*/




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Flutter App",
      home: GameLibrary(),
      theme: ThemeData(
        accentColor: Color(0xFF62B6CB),
        primaryColor: Color(0xFF16425B),
        backgroundColor: Color(0x9FABB5B4), //0x9FABB5B4
        cardColor: Color(0xFFABB5B4) // 0xFFABB5B4
      ),
    );
  } 
}

