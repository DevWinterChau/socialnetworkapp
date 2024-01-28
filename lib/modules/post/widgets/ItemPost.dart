import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '../models/PostReadRequest.dart';

class PostWidget extends StatelessWidget {
  final streamIcon = StreamController<int>();
  IconData currentIcon = Icons.favorite_border;
  final GlobalKey _textKey = GlobalKey();
  OverlayEntry? overlayEntry;
  final Post post;
  PostWidget({required this.post});
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
      onTap: () {
        _removeOverlay();
        Navigator.pushNamed(context, "/detailsPost",  arguments: post);
      },
      child: Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 5,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    post.publishDate != null
                        ? DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(post.publishDate!))
                        : "",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 8.0),
          Text(post.content ?? ""),
          SizedBox(height: 8.0),
          post.images != null
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: post.images!.length > 2
                    ? Row(
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: post.images![0].imageUrl ?? "",
                        imageBuilder: (context, imageProvider) {
                          return Image(
                            image: ResizeImage(
                              imageProvider,
                              width: MediaQuery.of(context).size.width.round() * 2,
                              height: MediaQuery.of(context).size.width.round() * 2,
                            ),
                            fit: BoxFit.cover,
                          );
                        },
                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CachedNetworkImage(
                              imageUrl: post.images![1].imageUrl ?? "",
                              imageBuilder: (context, imageProvider) {
                                return Image(
                                  image: ResizeImage(
                                    imageProvider,
                                    width: MediaQuery.of(context).size.width.round(),
                                    height: MediaQuery.of(context).size.width.round(),
                                  ),
                                  fit: BoxFit.cover,
                                );
                              },
                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            flex: 1,
                            child: CachedNetworkImage(
                              imageUrl: post.images![2].imageUrl ?? "",
                              imageBuilder: (context, imageProvider) {
                                return Image(
                                  image: ResizeImage(
                                    imageProvider,
                                    width: MediaQuery.of(context).size.width.round(),
                                    height: MediaQuery.of(context).size.width.round(),
                                  ),
                                  fit: BoxFit.cover,
                                );
                              },
                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                    : post.images!.length == 2
                    ? Row(
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: post.images![0].imageUrl ?? "",
                        imageBuilder: (context, imageProvider) {
                          return Image(
                            image: ResizeImage(
                              imageProvider,
                              width: (MediaQuery.of(context).size.width / 2).round() * 2,
                              height: (MediaQuery.of(context).size.width / 2).round() * 2,
                            ),
                            fit: BoxFit.cover,
                          );
                        },
                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: post.images![1].imageUrl ?? "",
                        imageBuilder: (context, imageProvider) {
                          return Image(
                            image: ResizeImage(
                              imageProvider,
                              width: (MediaQuery.of(context).size.width / 2).round() * 2,
                              height: (MediaQuery.of(context).size.width / 2).round() * 2,
                            ),
                            fit: BoxFit.cover,
                          );
                        },
                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ],
                )
                    : CachedNetworkImage(
                  imageUrl: post.images![0].imageUrl ?? "",
                  imageBuilder: (context, imageProvider) {
                    return Image(
                      image: ResizeImage(
                        imageProvider,
                        width: MediaQuery.of(context).size.width.round() * 2,
                        height: MediaQuery.of(context).size.width.round() * 2,
                      ),
                      fit: BoxFit.cover,
                    );
                  },
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(height: 10),
            ],
          )
              : SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<int>(
                  stream: streamIcon.stream,
                  initialData: 4,
                  builder: (context, snapshot) {
                    if(snapshot.data == 0){
                      return IconButton(
                          key: _textKey,
                          onPressed: () {
                            _showBubble(context);
                          },
                          icon: Icon(Icons.thumb_up, color: Colors.blueAccent,)
                      );}
                    if(snapshot.data == 1){
                      return IconButton(
                          key: _textKey,
                          onPressed: () {
                            _showBubble(context);
                          },
                          icon: Icon(Icons.favorite, color: Colors.red,)
                      );}
                    if(snapshot.data == 2){
                      return IconButton(
                          key: _textKey,
                          onPressed: () {
                            _showBubble(context);
                          },
                          icon: Icon(Icons.thumb_down, color: Colors.indigo,)
                      );}
                    if(snapshot.data == 3){
                      return IconButton(
                          key: _textKey,
                          onPressed: () {
                            _showBubble(context);
                          },
                          icon: Icon(Icons.tag_faces_rounded, color: Colors.yellowAccent, size: 30,)
                      );}
                    return IconButton(
                        key: _textKey,
                        onPressed: () {
                          _showBubble(context);
                        },
                        icon: Icon(Icons.thumb_up, color: Colors.grey,)
                    );
                  }),
              IconButton(
                onPressed: () {
                },
                icon: Icon(
                  Icons.mode_comment_rounded,
                  color: Colors.grey,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Handle share button click
                },
                icon: Icon(
                  Icons.share,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

        ],
      ),
    )
    );
  }
  void _showBubble(BuildContext context) {
    final overlay = Overlay.of(context);

    final RenderBox renderBox = _textKey.currentContext!.findRenderObject() as RenderBox;
    final textWidgetSize = renderBox.size;
    final textWidgetPosition = renderBox.localToGlobal(Offset.zero);

    final bubblePosition = Offset(
      textWidgetPosition.dx + (textWidgetSize.width / 60) ,
      textWidgetPosition.dy - 60.0,
    );

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: bubblePosition.dy,
        left: bubblePosition.dx,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (index) => IconButton(
                icon:
                      index == 0
                    ? Icon(Icons.thumb_up, color: Colors.blueAccent,)
                    : index == 1
                    ? Icon(Icons.favorite, color: Colors.red,)
                    : index == 2
                    ? Icon(Icons.thumb_down, color: Colors.indigo,)
                    : index == 3
                    ? Icon(Icons.tag_faces_rounded, color: Colors.yellowAccent, size: 30,)
                    : index == 4
                    ?Icon(Icons.block_sharp, color: Colors.grey,) : SizedBox(),
                onPressed: () {
                  switch(index){
                    case 0:
                      streamIcon.sink.add(index);
                      break;
                    case 1:
                      streamIcon.sink.add(index);
                      break;
                    case 2:
                      streamIcon.sink.add(index);
                      break;
                    case 3:
                      streamIcon.sink.add(index);
                      break;
                    case 4:
                      streamIcon.sink.add(index);
                      break;
                    default:
                      streamIcon.sink.add(4);
                  }
                  _removeOverlay();
                },
              ),
              ),
            ),
          ),

        ),
      ),
    );
    overlay.insert(overlayEntry!);
  }
  void _removeOverlay() {
    overlayEntry?.remove();
  }
}

