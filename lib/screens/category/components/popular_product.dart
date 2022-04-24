import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/api/product.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/All.dart';
// import 'package:shop_app/models/Product.dart';

import '../../../size_config.dart';
import 'section_title.dart';

List<int> _data = [for (var i = 0; i < 200; i++) i];
Future<List<int>> _fetch(int count) {
  return Future.delayed(
    Duration(seconds: 2),
    () => _data.where((element) => element < count).toList(),
  );
}

class PopularProducts extends StatefulWidget {
  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  // @override
  // Widget build(BuildContext context) {
  // return Column(
  //   children: [
  //     GridView.count(
  //       shrinkWrap: true,
  //       physics: ScrollPhysics(),
  //       crossAxisCount: 2,
  //       children: List.generate(100, (index) {
  //         return Center(
  //           child: Text(
  //             'Item $index',
  //             style: Theme.of(context).textTheme.headline5,
  //           ),
  //         );
  //       }),
  //     ),
  //   ],
  // );

  // return FutureBuilder(
  //   future: _fetch(_count),
  //   builder: (BuildContext context, AsyncSnapshot<List<int>?> snapshot) {
  //     final data = snapshot.data;
  //     if (data == null) {
  //       return Center(child: CircularProgressIndicator());
  //     }

  //     return ScrollListener(
  //       threshold: 0.8,
  //       builder: (context, controller) {
  //         final listView = ListView.builder(
  //           // shrinkWrap: true,
  //           // physics: ScrollPhysics(),
  //           controller: controller,
  //           itemCount: data.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             return ListTile(title: Text("Item number - ${data[index]}"));
  //           },
  //         );

  //         return Stack(
  //           children: [
  //             listView,
  //             Opacity(
  //               opacity: data.length != _count ? 1 : 0,
  //               child: Center(child: CircularProgressIndicator()),
  //             ),
  //           ],
  //         );
  //       },
  //       loadNext: () {
  //         print('loadNext');
  //         if (data.length == _count && _count < _data.length) {
  //           setState(() {
  //             _count += 50;
  //           });
  //         }
  //       },
  //     );
  //   },
  // );
  // }

  // We will fetch data from this Rest api
  final _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  // At the beginning, we fetch the first 20 posts
  int _page = 0;
  int _limit = 20;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  // This holds the posts fetched from the server
  List _posts = [];

  // This function will be called when the app launches (see the initState function)
  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res =
          await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));
      setState(() {
        _posts = json.decode(res.body);
      });
    } catch (err) {
      print('Something went wrong');
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1
      try {
        final res =
            await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.length > 0) {
          setState(() {
            _posts.addAll(fetchedPosts);
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        print('Something went wrong!');
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  // The controller for the ListView
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = new ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirstLoadRunning)
      return Center(
        child: CircularProgressIndicator(),
      );
    else {
      return
      //  Column(
      //   children: [
          // Expanded(
          //   child: 
            ListView.builder(
              shrinkWrap: true,
              controller: _controller,
              itemCount: _posts.length,
              itemBuilder: (_, index) => Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: ListTile(
                  title: Text(_posts[index]['title']),
                  subtitle: Text(_posts[index]['body']),
                ),
              ),
            // ),
          );

          // when the _loadMore function is running
          // if (_isLoadMoreRunning == true)
          //   Padding(
          //     padding: const EdgeInsets.only(top: 10, bottom: 40),
          //     child: Center(
          //       child: CircularProgressIndicator(),
          //     ),
          //   ),

          // // When nothing else to load
          // if (_hasNextPage == false)
          //   Container(
          //     padding: const EdgeInsets.only(top: 30, bottom: 40),
          //     color: Colors.amber,
          //     child: Center(
          //       child: Text('You have fetched all of the content'),
          //     ),
          //   ),
      //   ],
      // );
    }
  }
}
