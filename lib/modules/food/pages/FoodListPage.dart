
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/ListFoodBloC.dart';
import '../widgets/ItemFood.dart';

class FoodListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Danh sách sản phẩm'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ProductList(),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final _foodListBloc = ListFoodBloC();

  @override
  void initState() {
    super.initState();
    // Them sự kiện
    _foodListBloc.add("getAllFoodListByUserId");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListFoodBloC, ListFoodState>(
      bloc: _foodListBloc,
      builder: (context, post) {
        print(post);
        return
          post!.foodlist != null
            ? ListView.builder(
          itemCount: 24,
          itemBuilder: (context, index) {
            final product = post.foodlist![index];
            return ItemFood(itemFood: product);
          },
        ):
          Center(
            child: Container(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          );
      },
    );
  }
}
