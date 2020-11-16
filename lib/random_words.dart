import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

//All of Flutter is basically just small widgets working together
//This one is State Dependet (StatefulWidget)
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

//The State
class RandomWordsState extends State<RandomWords> {
  //The list of all the wordPairs created procedurally by english_words package
  final _randomWordPairs = <WordPair>[];
  //List of 'saved' pairs by clicking on them (see onTap below)
  final _savedWordPairs = <WordPair>[];

  //
  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, item) {
        if (item.isOdd) return Divider();

        final index = item ~/ 2;

        if (index >= _randomWordPairs.length) {
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_randomWordPairs[index]);
      },
    );
  }

  Widget _buildRow(WordPair wordPair) {
    final alreadySaved = _savedWordPairs.contains(wordPair);
    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        style: TextStyle(fontSize: 18.0),
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedWordPairs.remove(wordPair);
          } else {
            _savedWordPairs.add(wordPair);
          }
        });
      },
    );
  }

  //Functionality for top right list button to see favorited pairs
  void _pushSaved() {
    //Navigator is used to push on new pages and pop them off when user returns
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      //Use all pairs in _savedWordPairs and return a ListTile for each!!!
      final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
        return ListTile(
            title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16.0)));
      });

      //Take the 'tiles' variable from above and run it through 'toList'
      // This is just to take it from an interable into a List of widgets
      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      //The finalized Scaffolding of the button being pressed.
      return Scaffold(
          appBar: AppBar(title: Text('Fav Campaigns')),
          body: ListView(
            //Take that list and return it in the body
            children: divided,
          ));
    }));
  }

  //Actually the most senior Widget. Scaffold is a basic material based layout
  //notice the body is set to _bodyList
  // the _ means its privatized i think???
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insight'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          )
        ],
      ),
      body: _buildList(),
    );
  }
}
