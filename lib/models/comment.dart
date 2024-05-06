class Comment {
  int id, postId, userId;
  String commentText, commentedTime, fullname, avatar;
  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.commentText,
    required this.commentedTime,
    required this.fullname,
    required this.avatar,
  });
}
