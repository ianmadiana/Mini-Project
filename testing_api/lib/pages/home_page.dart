import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing_api/model/news.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final List<Article> _list = [];

  Future _getData() async {
    var response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=113087ce7372432dbc8cf0f73161755f'));

    List<dynamic> data =
        (jsonDecode(response.body) as Map<String, dynamic>)['articles'];

    for (var element in data) {
      _list.add(Article.fromJson(element));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News API'),
      ),
      body: FutureBuilder(
          future: _getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  var x = _list[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          child: x.urlToImage != null
                              ? Image.network(
                                  x.urlToImage.toString(),
                                  fit: BoxFit.fill,
                                )
                              : Image.asset('assets/no-image.png'),
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5),
                              width: 250,
                              child: Text(x.title),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
