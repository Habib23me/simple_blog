import 'package:simple_blog/simple_blog.dart';

extension FindById<T extends Model> on List<T> {
  T findById(String id) {
    return firstWhere((element) => element.id == id, orElse: () => null);
  }

  List<T> findAndReplaceById(String id, T data) {
    var index = indexWhere(
      (element) => element.id == id,
    );
    if (index == -1) {
      return List.from(this);
    }
    return List.from(this)..[index] = data;
  }

  List<T> findAndRemoveById(String id) {
    var index = indexWhere(
      (element) => element.id == id,
    );
    if (index == -1) {
      return List.from(this);
    }
    return List.from(this)..removeAt(index);
  }
}
