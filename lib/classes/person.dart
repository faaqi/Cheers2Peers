import 'package:cheers2peers/classes/recognition.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class Person {
  Person({
    this.imageAddress = "",
    this.posts = 0,
    this.cheeredTime = 0,
    this.points = 0,
  });

  String email;
  String imageAddress;
  File shopImgFile;
  int posts;
  int cheeredTime;
  int points;
  String name, dept, job;
}
