// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_notes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllNotesModel _$AllNotesModelFromJson(Map<String, dynamic> json) =>
    AllNotesModel(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => NoteModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AllNotesModelToJson(AllNotesModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
