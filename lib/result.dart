import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:zoomable_image/zoomable_image.dart';

class ResultPage extends StatelessWidget {
  final String name;

  ResultPage(this.name);

  Future<String> getProfilePic(String name) async {
    final req =
        await http.post('https://instadp.net', body: {"username": name});
    final res = parse(req.body);
    final data =
        res.getElementsByClassName('img-responsive')[0].attributes['src'];

    return data.toString();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YOUR PIC'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder(
        future: getProfilePic(name),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data.toString().isEmpty){
              return Center(child: Text('Invalid username '),);
            }
            return Center(
              child: Container(
                child: ZoomableImage(NetworkImage(snapshot.data),
                    backgroundColor: Colors.white,
                    placeholder: Text('Getting image')),
              ),
            );
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text('Invalid username'),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
