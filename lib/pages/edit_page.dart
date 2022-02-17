import 'package:flutter/material.dart';
import 'package:networking/models/post_model.dart';
import 'package:networking/service/http_service.dart';
import 'package:networking/service/log_service.dart';
 class EditPage extends StatefulWidget {
   static const String id = "edit_page";
   Post? post;
   EditPage({Key? key,this.post}) : super(key: key);

   @override
   _EditPageState createState() => _EditPageState();
 }

 class _EditPageState extends State<EditPage> {
   final titleController = TextEditingController();
   final bodyController = TextEditingController();

   void _apiEdit(){
     String title = titleController.text;
     String body = bodyController.text;
     if(widget.post != null){
       Post post = Post(id: widget.post!.id,title: title,body: body,userId: widget.post!.userId);
       Network.PUT(Network.API_UPDATE+post.id.toString(), Network.paramsUpdate(post)).then((value){
         Log.d(value!);
       });
     }
   }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.post!.title!;
    bodyController.text = widget.post!.body!;
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
               _apiEdit();
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
