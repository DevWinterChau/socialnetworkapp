import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialnetworkapp/appstate_bloc.dart';
import 'package:socialnetworkapp/modules/post/blocs/list_post_rxdart_bloc.dart';
import 'package:socialnetworkapp/modules/post/repos/list_post_paging_repo.dart';
import '../../../common/mixin/scroll_page_mixin.dart';
import '../../../providers/bloc_provider.dart';
import '../models/PostReadRequest.dart';
import '../widgets/ItemPost.dart';

class HomePage_Paging extends StatefulWidget {
  const HomePage_Paging({super.key});

  @override
  State<HomePage_Paging> createState() => _HomePage_PagingState();
}

class _HomePage_PagingState extends State<HomePage_Paging>  with ScrollPageMixin{
  AppStateBloc? get appStateBloc => BloCProvider.of<AppStateBloc>(context);
 // ListPostRxDartBloc? get _postbloc => BloCProvider.of<ListPostRxDartBloc>(context);
  final _scrollCtrl = ScrollController();
  final _postbloc = ListPostRxDartBloc(ListPostPageRepo());
  @override
  void initState(){
    super.initState();
    _postbloc!.getPost();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: CustomScrollView(
        controller: _scrollCtrl,
        physics: AlwaysScrollableScrollPhysics(), // or other available scroll physics
        slivers: <Widget>[
          SliverAppBar(
            title: GestureDetector(
              child: Text("Social Network App"),
              onTap: () {
                Navigator.popAndPushNamed(context, "/");
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/profile");
                },
                icon: Icon(Icons.account_circle_rounded),
                color: Colors.white,
              ),
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
              IconButton(
                onPressed: () async {
                  Logout();
                  // await _changeAppState();
                },
                icon: Icon(Icons.exit_to_app),
                color: Colors.white,
              ),
            ],
          ),
          StreamBuilder<List<Post>?>(
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

                // Load được dữ liệu thành công ...
                final productList = snapshot.data!;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      if (index < productList.length) {
                        final post = productList[index];
                        return PostWidget(post: post);
                      } else if (index == productList.length) {
                        return Container(
                          padding: EdgeInsets.all(12.0),
                          alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: (){
                                _scrollCtrl.animateTo(
                                  0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Icon(Icons.refresh_sharp,
                                  color: Colors.blue,
                                ),
                              ),
                            )
                        );
                      }
                      return Container();
                    },
                    childCount: productList.length + 1, // +1 for the "Load More" button
                  ),
                );
              }
            },
            stream: _postbloc!.postStream,
          ),
        ],
      ),
    );
  }

  Future<void> _changeAppState() async{
    await appStateBloc!.changeAppState(AppState.unAuthorized);
  }
  void Logout() {
    appStateBloc!.logout();
  }
  @override
  void dispose() {
    super.dispose();
    _scrollCtrl.dispose();
  }
  @override
  void loadMoreData() {
     _postbloc!.getPost();
  }
  @override
  void reloadData() {
    _postbloc!.reloadPost();
  }
  @override
  ScrollController get scrollController => _scrollCtrl;
}
