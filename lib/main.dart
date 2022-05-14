import 'package:brototype_notes_app/screens/screen_add_edit_note.dart';
import 'package:brototype_notes_app/screens/screen_dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ScreenDashBoard(),
        routes: {
          ScreenAddEditNote.routeName: (ctx) => ScreenAddEditNote(
                type: ActionType.addNote,
              )
        });
  }
}
