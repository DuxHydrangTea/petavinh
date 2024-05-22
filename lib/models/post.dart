class Post {
  int id;
  String title;
  String content;
  int userId;
  String fullname;
  String avatar;
  int topicId;
  String topicname;
  int groupId;
  String groupName;
  String groupImage;

  String image;
  String postedDate;
  int approve;
  int numLike;
  int numCmt;
  int numSave;
  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.userId,
    required this.fullname,
    required this.avatar,
    required this.topicId,
    required this.topicname,
    required this.groupId,
    required this.groupName,
    required this.groupImage,
    required this.image,
    required this.postedDate,
    required this.approve,
    this.numLike = 0,
    this.numCmt = 0,
    this.numSave = 0,
  });
}
