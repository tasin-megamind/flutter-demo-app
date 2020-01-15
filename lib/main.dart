// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:developer';

void main() => runApp(MyApp());





class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
}






class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Startup Name Generator', _appBarActions()),
      body: _buildSuggestions(),
    );
  }



  List<Widget> _appBarActions() {

    final appBarActionList = <Widget>[];

    final Widget savedNamesIcon = IconButton(
      icon: Icon(Icons.list),
      onPressed: _pushSaved,
      key: Key('saved_suggestions_icon'),
    );


    appBarActionList.add(savedNamesIcon);

    return appBarActionList;

  }



  Widget appBar(String title, List<Widget> actions) {
    return AppBar(
      title: Text(title),
      actions: actions,
    );
  }


  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {

          int i = 0;

          final Iterable<ListTile> tiles = _saved.map(
              (WordPair pair) {
                i = i + 1;
                return ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                    key: Key('saved${i-1}')
                  )
                );
              }
          );
          final List<Widget> divided = ListTile.divideTiles(
              context: context,
              tiles: tiles,).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided, key: Key('savedList')),
          );
        }
      )
    );
  }





  Widget _buildSuggestions() {
    return ListView.builder(
        key: Key('suggested_list'),
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index], index);
        });
  }

  Widget _buildRow(WordPair pair, int index) {
    log('pair: $pair');
    final bool alreadySaved = _saved.contains(pair);
    var icon_ = Icon(
      alreadySaved ? Icons.favorite : Icons.favorite_border,
      color: alreadySaved ? Colors.red : null,
      key: Key('heart_index_$index'),
    );
    log(icon_.toDiagnosticsNode().getProperties().toString());
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
        key: Key('suggestion$index'),
      ),
      trailing: icon_,
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

}





class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}