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
    this.fullname = "",
    this.avatar = "",
    required this.topicId,
    this.topicname = "",
    required this.groupId,
    this.groupName = "",
    this.groupImage = "",
    required this.image,
    required this.postedDate,
    required this.approve,
    this.numLike = 0,
    this.numCmt = 0,
    this.numSave = 0,
  });
}
