import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:networking/models/post_model.dart';
import 'package:networking/service/http_service.dart';
import 'package:networking/service/log_service.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);
  static const String id = "create_page";

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  void _apiCreate() {
    String title = titleController.text;
    String body = bodyController.text;
    Post post = Post(title: title, body: body,userId: title.hashCode.toString());
    Network.POST(Network.API_CREATE, Network.paramsCreate(post))
        .then((response) {
      Log.d(response!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              _apiCreate();
              setState(() {});
              Navigator.of(context).pop(true);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Title",
              ),
            ),
            TextFormField(
              controller: bodyController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Body",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
