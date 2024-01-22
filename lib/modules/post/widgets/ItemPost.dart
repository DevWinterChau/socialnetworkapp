
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:intl/intl.dart';
import 'package:socialnetworkapp/modules/post/models/PostReadRequest.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  PostWidget({required this.post});

  // Future<Uint8List> compressImage(String? imageUrl) async {
  //   try {
  //     final Response response = await Dio().get(imageUrl!, options: Options(responseType: ResponseType.bytes));
  //     if (response.statusCode == 200) {
  //       List<int> imageBytes = response.data as List<int>;
  //       // Compression code
  //       Uint8List compressedBytes = await FlutterImageCompress.compressWithList(
  //         Uint8List.fromList(imageBytes),
  //         minHeight: 800,
  //         minWidth: 800,
  //         quality: 90,
  //         rotate: 0,
  //       );
  //       print(imageUrl);
  //       print(compressedBytes.length);
  //       return compressedBytes;
  //     } else {
  //       print('Failed to download image. Status code: ${response.statusCode}');
  //       return Future.error('Failed to download image');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     return Future.error('Error: $e');
  //   }
  // }
  // Future<List<Uint8List>?> ListcompressImage(List<Images> imageUrls) async {
  //   try {
  //     final List<Uint8List?> unit8ListImages = await Future.wait(imageUrls.map((post) async {
  //       try {
  //         final Response response = await Dio().get(post!.imageUrl!, options: Options(responseType: ResponseType.bytes));
  //         if (response.statusCode == 200) {
  //           List<int> imageBytes = response.data as List<int>;
  //           // Compression code
  //           Uint8List compressedBytes = await FlutterImageCompress.compressWithList(
  //             Uint8List.fromList(imageBytes),
  //             minHeight: 800,
  //             minWidth: 800,
  //             quality: 90,
  //             rotate: 0,
  //           );
  //           return compressedBytes;
  //         } else {
  //           print('Failed to download image. Status code: ${response.statusCode}');
  //           return null;
  //         }
  //       } catch (e) {
  //         print('Error downloading or compressing image: $e');
  //         return null;
  //       }
  //     }));
  //
  //     return unit8ListImages.where((image) => image != null).toList().cast<Uint8List>();
  //   } catch (e) {
  //     print('Error: $e');
  //     return Future.error('Error: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post!.title!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
              post!.publishDate != null
                  ? DateFormat('yyyy-MM-dd HH:mm:ss')
                  .format(DateTime.parse(post!.publishDate!))
                  : "",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 8.0),
          Text(post!.content??  ""),
          SizedBox(height: 8.0),
          post!.images != null
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   width: double.infinity,
          //   height: MediaQuery.of(context).size.width,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(8.0),
          //   ),
          //     child: post!.images!.length > 2
          //         ? FutureBuilder<List<Uint8List>?>(
          //       future: ListcompressImage(post!.images!),
          //       builder: (context, snapshot) {
          //         if (snapshot.connectionState == ConnectionState.done) {
          //           return Row(
          //             children: [
          //               Expanded(
          //                 child: CachedNetworkImage(
          //                   imageUrl: post!.images![0].imageUrl ?? "",
          //                   imageBuilder: (context, imageProvider) {
          //                     return Image.memory(
          //                       snapshot.data![0] as Uint8List,
          //                       fit: BoxFit.cover,
          //                     );
          //                   },
          //                   placeholder: (context, url) =>
          //                       Center(child: CircularProgressIndicator()),
          //                   errorWidget: (context, url, error) =>
          //                       Text(error.toString()),
          //                 ),
          //               ),
          //               Expanded(
          //                 child: Column(
          //                   children: [
          //                     Expanded(
          //                       flex: 1,
          //                       child: CachedNetworkImage(
          //                         imageUrl: post!.images![1].imageUrl ?? "",
          //                         imageBuilder: (context, imageProvider) {
          //                           return Image.memory(
          //                             snapshot.data![1] as Uint8List,
          //                             fit: BoxFit.cover,
          //                           );
          //                         },
          //                         placeholder: (context, url) =>
          //                             Center(child: CircularProgressIndicator()),
          //                         errorWidget: (context, url, error) =>
          //                             Text(error.toString()),
          //                       ),
          //                     ),
          //                     Expanded(
          //                       flex: 1,
          //                       child: CachedNetworkImage(
          //                         imageUrl: post!.images![2].imageUrl ?? "",
          //                         imageBuilder: (context, imageProvider) {
          //                           return Image.memory(
          //                             snapshot.data![2] as Uint8List,
          //                             fit: BoxFit.cover,
          //                           );
          //                         },
          //                         placeholder: (context, url) =>
          //                             Center(child: CircularProgressIndicator()),
          //                         errorWidget: (context, url, error) =>
          //                             Icon(Icons.error),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           );
          //         } else {
          //           return Center(child: CircularProgressIndicator());
          //         }
          //       },
          //     )
          //         : post!.images!.length == 2
          //         ? Row(
          //       children: [
          //         Expanded(
          //           child: CachedNetworkImage(
          //             imageUrl: post!.images![0].imageUrl ?? "",
          //             placeholder: (context, url) =>
          //                 Center(child: CircularProgressIndicator()),
          //             errorWidget: (context, url, error) => Icon(Icons.error),
          //           ),
          //         ),
          //         Expanded(
          //           child: CachedNetworkImage(
          //             imageUrl: post!.images![1].imageUrl ?? "",
          //             placeholder: (context, url) =>
          //                 Center(child: CircularProgressIndicator()),
          //             errorWidget: (context, url, error) => Icon(Icons.error),
          //           ),
          //         ),
          //       ],
          //     )
          //         : FutureBuilder<Uint8List>(
          //       future: compressImage(post!.images![0].imageUrl ?? ""),
          //       builder: (context, snapshot) {
          //         if (snapshot.connectionState == ConnectionState.done) {
          //           return CachedNetworkImage(
          //             imageUrl: post!.images![0].imageUrl ?? "",
          //             imageBuilder: (context, imageProvider) {
          //               return Image.memory(
          //                 snapshot.data!,
          //                 fit: BoxFit.cover,
          //               );
          //             },
          //             placeholder: (context, url) =>
          //                 Center(child: CircularProgressIndicator()),
          //             errorWidget: (context, url, error) => Icon(Icons.error),
          //           );
          //         } else {
          //           return Center(child: CircularProgressIndicator());
          //         }
          //       },
          //     ),
          // ),
            Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: post!.images!.length > 2
                ? Row(
              children: [
                Expanded(
                  child: Image.network(
                    post!.images![0].imageUrl ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.network(
                          post!.images![1].imageUrl ?? "",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Image.network(
                          post!.images![2].imageUrl ?? "",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
                : post!.images!.length == 2
                ? Row(
              children: [
                Expanded(
                  child: Image.network(
                    post!.images![0].imageUrl ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Image.network(
                    post!.images![1].imageUrl ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
                : Image.network(
              post!.images![0].imageUrl ?? "",
              fit: BoxFit.cover,
            ),
          ),
            Row(
            children: [
              IconButton(onPressed: (){
              }, icon: Icon(
                  Icons.favorite,
                 color: Colors.red,
              )),
              IconButton(onPressed: (){
              }, icon: Icon(
                Icons.mode_comment_rounded,
                color: Colors.grey,
              )),
              IconButton(onPressed: (){
              }, icon: Icon(
                Icons.share,
                color: Colors.grey,
              ))
            ],
          )
        ],
      )
          : SizedBox(),
      ],
      ),
    );
  }
}
