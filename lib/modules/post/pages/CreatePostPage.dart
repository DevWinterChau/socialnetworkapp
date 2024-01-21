import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_support/overlay_support.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  List<PlatformFile>? selectedFiles;

  Future<void> _pickFiles() async {
    try {
      FilePickerResult? result =
      await FilePicker.platform.pickFiles(allowMultiple: true);

      if (result != null) {
        setState(() {
          selectedFiles = result.files;
        });
      }
    } catch (e) {
      print("Lỗi khi chọn ảnh: $e");
    }
  }

  Future<void> _createPost() async {
    try {
      Dio dio = Dio();
      String apiUrl =
          "https://14b1-1-53-113-242.ngrok-free.app/api/news";
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
        'title': "Tiêu đề",//titleController.text,
        'content': contentController.text,
        'listfile': fileEntries,
      });

      // Sử dụng Options để xác định loại dữ liệu là 'multipart/form-data'
      Options options = Options(
        contentType: 'multipart/form-data',
      );

      Response response = await dio.post(apiUrl, data: formData, options: options);

      if(response.statusCode == 200 ){
        toast("Đăng bài thành công");
      //  Navigator.pop(context);
      }
    } catch (e) {
      print("Lỗi khi tạo bài viết: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng tin"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField(
            //   controller: titleController,
            //   decoration: InputDecoration(labelText: "Tiêu đề"),
            // ),
            SizedBox(height: 16),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: "Nội dung"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickFiles,
              child: Text("Chọn ảnh"),
            ),
            SizedBox(height: 16),
            selectedFiles != null
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ảnh đã chọn:"),
                SizedBox(height: 8),
                Container(
                  height: 100, // Điều chỉnh độ cao của container để hiển thị ảnh
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedFiles!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.file(
                          File(selectedFiles![index].path!),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
                : Container(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _createPost,
              child: Text("Tạo bài viết"),
            ),
          ],
        ),
      ),
    );
  }
}
