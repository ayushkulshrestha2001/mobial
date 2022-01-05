class MessageModel {
  final String sender;
  final String text;
  final String reciever;
  final String timestamp;

  const MessageModel(
      {required this.sender,
      required this.text,
      required this.reciever,
      required this.timestamp});
}
