import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../blocs/list_post_rxdart_bloc.dart';
import '../models/PostReadRequest.dart';
import '../repos/list_post_paging_repo.dart';
import 'ItemPost.dart';

class SearchSomethinDelegate extends SearchDelegate<String> {
  final _postbloc = ListPostRxDartBloc(ListPostPageRepo());
  SearchSomethinDelegate() {
    // Khởi tạo dữ liệu
    _postbloc.getPost();
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<List<Post>?>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(
                "Loading ...",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          );
        }
        else if (snapshot.hasError) {
          return SliverToBoxAdapter(
              child: Center(child:  Text(
                'Đã xảy ra lỗi khi tải nội dung ...',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),)
          );
        }
        else if (!snapshot.hasData || snapshot.data == null) {
          return SliverToBoxAdapter(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Chưa có bài viết nào ...'),
                  IconButton(
                    onPressed: () async {
                      final results =
                      await Navigator.pushNamed(context, "/create-post");
                      if (results == true) {
                        Navigator.popAndPushNamed(context, "/");
                      }
                    },
                    icon: Icon(Icons.add_circle_sharp),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        }
        else {
          final productList = snapshot.data!;
          final results = productList.where((item) =>
              item.content!.toLowerCase().contains(query.toLowerCase()));
          return ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final post = results.elementAt(index);
                    return PostWidget(post: post);
                  },
                );
        }
      },
      stream: _postbloc!.postStream,
    );
  }
  @override
  List<Widget>? buildActions(BuildContext context) {
    // Actions for the AppBar (e.g., clear text, voice search)
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search query
        },
      ),
    ];
  }
  @override
  Widget? buildLeading(BuildContext context) {
    // Leading widget (e.g., back button)
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "null"); // Close the search interface
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text("Nhập từ khóa để tìm kiếm ...."),);
  }
}
