import 'dart:async';
import 'package:flutter/material.dart';
import 'package:socialnetworkapp/modules/post/blocs/CreatePostBloc.dart';
import 'package:socialnetworkapp/modules/post/models/PostReadRequest.dart';
import '../../../appstate_bloc.dart';
import '../../../providers/bloc_provider.dart';
import '../widgets/ItemPost.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  AppStateBloc? get appStateBloc => BloCProvider.of<AppStateBloc>(context);
  CreatePostBloc? get postbloc => BloCProvider.of<CreatePostBloc>(context);

  Future<PostModelReponse?> _fectdata() async {
       final reponse = await postbloc!.getAllPost();
       print(reponse);
       if(reponse != null){
         return reponse;
       }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(child: Text("News day"),onTap:   (){
          Navigator.popAndPushNamed(context, "/");
        }),
        actions: [
          IconButton(
            onPressed:(){
              Navigator.pushNamed(context, "/profile");
            },
            icon: Icon(Icons.account_circle_rounded),
            color: Colors.white,
          ),
          IconButton(
            onPressed:() async {
              final results = await Navigator.pushNamed(context, "/create-post");
              if(results == true){
                Navigator.popAndPushNamed(context, "/");
              }
             },
            icon: Icon(Icons.add_circle_sharp),
            color: Colors.white,
          ),
          IconButton(
              onPressed:() async{
               await  _changeAppState();
               },
              icon: Icon(Icons.exit_to_app),
              color: Colors.white,
          ),
        ],
      ),
      body:
      Center(
        child:  FutureBuilder<PostModelReponse?>(
            future: _fectdata(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data! == null) {
                return Text('Dữ liệu không có sẵn ...');
              } else {
            // Dữ liệu đã sẵn sàng, xây dựng giao diện người dùng ở đây
            final productList = snapshot.data!.data;
            return ListView.builder(
              itemCount: productList!.length,
              itemBuilder: (context, index) {
                final post = productList![index];
                return PostWidget(post: post,);
              },
            );
          }
        }
      ),
     ),
    );
  }   Future<void> _changeAppState() async{
      await appStateBloc!.changeAppState(AppState.unAuthorized);
  }
}


