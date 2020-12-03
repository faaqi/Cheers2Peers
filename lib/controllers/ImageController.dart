import 'package:get/get.dart';
import 'dart:io' as IO;
import 'package:cheers2peers/classes/person.dart';

class ImageController extends GetxController {
  final imageData = Person().obs;

  updateValues(IO.File img) {
    imageData.update((val) {
      val.shopImgFile = img;
    });
  }
}
