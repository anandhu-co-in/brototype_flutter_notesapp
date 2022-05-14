import 'dart:async';

import 'package:brototype_notes_app/api/apicalls.dart';
import 'package:brototype_notes_app/note_model/note_model.dart';
import 'package:brototype_notes_app/screens/screen_add_edit_note.dart';
import 'package:flutter/material.dart';

class ScreenDashBoard extends StatelessWidget {
  ScreenDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await NotesDB.instance.getAllNotes();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: NotesDB.instance.noteListNotifier,
            builder:
                (BuildContext context, List<NoteModel> notemodels, Widget? _) {
              print("Called Value Listenable----------------- ");
              print(notemodels);

              List<Widget> notes = [AddNoteTile()];
              notes.addAll(notemodels.reversed.map((e) => NoteTile(note: e)).toList());

              return GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  padding: EdgeInsets.all(10),
                  children: notes);
            }),
      ),
    );
  }
}

class NoteTile extends StatelessWidget {
  final NoteModel note;

  const NoteTile({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> ScreenAddEditNote(type:ActionType.editNote,id: note.id,)));
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width: 1)),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      note.title!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        print("Clicked delete");
                        NotesDB().deleteNote(note.id!);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                ],
              ),
              Text(
                note.content!,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              )
            ],
          )),
    );
  }
}

class AddNoteTile extends StatelessWidget {
  const AddNoteTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ScreenAddEditNote.routeName);
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width: 1)),
          padding: const EdgeInsets.all(10),
          child: const Icon(
            Icons.add,
            size: 100,
            color: Colors.green,
          )),
    );
  }
}
