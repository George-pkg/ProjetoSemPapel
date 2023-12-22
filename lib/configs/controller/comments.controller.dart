// libs
import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// models/utils
import 'package:master/models/comments_models.dart';

class CommentController extends GetxController {
  RxBool isComments = false.obs;

  List<Comments> listComments = <Comments>[
    Comments(
      id: 1,
      title: 'Comentario teste',
      description: 'este é um teste',
      photoUrl:
          'https://images.unsplash.com/photo-1606893995103-a431bce9c219?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWVuaW5hcyUyMGZvdG98ZW58MHx8MHx8fDA%3D',
      name: 'fiona',
      hour: '12:50',
    ),
    Comments(
      id: 2,
      title: 'Comentario teste',
      description: 'este é um teste',
      photoUrl:
          'https://images.unsplash.com/photo-1542909168-82c3e7fdca5c?q=80&w=1780&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      name: 'spike',
      hour: '12:40',
    )
  ].obs;

  late SharedPreferences _prefs;
  final _commentsKey = 'comments';

  @override
  void onInit() {
    super.onInit();
    _loadComments();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _loadComments() async {
    await _initPrefs();
    final commentsData = _prefs.getString(_commentsKey);
    if (commentsData != null) {
      final List<dynamic> decoded = jsonDecode(commentsData);
      listComments.assignAll(decoded.map((comment) => Comments.fromJson(comment)).toList());
    }
  }

  void _saveComments() {
    final encoded = jsonEncode(listComments.map((comment) => comment.toJson()).toList());
    _prefs.setString(_commentsKey, encoded);
  }

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
    listComments.add(Comments(
      id: newId,
      photoUrl: newComment.photoUrl,
      name: newComment.name,
      title: newComment.title,
      description: newComment.description,
      hour: "${DateTime.now().hour}:${DateTime.now().minute}",
    ));
    _saveComments();
  }

  void editComment(Comments updatedComment, Comments commentMod) {
    final index = listComments.indexWhere((item) => item.id == commentMod.id);
    if (index >= 0) {
      listComments[index] = updatedComment;
      _saveComments();
    }
  }

  void deleteComment(Comments commentToDelete) {
    listComments.removeWhere((comment) => comment.id == commentToDelete.id);
    _saveComments();
  }
}
