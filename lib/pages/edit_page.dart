import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pattern_getx/controllers/edit_controller.dart';
import 'package:pattern_getx/model/post_model.dart';

class Edit_Page extends StatefulWidget {
  static const String id = "edit_page";

  Post? post;

  Edit_Page({this.post});

  @override
  _Edit_PageState createState() => _Edit_PageState();
}

class _Edit_PageState extends State<Edit_Page> {
  EditController editController = EditController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editController.post.value = widget.post!;
    editController.titleController.value.text = widget.post!.title!;
    editController.bodyController.value.text = widget.post!.body!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              editController.save(context);
              },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          primary: true,
          physics: ScrollPhysics(),
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Text("title",style: TextStyle(fontSize: 25,color: Colors.blue),),
              TextField(
                  controller: editController.titleController.value,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.grey),
                    // border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  style: TextStyle(fontSize: 18,color: Colors.black),
                  maxLines: (editController.titleController.value.text.length/30).toInt()+1,
                  onChanged: (text) {

                  }
              ),
              Text("body",style: TextStyle(fontSize: 25,color: Colors.blue),),
              TextField(
                controller: editController.bodyController.value,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: "body",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: TextStyle(fontSize: 18,color: Colors.black),
                maxLines: (double.maxFinite).toInt(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
