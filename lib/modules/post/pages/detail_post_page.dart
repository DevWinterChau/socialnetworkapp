
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:socialnetworkapp/modules/authentication/bloc/authentication_bloc.dart';
import 'package:socialnetworkapp/modules/comments/blocs/comment_bloc.dart';
import 'package:socialnetworkapp/modules/comments/models/comment_create_model.dart';
import 'package:socialnetworkapp/modules/comments/models/comment_response_model.dart';
import 'package:socialnetworkapp/providers/bloc_provider.dart';
import 'dart:async';

import '../../comments/models/comment_reply_model.dart';
import '../models/PostReadRequest.dart';
import '../widgets/ItemPost.dart';

class DetailPostPage extends StatefulWidget {
  @override
  _DetailPostPageState createState() => _DetailPostPageState();
}

class _DetailPostPageState extends State<DetailPostPage> {

   CommentRxDartBloc? get _commentbloc => BloCProvider.of<CommentRxDartBloc>(context);
   AuthenTicationBloc? get _authenbloc => BloCProvider.of<AuthenTicationBloc>(context);
   late bool isShowReplyCmt = false;
   late int idCommentCurrent = 0;
   late bool isShowReplyCmtList = false;
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
                        int idComment = commentItem!.idComment!;
                        return ListTile(
                          title: Text(commentItem!.nameActor ?? ""),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(commentItem!.comment ?? ""),
                              SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(calculateTimeCmt(commentItem!.created), style: TextStyle(color: Colors.black, fontSize: 10)),
                                  SizedBox(width: 5,),
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        isShowReplyCmt = !isShowReplyCmt;
                                        idCommentCurrent = idComment ;
                                      });
                                    },
                                    child: Text("Trả lời" , style: TextStyle(color: Colors.blue, fontSize: 10)),
                                  ),
                                ],
                              ),
                              isShowReplyCmt == true && commentItem.idComment == idCommentCurrent
                                  ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  rowCommentReplyWidget(post!, commentItem.idComment ??0)
                                ],
                              ) : SizedBox(height: 1,),

                              commentItem.commentsReplay != null && commentItem.commentsReplay!.isNotEmpty ?
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isShowReplyCmtList = !isShowReplyCmtList;
                                    idCommentCurrent = commentItem!.idComment!;
                                  });
                                },
                                child:  Text("Đã có ${commentItem.commentsReplay!.length} bình luận ..."),
                              )
                                  :   SizedBox(height: 1),
                              isShowReplyCmtList == true && idCommentCurrent == commentItem!.idComment
                                  ? Column(
                                children: List.generate(commentItem.commentsReplay!.length, (index) {
                                  final itemReply = commentItem.commentsReplay![index];
                                  return ListTile(
                                      title: Text(itemReply.nameActor ?? ""),
                                      subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(itemReply!.comment ?? ""),
                                            SizedBox(height: 2),
                                            Row(
                                              children: [
                                                Text(calculateTimeCmt(itemReply!.created), style: TextStyle(color: Colors.black, fontSize: 10)),
                                                SizedBox(width: 5,),
                                                GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      isShowReplyCmt = !isShowReplyCmt;
                                                      idCommentCurrent = itemReply!.idComment ?? 0;
                                                    });
                                                  },
                                                  child: Text("Trả lời" , style: TextStyle(color: Colors.blue, fontSize: 10)),
                                                ),
                                              ],
                                            ),
                                            // Column(
                                            //   crossAxisAlignment: CrossAxisAlignment.start,
                                            //   children: [
                                            //     rowCommentReplyWidget(post!, itemReply.idComment ??0)
                                            //   ],
                                            // )
                                            // isShowReplyCmt == true && itemReply.idComment == idCommentCurrent
                                            //     ? Column(
                                            //   crossAxisAlignment: CrossAxisAlignment.start,
                                            //   children: [
                                            //     rowCommentReplyWidget(post!, itemReply.idComment ??0)
                                            //   ],
                                            // ) : SizedBox(height: 1,),
                                          ]
                                      )
                                  );
                                }),
                              )
                                  : SizedBox()

                              // ListView.builder(
                              //   itemCount: commentItem.commentsReplay?.length ?? 0,
                              //   itemBuilder: (BuildContext context, int index) {
                              //     final commenreply = commentItem.commentsReplay?[index];
                              //     return buildCommentAndReplies(commenreply!);
                              //   },
                              // )
                        ],
                          )
                        );
                      },
                    );

                  }
                  else{
                    return Center(child: CircularProgressIndicator(color: Colors.blueAccent,),);
                  }
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

   Widget rowCommentReplyWidget(Post post, int idComment) {
     final commentController = TextEditingController();
     return Row(
         mainAxisAlignment: MainAxisAlignment.end,
         crossAxisAlignment: CrossAxisAlignment.end,
         children: [
           Flexible(flex: 8, child: TextField(
             controller: commentController,
             decoration: InputDecoration(
               hintText: "Nhập câu trả lời ...",
               labelText: 'Trả lời',
             ),
           ),),
           Flexible(flex: 1,child:  ClipOval(
             child: IconButton(
               color: Colors.blue,
               icon: Icon(Icons.send_sharp),
               onPressed: () async {
                 if(commentController.text == ""){
                   return;
                 }
                 var rs = await _CreateCommentReply(post,commentController.text, idComment);
                 if(rs == true){
                   commentController.clear();
                 }
               },
             ),
           ),),
         ],
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
                hintText: "Nhập bình luận ...",
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
                  var rs = await _CreateComment(post,commentController.text);
                  if(rs == true){
                    commentController.clear();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<bool?> _CreateComment(Post post, String comment) async{
    final nameactor = FirebaseAuth.instance.currentUser!.displayName!;

    final commentRequest = CommentCreateModel(nameActor: nameactor?? "No name" , comment: comment, created: DateTime.now(), newsId: post!.id?? 0);
    final results = await _commentbloc!.createComment(commentRequest);
    if(results == true){
      _commentbloc!.getCommentsByNewsId(post!.id?? 0);
      return true;
    }
    else{
      toast("Bình luận không thành công ...");
      return false;
    }
  }
  Future<bool?> _CreateCommentReply(Post post, String comment, int idComment) async{
     final nameactor = FirebaseAuth.instance.currentUser!.displayName!;
     final commentRequest = CommentReplyRequestModel(nameActor: nameactor?? "No name" , comment: comment, created: DateTime.now(), newsId: post!.id?? 0, commentIdReplay:  idComment);
     final results = await _commentbloc!.createCommentReply(commentRequest);
     if(results == true){
       _commentbloc!.getCommentsByNewsId(post!.id?? 0);
       return true;
     }
     else{
       toast("Trả lời bình luận không thành công ...");
       return false;
     }
   }

   String calculateTimeCmt(String? created) {
     if (created == null) {
       return ""; // Hoặc bạn có thể trả về một giá trị mặc định khác
     }

     final commentDate = DateTime.parse(created);
     final now = DateTime.now();
     final difference = now.difference(commentDate);

     if (difference.inMinutes == 0) {
       return "Hiện tại";
     } else if (difference.inMinutes < 60) {
       return "${difference.inMinutes} phút trước";
     } else if (difference.inHours < 24) {
       return "${difference.inHours} giờ trước";
     } else if (commentDate.year == now.year) {
       return "${commentDate.day} tháng ${commentDate.month} lúc ${commentDate.hour}:${commentDate.minute}";
     } else {
       return "${commentDate.day} tháng ${commentDate.month} ${commentDate.year} lúc ${commentDate.hour}:${commentDate.minute}";
     }
   }
   Widget buildCommentReply(CommentsReplay commentItemReply, int idCommentReply) {
     return ListTile(
       title: Text(commentItemReply.nameActor ?? ""),
       subtitle: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(commentItemReply.comment ?? ""),
           SizedBox(height: 2),
           Row(
             children: [
               Text(calculateTimeCmt(commentItemReply.created.toString()), style: TextStyle(color: Colors.black, fontSize: 10)),
               SizedBox(width: 5,),
               GestureDetector(
                 onTap: () {
                   setState(() {
                     toggleShowReply(idCommentReply);
                   });
                 },
                 child: Text("Trả lời", style: TextStyle(color: Colors.blue, fontSize: 10)),
               ),
             ],
           ),
           if (isShowReplyCmt == true && idCommentReply == idCommentCurrent)
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 rowCommentReplyWidget(post!, idCommentReply?? 0)
                 // ^ Assuming that 'rowCommentReplyWidget' is a valid function
               ],
             )
           else
             SizedBox(height: 1),
         ],
       ),
     );
   }

   void toggleShowReply(int idComment) {
     setState(() {
       isShowReplyCmt = !isShowReplyCmt;
       idCommentCurrent = idComment;
     });
   }


   Widget buildCommentAndReplies(CommentsReplay commentItem) {
     if (commentItem == null) {
       return SizedBox();
     }
     print(commentItem);
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Text(commentItem.comment ?? ""),
         SizedBox(height: 2),
         Row(
           children: [
             Text(calculateTimeCmt(commentItem.created), style: TextStyle(color: Colors.black, fontSize: 10)),
             SizedBox(width: 5,),
             GestureDetector(
               onTap: () {
                 setState(() {
                   isShowReplyCmtList = !isShowReplyCmtList;
                   idCommentCurrent = commentItem.idComment!;
                 });
               },
               child: Text("Đã có ${commentItem.commentsReplay?.length ?? 0} bình luận ..."),
             ),
           ],
         ),
         if (isShowReplyCmtList == true && idCommentCurrent == commentItem.idComment)
           Column(
             children: List.generate(commentItem.commentsReplay?.length ?? 0, (index) {
               final itemReply = commentItem.commentsReplay![index];
               return ListTile(
                 title: Text(itemReply.nameActor ?? ""),
                 subtitle: buildCommentAndReplies(itemReply),
               );
             }),
           ),
       ],
     );
   }



}


