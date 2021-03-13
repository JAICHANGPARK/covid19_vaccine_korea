class Note {
  int? id;
  String? title;
  String? description;
  String? symptom;
  String? datetime;

  Note(
      {required this.id,
      required this.title,
      required this.description,
      required this.symptom,
      required this.datetime});

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    symptom = json['symptom'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['symptom'] = this.symptom;
    data['datetime'] = this.datetime;
    return data;
  }
}
