import 'package:flutter/material.dart';

class DetailBook extends StatelessWidget {
  DetailBook({
    Key? key,
    required this.imagePoster,
    required this.desc,
    required this.title,
    required this.author,
    required this.publisher,
    required this.rank,
  }) : super(key: key);

  String imagePoster;
  String title;
  String desc;
  String author;
  String publisher;
  String rank;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                child: Image.network(imagePoster),
              ),
              const SizedBox(height: 20),
              Text(desc),
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text('Rank'),
                      SizedBox(
                        height: 40,
                        child: Image.asset('assets/rank.png'),
                      ),
                      Text(rank)
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Author'),
                      SizedBox(
                        height: 40,
                        child: Image.asset('assets/writer.png'),
                      ),
                      Text(author)
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Publisher'),
                      SizedBox(
                        height: 40,
                        child: Image.asset('assets/publishing.png'),
                      ),
                      Text(publisher)
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
