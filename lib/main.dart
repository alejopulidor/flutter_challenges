import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Pages
import 'boats/boats_main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatelessWidget {
  onButtonTap(BuildContext context, Widget page) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Flutter Challenges"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            MenuItem(
              "Boats",
              icon: Icons.anchor,
              onTap: () => onButtonTap(context, BoatsMain()),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onTap;
  const MenuItem(this.text, {Key key, this.icon, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          leading: Icon(icon, color: Colors.deepPurpleAccent),
          trailing: Icon(Icons.arrow_forward_ios_rounded,
              color: Colors.deepPurpleAccent),
          onTap: onTap,
        ),
        Divider(
          indent: 15,
          endIndent: 15,
          thickness: 1.0,
          height: 0.0,
          color: Colors.black.withOpacity(0.1),
        )
      ],
    );
  }
}
