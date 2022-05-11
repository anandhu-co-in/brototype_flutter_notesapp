import 'dart:convert';
import 'package:brototype_notes_app/all_notes_model/all_notes_model.dart';
import 'package:brototype_notes_app/api/url.dart';
import 'package:brototype_notes_app/note_model/note_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

abstract class ApiCalls{
  Future<NoteModel?> createNote(NoteModel value);
  Future<List<NoteModel>?> getAllNotes();
  Future<NoteModel?> updateNote(NoteModel value);
  Future deleteNote(String id);
}




class NotesDB extends ApiCalls{

  ValueNotifier<List<NoteModel>> noteListNotifier = ValueNotifier([]);

  //Single Ton
  NotesDB._internal(){
    this.dio.options=BaseOptions(
        responseType: ResponseType.plain,
        baseUrl: url.baseUrl
    );
  }

  static NotesDB instance = NotesDB._internal();
  factory NotesDB(){
    return instance;
  }
  //End Singleton


  final dio=Dio();
  final url=Url();


  @override
  Future<NoteModel?> createNote(NoteModel value) async{

    try{
      final result = await dio.post(url.createNote,data: value.toJson());
      final resultAsJson=jsonDecode(result.data);
      getAllNotes();
      return NoteModel.fromJson(resultAsJson as Map<String,dynamic>);
    }on DioError catch(e){
      print(e.response?.data);
      return null;
    }
  }

  @override
  Future<List<NoteModel>> getAllNotes() async{

    // print("Calling api------------");
    final result = await dio.get(url.getAllNotes);
    // print("Called api------------");
    print(result);
    print(dio.toString());
    if (result.data!=null){
      final notesResponse=AllNotesModel.fromJson(jsonDecode(result.data) as Map<String,dynamic>);
      noteListNotifier.value.clear();
      print("Note  response data");
      print(notesResponse.data);
      noteListNotifier.value.addAll(notesResponse.data);
      print("Notes listener values-------");
      print(noteListNotifier.value);
      noteListNotifier.notifyListeners();
      return notesResponse.data;
    }
    else{
      noteListNotifier.value.clear();
      noteListNotifier.notifyListeners;
      return [];
    }
  }





  @override
  Future<NoteModel?> updateNote(NoteModel value) async{
    final result = await dio.put<NoteModel>(url.updateNote);
    return NoteModel.fromJson(result.data as Map<String,dynamic>);
  }

  @override
  Future deleteNote(String id) async{

  }




}