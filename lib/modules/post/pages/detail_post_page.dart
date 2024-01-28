
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:socialnetworkapp/modules/authentication/bloc/authentication_bloc.dart';
import 'package:socialnetworkapp/modules/comments/blocs/comment_bloc.dart';
import 'package:socialnetworkapp/modules/comments/models/comment_create_model.dart';
import 'package:socialnetworkapp/modules/comments/models/comment_response_model.dart';
import 'package:socialnetworkapp/providers/bloc_provider.dart';
import 'dart:async';

import '../models/PostReadRequest.dart';
import '../widgets/ItemPost.dart';

class DetailPostPage extends StatefulWidget {
  @override
  _DetailPostPageState createState() => _DetailPostPageState();
}

class _DetailPostPageState extends State<DetailPostPage> {

   CommentRxDartBloc? get _commentbloc => BloCProvider.of<CommentRxDartBloc>(context);
   AuthenTicationBloc? get _authenbloc => BloCProvider.of<AuthenTicationBloc>(context);

   late Post? post;
   @override
   void didChangeDependencies() {
     super.didChangeDependencies();
     post = ModalRoute.of(context)!.settings.arguments as Post;
     _commentbloc!.getCommentsByNewsId(post!.id ?? 0);
   }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text(post!.title ??""),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PostWidget(post:post! ),
            Container(
              height: 300,
              child: StreamBuilder<CommentModelResponse?>(
                stream: _commentbloc!.commentStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(color: Colors.blueAccent,),);
                  }
                  if (snapshot.hasData && snapshot.data! != null) {
                    return ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final commentItem = snapshot.data!.data![index];
                        return ListTile(
                          title: Text(commentItem!.nameActor ??""),
                          subtitle: Text(commentItem!.comment ??""),
                        );
                      },
                    );
                  }
                  else{
                    return Center(child: CircularProgressIndicator(color: Colors.blueAccent,),);
                  }
                  // if(!snapshot.hasData){
                  //   return Center(child: Text("Bài viết chưa có bình luận ...", style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 10),));
                  // }
                  return SizedBox(height: 100,);
                },
              ),
            ),
            rowCommentWidget(post!),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget rowCommentWidget(Post post) {
    final commentController = TextEditingController();
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            flex: 10,
            child: TextField(
              controller: commentController,
              decoration: InputDecoration(
                labelText: 'Bình luận',
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: ClipOval(
              child: IconButton(
                color: Colors.blue,
                icon: Icon(Icons.send_sharp),
                onPressed: () async {
                  if(commentController.text == ""){
                    return;
                  }
                  _CreateComment(post,commentController.text );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _CreateComment(Post post, String comment) async{
    final nameactor = FirebaseAuth.instance.currentUser!.displayName!;

    final commentRequest = CommentCreateModel(nameActor: nameactor?? "No name" , comment: comment, created: DateTime.now(), newsId: post!.id?? 0);
    final results = await _commentbloc!.createComment(commentRequest);
    if(results == true){
      toast("Bình luận thành công ...");
      _commentbloc!.getCommentsByNewsId(post!.id?? 0);
    }
    else{
      toast("Bình luận không hành công ...");
    }
  }
}


