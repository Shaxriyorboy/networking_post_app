import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:networking/models/post_model.dart';
import 'package:networking/pages/create_page.dart';
import 'package:networking/pages/edit_page.dart';
import 'package:networking/service/http_service.dart';
import 'package:networking/service/log_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = "home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Post> _list = [];

  void _apiPostList() {
    setState(() {
      isLoading = true;
    });
    Network.GET(Network.API_LIST, Network.paramsEmpty()).then((response) => {
          Log.d(response!),
          _showResponse(response),
        });
  }

  void _apiDelete(int id){
    setState(() {
      isLoading = true;
    });
    Network.DEL(Network.API_DELETE+id.toString(), Network.paramsEmpty()).then((response){
      Log.d(response!);
      _resPostDelete(response);
    });
  }

  void _resPostDelete(String response){
    setState(() {
      isLoading = false;
    });
    if(response != null) _apiPostList();
  }

  void _showResponse(String response) {
    List<Post> list = Network.parsePostList(response);
    _list.clear();
    setState(() {
      isLoading = false;
      _list = list;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP Network"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Stack(
          children: [
            !isLoading?ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    child: ListTile(
                      title: Text(_list[index].title!),
                      subtitle: Text(_list[index].body!),
                    ),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context){
                            int _id = int.parse(_list[index].id!);
                            _apiDelete(_id);
                            setState(() {});
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    startActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context)async{
                            var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return EditPage(post: _list[index],);
                            }));
                            if(result){
                              _apiPostList();
                              setState(() {});
                            }
                          },
                          backgroundColor: Color(0xFF0392CF),
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Delete',
                        ),
                      ],
                    ),
                  );
                }):SizedBox.shrink(),
            isLoading?Center(
              child:  CircularProgressIndicator(),
            ):SizedBox.shrink(),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
          var resalt = await Navigator.of(context).pushNamed(CreatePage.id);
          if(resalt == true){
            _apiPostList();
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

}
