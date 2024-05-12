import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petavinh/models/topic.dart';
import 'package:petavinh/views/components/home_components/chip_item.dart';

class MyListChip {
  static List<Widget> getCategoryChip() {
    List<MyChip> lc = [
      MyChip(
          topic: Topic(id: 1, topicname: "All", description: "Nothing"),
          seleted: 1),
      MyChip(
          topic: Topic(id: 2, topicname: "Cho", description: "Nothing"),
          seleted: 0),
      MyChip(
          topic: Topic(id: 3, topicname: "Meo", description: "Nothing"),
          seleted: 0),
      MyChip(
          topic: Topic(id: 4, topicname: "Ca Xau", description: "Nothing"),
          seleted: 0),
      MyChip(
          topic: Topic(id: 5, topicname: "Hoc Ngu", description: "Nothing"),
          seleted: 0),
      MyChip(
          topic: Topic(id: 6, topicname: "Hihi", description: "Nothing"),
          seleted: 0),
    ];
    return lc;
  }

  static List<Topic> getRangeChip() {
    List<Topic> lc = [
      Topic(id: 1, topicname: "All", description: "Nothing"),
      Topic(id: 2, topicname: "Group", description: "Nothing"),
      Topic(id: 3, topicname: "My follow", description: "Nothing"),
    ];
    return lc;
  }
}
