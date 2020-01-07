import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class welcome extends StatefulWidget {
  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  Future<List<User>> _getUser() async {
    var data = await http.get("https://jsonplaceholder.typicode.com/comments");

    var jsondata = jsonDecode(data.body);
    List<User> users = [];

    for (var v in jsondata) {
      User user = User(v["postId"], v["id"], v["name"], v["email"], v["body"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JSONAPP"),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: new CircularProgressIndicator(backgroundColor: Colors.green,),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 25,
                      // backgroundImage: NetworkImage(
                      //snapshot.data[index].postId,

                      //),
                    ),
                    title: Text(snapshot.data[index].name),
                    subtitle: Text(snapshot.data[index].email),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class User {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  User(this.postId, this.id, this.name, this.email, this.body);
}
