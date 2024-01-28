import 'dart:async';

import 'package:flutter/cupertino.dart';

mixin ScrollPageMixin<T extends StatefulWidget> on State<T> {
  ScrollController get scrollController;
  void loadMoreData();
  void reloadData();
  bool isScrollingDown = true;

  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (_debounceTimer != null && _debounceTimer!.isActive) {
        _debounceTimer!.cancel();
      }

      _debounceTimer = Timer(Duration(milliseconds: 234), () {
        final extentAfter = scrollController.position.extentAfter;
        final extentBefore = scrollController.position.extentBefore;
        if (extentAfter < 500 || extentBefore > 300) {
          print("lload more");
          loadMoreData();
          return;
        }
        if (extentBefore <= 3.0) {
          reloadData();
        }
      });
    });
  }

  @override
  void dispose() {
    // Dispose of resources if needed
    _debounceTimer?.cancel();
    super.dispose();
  }
}
