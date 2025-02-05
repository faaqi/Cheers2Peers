import 'package:get/get.dart';
import 'package:cheers2peers/classes/person.dart';

class SelectedEmpController extends GetxController {
  final setName = Person().obs;
  final setJob = Person().obs;
  final setImg = Person().obs;
  final setEmail = Person().obs;

  updateValues(String _name, String _job, String img, String _email) {
    setName.update((val) {
      val.name = _name;
    });

    setJob.update((val) {
      val.job = _job;
    });

    setImg.update((val) {
      val.imageAddress = img;
    });

    setEmail.update((val) {
      val.email = _email;
    });
  }
}
