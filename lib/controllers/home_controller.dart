import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pattern_getx/model/post_model.dart';
import 'package:pattern_getx/pages/edit_page.dart';
import 'package:pattern_getx/services/http_service.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var items = [].obs;

  void apiPostList() async {
    isLoading.value = true;
    var response = (await Network.GET(Network.API_LIST, Network.paramsEmpty()));
    if(response != null) {
      _showResponse(response);
    } else {
      items.value = [];
    }
  }

  void _showResponse(String response) {
    List<Post> list = Network.parsePostList(response);
    items.value.clear();
    isLoading.value = false;
    items.value = list;

  }

  Future apiPostDelete(Post post) async {
    isLoading.value = true;
    var response = await Network.DEL(
        Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    if (response != null) {
      items.remove(post);
    }
    isLoading.value = false;
    Timer(const Duration(seconds: 2), () => apiPostList());
  }

  Future goToEditPage(Post post,BuildContext context) async {
    Map? result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Edit_Page(post: post,)));
    print(result);
    if(result!["post"] != null) {
      Post newPost = result["post"];
      items[items.indexWhere((element) => element.id == newPost.id)] = newPost;
    }
    Timer(const Duration(seconds: 2), () => apiPostList());
  }
}