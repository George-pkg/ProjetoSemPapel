import 'package:get/get.dart';
import 'package:sem_papel/models/comments_models.dart';

class CommentController extends GetxController {
  var comments = <Comments>[].obs;

  void editComment(Comments updatedComment, Comments commentsvar) {
    // Encontre o comentário na lista e atualize-o
    final index = comments.indexWhere((item) => item == commentsvar);
    if (index >= 0) {
      comments[index] = updatedComment;
    }
  }
}