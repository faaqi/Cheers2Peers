import 'package:get/get.dart';
import 'package:cheers2peers/classes/person.dart';

class DataController extends GetxController {
  final setName = Person().obs;
  final setJob = Person().obs;
  final setDept = Person().obs;
  final setImg = Person().obs;

  final setCheerPoints = Person().obs;
  final setPosts = Person().obs;
  final setCheers = Person().obs;

  updateValues(String _name, String _job, String _dept, String img, int cp,
      int p, int cheers) {
    setName.update((val) {
      val.name = _name;
    });

    setJob.update((val) {
      val.job = _job;
    });

    setDept.update((val) {
      val.dept = _dept;
    });

    setImg.update((val) {
      val.imageAddress = img;
    });

    setCheerPoints.update((val) {
      val.points = cp;
    });

    setCheers.update((val) {
      val.cheeredTime = cheers;
    });

    setPosts.update((val) {
      val.posts = p;
    });
  }
}
