import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Player {
  final String name;
  final String id;

  Player({
    required this.name,
    required this.id,
  });

  Player copyWith({
    String? name,
    String? id,
  }) {
    return Player(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      name: map['name'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Player.fromJson(String source) =>
      Player.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Player(name: $name, id: $id)';

  @override
  bool operator ==(covariant Player other) {
    if (identical(this, other)) return true;

    return other.name == name && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
