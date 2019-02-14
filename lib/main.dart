import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main()
=> runApp(MyApp());

class MyApp extends StatelessWidget
{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: RandomWords()
    );
  }
}

class RandomWordsState extends State<RandomWords>
{
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>();

  Widget _buildSuggestions()
  {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) //i is line number
        {
          if (i.isOdd) return Divider();
          final index = i ~/ 2; //calculates line numbers minus dividers
          if (index >= _suggestions
              .length) // if line number (minus dividers) is more than our words generated
          {
            _suggestions.addAll(
                generateWordPairs().take(10)); // add 10 more words
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair)
  {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase, style: _biggerFont,),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: ()
      {
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

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
}

class RandomWords extends StatefulWidget
{
  @override
  RandomWordsState createState()
  => new RandomWordsState();
}
