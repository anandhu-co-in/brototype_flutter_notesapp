import 'package:brototype_notes_app/note_model/note_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_notes_model.g.dart';

@JsonSerializable()
class AllNotesModel {
  @JsonKey(name: 'data')
  List<NoteModel> data;

  AllNotesModel({this.data = const []});

  factory AllNotesModel.fromJson(Map<String, dynamic> json) {
    return _$AllNotesModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AllNotesModelToJson(this);
}



//We have created above model for the response in below format :
// {
//  "data": [
//     {
//     "_id": "1652520359683911",
//     "title": "fdas",
//     "content": "fds"
//     },
//     {
//     "_id": "12345",
//     "title": "Note2",
//     "content": "This is an amazing note2 fasdfdas fsdaf adsf  fdsa f af sdfa dfm,af ndskfadksfkadsnbfkdsf fds This is an amazing note2 fasdfdas fsdaf adsf  fdsa f af sdfa dfm,af ndskfadksfkadsnbfkdsf fds This is an amazing note2 fasdfdas fsdaf adsf  fdsa f af sdfa dfm,af ndskfadksfkadsnbfkdsf fds"
//     }
//  ]
// }

//Since we have crated already model for Note, after generating this file we replace the auto generated one with that model

// watch from 27:19 of https://youtu.be/-rPVQ5XVBPk , if you have confusion in creating this all notes model
