final String tableNotes = 'notes';
class Note {
  int? id;
  String? title;
  String? content;
  String? dateTimeEdited;
  DateTime? dateTimeCreated;

  Note({ this.id,
       this.title,   this.content,   this.dateTimeEdited,
      this.dateTimeCreated, }
);

  Map<String, dynamic> toMap() {
    return {
      "id":  this.id,
      "title": this.title,
      "content": this.content,
      "dateTimeEdited": this.dateTimeEdited,
      "dateTimeCreated": this.dateTimeCreated,
    };
  }
}


// class NoteFields {
//   static final List<String> values = [
//     /// Add all fields
//     id, isImportant, number, title, description, time
//   ];

//   static final String id = '_id';
//   static final String isImportant = 'isImportant';
//   static final String number = 'number';
//   static final String title = 'title';
//   static final String description = 'description';
//   static final String time = 'time';
// }

// class Note {
//   final int? id;
//   final bool isImportant;
//   final int number;
//   final String title;
//   final String description;
//   final String createdTime;

//   const Note({
//     this.id,
//     required this.isImportant,
//     required this.number,
//     required this.title,
//     required this.description,
//     required this.createdTime,
//   });

//   Note copy({
//     int? id,
//     bool? isImportant,
//     int? number,
//     String? title,
//     String? description,
//     String? createdTime,
//   }) =>
//       Note(
//         id: id ?? this.id,
//         isImportant: isImportant ?? this.isImportant,
//         number: number ?? this.number,
//         title: title ?? this.title,
//         description: description ?? this.description,
//         createdTime: createdTime ?? this.createdTime,
//       );

//   static Note fromJson(Map<String, Object?> json) => Note(
//         id: json[NoteFields.id] as int?,
//         isImportant: json[NoteFields.isImportant] == 1,
//         number: json[NoteFields.number] as int,
//         title: json[NoteFields.title] as String,
//         description: json[NoteFields.description] as String,
//         createdTime: DateTime.parse(json[NoteFields.time] as String).toString(),
//       );

//   Map<String, Object?> toJson() => {
//         NoteFields.id: id,
//         NoteFields.title: title,
//         NoteFields.isImportant: isImportant ? 1 : 0,
//         NoteFields.number: number,
//         NoteFields.description: description,
//         NoteFields.time: createdTime.toIso8601String().toString(),
//       };
// }
