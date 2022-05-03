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
