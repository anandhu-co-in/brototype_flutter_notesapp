import 'package:brototype_notes_app/api/apicalls.dart';
import 'package:brototype_notes_app/api/models/note_model.dart';
import 'package:brototype_notes_app/screens/screen_add_edit_note.dart';
import 'package:flutter/material.dart';

class ScreenDashBoard extends StatefulWidget {
  const ScreenDashBoard({Key? key}) : super(key: key);

  @override
  State<ScreenDashBoard> createState() => _ScreenDashBoardState();
}

class _ScreenDashBoardState extends State<ScreenDashBoard> {
  List<Widget> notes = [AddNoteTile()];

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      print("Called-------<>");
      final _noteList = await NotesDB().getAllNotes();
      print(_noteList);

      List<Widget> temp=[];
      temp.addAll([AddNoteTile()]);
      temp.addAll(List.generate(
          _noteList.length,
              (index) => NoteTile(
            note: _noteList[index],
          )));

      setState(() {
        notes=temp;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: SafeArea(
        child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: EdgeInsets.all(10),
            children: notes),
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
        print("Open Note");
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
