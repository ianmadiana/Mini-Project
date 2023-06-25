import 'dart:convert';

import 'package:book_times/model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detail_book.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Book> _list = [];

  Future getBooks() async {
    var response = await http.get(Uri.parse(
        'https://api.nytimes.com/svc/books/v3/lists/current/hardcover-fiction.json?api-key=ZNaUkPnTc6FqAUswO3aRmcqPrTJAgseG'));

    List<dynamic> data =
        (jsonDecode(response.body) as Map<String, dynamic>)['results']['books'];

    for (var element in data) {
      _list.add(Book.fromJson(element));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BookTimes'),
        ),
        body: FutureBuilder(
          future: getBooks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Tampilkan widget jika koneksi sedang menunggu
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              // Tampilkan widget jika koneksi selesai
              if (snapshot.hasError) {
                // Tampilkan widget jika terjadi error saat mengambil data
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                // Tampilkan widget jika tidak ada error dan data berhasil diambil
                return ListView.builder(
                  itemCount: _list.length,
                  itemBuilder: (context, index) {
                    var x = _list[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailBook(
                              title: x.title,
                              imagePoster: x.bookImage,
                              desc: x.description,
                              author: x.author,
                              publisher: x.publisher,
                              rank: x.rank.toString(),
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Image.network(x.bookImage),
                        title: Text(x.title),
                        subtitle: Text(x.author),
                      ),
                    );
                  },
                );
              }
            } else {
              // Kondisi lainnya seperti ConnectionState.active dan ConnectionState.none
              // Tampilkan widget yang sesuai dengan kebutuhan Anda
              return Text('Connection State: ${snapshot.connectionState}');
            }
          },
        ));
  }
}
