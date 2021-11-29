import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  _State createState() => _State();
}

class _State extends State<MyApp> {
  Future fetchData() async {
    final db = FirebaseFirestore.instance;
    db.collection("Countries").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DB'),
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, AsyncSnapshot snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (ctx, index) {
              DocumentSnapshot data = snapshot.data[index];
              return ListTile(
                title: Text(data['name']),
              );
            },
          );
        },
      ),
    );
  }
}
