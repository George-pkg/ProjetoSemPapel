// libs
import 'package:get/get.dart';
// models/utils
import 'package:master/models/comments_models.dart';

class CommentController extends GetxController {
  RxBool isComments = false.obs;

  List<Comments> listComments = <Comments>[
    Comments(id: 1, title: 'Comentario teste', description: 'este é um teste'),
    Comments(id: 2, title: 'Comentario teste', description: 'este é um teste')
  ].obs;

  void toggleCommentsVisibility() {
    isComments.value = !isComments.value;
  }

  int getLastId() {
    if (listComments.isEmpty) {
      return 0;
    } else {
      return listComments.last.id!;
    }
  }

  void addComment(Comments newComment) {
    int newId = getLastId() + 1;
    listComments
        .add(Comments(id: newId, title: newComment.title, description: newComment.description));
  }

  void editComment(Comments updatedComment, Comments commentMod) {
    final index = listComments.indexWhere((item) => item.id == commentMod.id);
    if (index >= 0) {
      listComments[index] = updatedComment;
    }
  }
}
