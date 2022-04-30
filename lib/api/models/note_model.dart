class NoteModel {
  String? Id;
  String? title;
  String? content;

  NoteModel({this.Id, this.title, this.content});

  NoteModel.create({required this.Id, required this.title, required this.content});

  NoteModel.fromJson(Map<String, dynamic> json) {
    Id = json['_id'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.Id;
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}

class NotesResponse {
  List<NoteModel>? data;

  NotesResponse({this.data = const []});

  NotesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NoteModel>[];
      json['data'].forEach((v) {
        data!.add(new NoteModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
