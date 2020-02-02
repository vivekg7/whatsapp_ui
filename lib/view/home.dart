import 'package:flutter/material.dart';
import 'package:whatsapp_ui/view/calls_page.dart';
import 'package:whatsapp_ui/view/chats_page.dart';
import 'package:whatsapp_ui/view/status_page.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  final _tabs = <Widget> [
    Tab(icon: Icon(Icons.camera_alt),),
    Tab(child: Text("CHATS"),),
    Tab(child: Text("STATUS"),),
    Tab(child: Text("CALLS"),)
  ];

  _openCamera() {return Text("Open Camera, Ask Camera Permissions");}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WhatsApp"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
        bottom: TabBar(tabs: _tabs),
      ),
      body: TabBarView(
        children: <Widget>[
          _openCamera(),
          ChatPage(),
          StatusPage(),
          CallsPage(),
        ],
      ),
    );
  }

}

//Navigator.push(context, MaterialPageRoute(builder: (context) => newPage));
//Navigator.of(context).pop();