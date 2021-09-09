import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_test/utils/api.dart';
import 'package:flutter_application_test/utils/theme.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {

  final _saved = <dynamic>{};
  final _biggerFont = const TextStyle(fontSize: 18);

  late Future<List<dynamic>> futureUsers;

  @override
  void initState() {
    super.initState();
    log('Getting/init users datas...');
    futureUsers = API.requestGET('https://jsonplaceholder.typicode.com/users', null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _showSavedList),
        ],
      ),
      body: _buildFutureList(),
    );
  }

  void _showSavedList(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (dynamic pair) {
              return ListTile(
                title: Text(
                  pair['name'],
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }, // ...to here.
      ),
    );
  }

  Widget _buildFutureList(){
    return FutureBuilder(
      future: futureUsers,
      builder: (context, AsyncSnapshot snapshot){
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          //print('length = ${snapshot.data.length}');
          return RefreshIndicator(
            onRefresh: _onScrollRefresh,
            child: ListView.separated(
              itemCount: snapshot.data.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return _buildRow(snapshot.data[index]);
              },
              separatorBuilder: (context, index) {
                return ThemeBuilder.getDivider();
              },
            )
          );
        }
      });
  }

  Future<void> _onScrollRefresh() async{
    setState(() {
      log('Clearing users datas...');
      futureUsers = Future.value(<dynamic>[]);
      _saved.clear();
    });
    List<dynamic> results = await API.requestGET('https://jsonplaceholder.typicode.com/users', null);
    //delayed
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      log('Refreshing users datas...');
      futureUsers = Future.value(results);
    });
  }

  Widget _buildRow(dynamic pair) {
    final alreadySaved = _saved.contains(pair);
    //log('pair : ' + pair.toString());
    return ListTile(
      title: Text(
        pair['name'],
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
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