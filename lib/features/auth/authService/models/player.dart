// ignore_for_file: public_member_api_docs, sort_constructors_first

class Player {
  final String nickname;
  final String socketId;
  final String playertype;

  Player(this.nickname, this.socketId, this.playertype);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nickname': nickname,
      'socketId': socketId,
      'playertype': playertype,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      map['nickname'] as String,
      map['socketId'] as String,
      map['playertype'] as String,
    );
  }

  Player copyWith({
    String? nickname,
    String? socketId,
    String? playertype,
  }) {
    return Player(
      nickname ?? this.nickname,
      socketId ?? this.socketId,
      playertype ?? this.playertype,
    );
  }
}
