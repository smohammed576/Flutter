class Task{
  String id;
  String text;
  bool checked;

  Task({required this.id, required this.text, required this.checked});

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'checked': checked
  };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'],
    text: json['text'],
    checked: json['checked']
  );
}