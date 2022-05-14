import 'package:brototype_notes_app/api/apicalls.dart';
import 'package:brototype_notes_app/note_model/note_model.dart';
import 'package:flutter/material.dart';

enum ActionType { addNote, editNote }

class ScreenAddEditNote extends StatelessWidget {
  ActionType type = ActionType.addNote;
  String? id;

  ScreenAddEditNote({Key? key,required this.type,this.id}) : super(key: key);

  static const routeName = "add-transaction";

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    if(type==ActionType.editNote){

      if(id==null){
        Navigator.of(context).pop();
      }
      else{
        final currentNote=NotesDB().getNoteByID(id!);
        if(currentNote==null){
          Navigator.of(context).pop();
        }
        else{
          titleController.text=currentNote.title??'No Title';  //IF title is null then no title, i think ?? doese that
          contentController.text=currentNote.content??'No Content';
        }
      }

    }

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

                    final newNote = NoteModel.create(
                        id: id,
                        title: titleController.text,
                        content: contentController.text);
                    final result = await NotesDB().updateNote(newNote);
                    if(result!=null){
                      print("Note Edited");
                      Navigator.of(context).pop();
                    }else{
                      print("Errow while editint Note");
                    }
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
