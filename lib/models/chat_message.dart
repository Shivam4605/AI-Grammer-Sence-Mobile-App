// class ChatMessage {
//   String message;
//   bool isUser;
//   bool isCorrectCheck;
//   bool isLoading;

//   ChatMessage({
//     required this.message,
//     required this.isUser,
//     required this.isCorrectCheck,
//     this.isLoading = false,
//   });
// }

class ChatMessage {
  int? id;
  String message;
  bool isUser;
  bool isCorrectCheck;
  bool isLoading;

  ChatMessage({
    this.id,
    required this.message,
    required this.isUser,
    required this.isCorrectCheck,
    this.isLoading = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'isUser': isUser ? 1 : 0,
      'isCorrectCheck': isCorrectCheck ? 1 : 0,
      'isLoading': isLoading ? 1 : 0,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'],
      message: map['message'],
      isUser: map['isUser'] == 1,
      isCorrectCheck: map['isCorrectCheck'] == 1,
      isLoading: map['isLoading'] == 1,
    );
  }
}
