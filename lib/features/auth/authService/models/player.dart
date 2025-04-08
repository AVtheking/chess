// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Player {
  final String id;
  final String name;

  Player(
    this.id,
    this.name,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      map['id'] as String,
      map['name'] as String,
    );
  }

  Player copyWith({
    String? id,
    String? name,
  }) {
    return Player(
      id ?? this.id,
      name ?? this.name,
    );
  }

  String toJson() => json.encode(toMap());

  factory Player.fromJson(String source) =>
      Player.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Player(id: $id, name: $name)';

  @override
  bool operator ==(covariant Player other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
