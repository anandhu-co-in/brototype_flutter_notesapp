import 'dart:convert';

import 'package:brototype_notes_app/api/models/note_model.dart';
import 'package:brototype_notes_app/api/url.dart';
import 'package:dio/dio.dart';

abstract class ApiCalls{
  Future<NoteModel?> createNote(NoteModel value);
  Future<List<NoteModel>?> getAllNotes();
  Future<NoteModel?> updateNote(NoteModel value);
  Future deleteNote(String id);
}


class NotesDB extends ApiCalls{

  final dio=Dio();
  final url=Url();

  NotesDB(){
    dio.options=BaseOptions(
      responseType: ResponseType.plain
    );
  }

  @override
  Future<NoteModel?> createNote(NoteModel value) async{
    final result = await dio.post(url.baseUrl+url.createNote,data: value.toJson());
    final resultAsJson=jsonDecode(result.data) as Map<String,dynamic>;
    return NoteModel.fromJson(resultAsJson);
  }

  @override
  Future<List<NoteModel>> getAllNotes() async{
    print("---------");
    final result = await dio.get(url.baseUrl+url.getAllNotes);
    print("---------x");
    if (result.data!=null){
      final resultAsJson=jsonDecode(result.data) as Map<String,dynamic>;
      final notesResponse=NotesResponse.fromJson(resultAsJson);
      return notesResponse.data!;
    }
    else{
      return [];
    }
  }



  @override
  Future<NoteModel?> updateNote(NoteModel value) async{
    final result = await dio.put<NoteModel>(url.baseUrl+url.updateNote);
    return NoteModel.fromJson(result.data as Map<String,dynamic>);
  }

  @override
  Future deleteNote(String id) async{

  }




}