class User {
  int id;
  String username, password, fullname, avatar, joinedTime, description;
  int isAdmin;
  User(
      {this.id = 0,
      this.username = "",
      this.password = "",
      this.fullname = "",
      this.avatar = "",
      this.joinedTime = "",
      this.description = "",
      this.isAdmin = 0});
}
