
class Message {
  final String? message;
  final String? id;
  // final String createdAt;

  Message(this.message, this.id);

  factory Message.fromjson(json) {
    return Message(json['message'], json['id']);
  }
}
