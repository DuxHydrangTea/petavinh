import 'package:mysql_client/mysql_client.dart';

class Topic {
  int? id;
  String? topicname;
  String? description;
  static List<Topic>? listAllTopic;
  Topic({
    this.id,
    this.topicname,
    this.description,
  });

  static Future getAllTopic() async {
    List<Topic> ltp = <Topic>[];
    final conn = await MySQLConnection.createConnection(
      host: "172.25.95.52",
      port: 3307,
      userName: "root",
      password: "123456",
      databaseName: "petavinh", // optional
    );
    await conn.connect();
    var result = await conn.execute(
      "select * from topic",
    );
    for (final row in result.rows) {
      int tId = int.parse(row.colAt(0).toString());
      String tName = row.colAt(1).toString();
      String tDes = row.colAt(2).toString();
      Topic tp = Topic(id: tId, topicname: tName, description: tDes);
      ltp.add(tp);
    }
    return ltp;
  }
}
