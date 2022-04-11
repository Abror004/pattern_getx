import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pattern_getx/model/post_model.dart';
import 'package:pattern_getx/services/http_service.dart';

class EditController extends GetxController {
  var titleController = TextEditingController().obs;
  var bodyController = TextEditingController().obs;
  var post = Post().obs;

  void save(BuildContext context) async {
    if(titleController.value.text != "" && bodyController.value.text != "") {
      post.value.title = titleController.value.text;
      post.value.body = bodyController.value.text;
      await Network.PUT(Network.API_UPDATE, Network.paramsUpdate(post.value));
      Navigator.pop(context, {"post": post.value});
    }
  }
}