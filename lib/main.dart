import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RandomWords(),
      theme: ThemeData(primaryColor: Colors.deepPurple[800]),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randomWordPairs = <WordPair>[];

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, item) {
          if (item.isOdd) return Divider();

          final index = item ~/ 2;

          if(index >= _randomWordPairs.length){
            _randomWordPairs.addAll(generateWordPairs().take(10))
          }

          return _buildRow(_randomWordPairs[index]);
        },
        // children: <Widget>[
        //   Container(
        //     height: 75,
        //     color: Colors.amber[700],
        //     child: const Center(child: Text('Campaign 1')),
        //   ),
        //   Container(
        //     height: 75,
        //     color: Colors.amber[400],
        //     child: const Center(child: Text('Campaign 2')),
        //   ),
        //   Container(
        //     height: 75,
        //     color: Colors.amber[200],
        //     child: const Center(child: Text('Campaign 3')),
        //   ),
        // ],
        );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insight'),
      ),
      body: _buildList(),
    );
  }
}
