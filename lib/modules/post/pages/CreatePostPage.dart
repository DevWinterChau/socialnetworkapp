import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:socialnetworkapp/modules/post/blocs/CreatePostBloc.dart';
import '../../../appstate_bloc.dart';
import '../../../providers/bloc_provider.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  AppStateBloc? get appStateBloc => BloCProvider.of<AppStateBloc>(context);
  CreatePostBloc? get createPostBlog =>
      BloCProvider.of<CreatePostBloc>(context);
  final TextEditingController contentController = TextEditingController();
  final streamController = StreamController<List<PlatformFile>?>();
  final streamControllerUpload = StreamController<int?>();
  List<PlatformFile>? selectedFiles;
  final user = FirebaseAuth.instance.currentUser;
  Future<void> _pickFiles() async {
    try {
      FilePickerResult? result =  await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        selectedFiles = result.files;
        streamController.sink.add(result.files);
      }
    } catch (e) {
      toast("ĐÃ XẢY RA LỖI KHI ĐĂNG BÀI VIẾT ...");
    }
  }

  Future<void> _createPost() async {
    try {
      streamControllerUpload.sink.add(1);
      List<MultipartFile> fileEntries = [];
      for (var file in selectedFiles!) {
        fileEntries.add(await MultipartFile.fromFile(
          file.path!,
          filename: file.name!,
        ));
      }
      FormData formData = FormData.fromMap({
        'id': 0,
        'publishDate': DateTime.now(),
        'title': user!.displayName ?? 'No name',//titleController.text,
        'content': contentController.text,
        'listfile': fileEntries,
      });
      Options options = Options(
        contentType: 'multipart/form-data',
      );
      final result = await  createPostBlog!.createPost(formData, options);
      if(result == true){
        toast("ĐĂNG TIN THÀNH CÔNG ...");
        Navigator.pop(context, true);
      }
    } catch (e) {
      streamControllerUpload.sink.add(0);
      toast("Đã xảy ra lỗi khi tạo bài viết ...");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng tin"),
        actions: [
          GestureDetector(
            onTap:() async {
                 if(selectedFiles != null)  {
                   await _createPost();
                }
                else{
                  toast('BẠN CHƯA CHỌN ẢNH ...');
                }
            },
            child: Container(
              margin: EdgeInsets.all(5),
              color: Colors.blue,
              child: Row(
                children: [
                  Text("Đăng bài viết"),
                  Icon(Icons.done),
                ],
              ),
            )
          )
        ],
      ),
      body:   Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: contentController,
                  decoration: InputDecoration(
                    labelText: "Nội dung",

                  ),
                  maxLines: 5,
                ),
                // SizedBox(height: 16),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shadowColor: Colors.white,
                            backgroundColor: Colors.blue,
                            textStyle: TextStyle(
                                color: Colors.white
                            )
                        ),
                        onPressed: _pickFiles,
                        child: Text("Chọn ảnh"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Container(
                      height: 100, // Điều chỉnh độ cao của container để hiển thị ảnh
                      child: StreamBuilder<List<PlatformFile>?>(
                        stream: streamController.stream,
                        initialData: selectedFiles,
                        builder: (context, snapshot){
                          if (!snapshot.hasData || snapshot.data!.length ==0) {
                            return Text('Bạn chưa chọn ảnh ...');
                          }
                          else {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var file = snapshot.data![index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Stack(
                                    children: [
                                      Image.file(
                                        File(file.path!),
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            selectedFiles!.removeAt(index);
                                            streamController.sink.add(selectedFiles);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red, // You can customize the color
                                            ),
                                            padding: EdgeInsets.all(1),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white, // You can customize the color
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );

                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}

