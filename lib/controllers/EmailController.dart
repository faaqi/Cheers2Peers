import 'package:get/get.dart';
import 'package:cheers2peers/classes/person.dart';

class EmailController extends GetxController {
  final emailString = Person().obs;

  updateValues(String mail) {
    emailString.update((val) {
      val.email = mail;
    });
  }
}
