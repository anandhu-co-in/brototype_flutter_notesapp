import 'package:brototype_notes_app/api/apicalls.dart';
import 'package:brototype_notes_app/note_model/note_model.dart';
import 'package:flutter/material.dart';

enum ActionType { addNote, editNote }

class ScreenAddEditNote extends StatelessWidget {
  final ActionType type = ActionType.addNote;
  String? id;

  ScreenAddEditNote({Key? key}) : super(key: key);

  static const routeName = "add-transaction";

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type == ActionType.addNote ? 'Add Note' : 'Edit Note'),
        actions: [
          IconButton(
              onPressed: () async {
                switch (type) {
                  case ActionType.addNote:
                    final newNote = NoteModel.create(
                        id: DateTime.now().microsecondsSinceEpoch.toString(),
                        title: titleController.text,
                        content: contentController.text);
                    final result = await NotesDB().createNote(newNote);
                    if(result!=null){
                      print("Note Added");
                      Navigator.of(context).pop();
                    }else{
                      print("response null. Errordddddssss saving note");
                    }
                    break;
                  case ActionType.editNote:
                    print("Edit Note Clicked");
                    break;
                }
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Title'),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: contentController,
                maxLines: 4,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Content'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
