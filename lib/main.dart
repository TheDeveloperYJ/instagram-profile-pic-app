import 'package:flutter/material.dart';
import 'package:instagram_profile_pic/result.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('GET INSTA PROFILE PIC'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                textInputAction: TextInputAction.search,
                controller: controller,
                autocorrect: false,
                validator: (String val) {
                  if (val.isEmpty) {
                    return 'Please enter a username';
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter the username'),
                onSaved: (value) => name = value,
              ),
              RaisedButton(
                  color: Colors.deepPurple[100],
                  child: Text('SUBMIT'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResultPage(name)));
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
