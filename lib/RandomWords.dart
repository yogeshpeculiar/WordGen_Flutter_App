import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() =>RandomWordsState();
}
class RandomWordsState extends State{
  final _randomWords=<WordPair>[];
  final _savedWordPairs=Set<WordPair>();
  Widget _buildListView(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder:(context,int index){
        if(index>=_randomWords.length){
          _randomWords.addAll(generateWordPairs().take(10));
        }
        return _buildListItem(_randomWords[index]);
      },

    );

  }
  Widget _buildListItem(WordPair pair){
    final alreadySaved=_savedWordPairs.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase,
        style: TextStyle(fontSize: 18.0)),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
                      color:alreadySaved ? Colors.red:null),
      onTap: (){
        setState(() {
          if(alreadySaved)
            _savedWordPairs.remove(pair);
          else
            _savedWordPairs.add(pair);
        });
      },
    );
  }
  void _pushWordPair(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context){
          final Iterable<ListTile> tiles=
              _savedWordPairs.map((WordPair pair){
                return ListTile(
                  title: Text(pair.asPascalCase,
                  style: TextStyle(fontSize: 16.0))
                );
              });
          final List<Widget> savedWords=ListTile.divideTiles(context:context,tiles: tiles ).toList();
          return Scaffold(
            appBar: AppBar(
                title: Text('Saved wordPairs')),
                body: ListView(children:savedWords)

          );
        }
      )
    );
  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('WordGen'),
        actions: <Widget>[
          IconButton(icon:Icon(Icons.list),
          onPressed: _pushWordPair,)
        ],
      ),
      body: _buildListView(),
    );
  }
}