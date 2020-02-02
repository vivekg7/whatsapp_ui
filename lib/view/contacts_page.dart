import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:whatsapp_ui/util/colors.dart';
import 'package:whatsapp_ui/util/permissions.dart';

class InvitePage extends StatefulWidget {
  @override
  _InvitePageState createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  Iterable<Contact> _contacts;
  bool granted = false;

  @override
  void initState() {
    Permissions().checkAndGetPermissions(camera: true).then((val) {
      granted = val;
      if (granted) _fetchdata();
    });
    super.initState();
  }

  _fetchdata() async {
    // Uncomment to get Contacts with Thumbnails also
    //_contacts = await ContactsService.getContacts();
    // Faster to load without thumbnails
    _contacts = await ContactsService.getContacts(withThumbnails: false);
    setState(() {});
    return true;
  }

  Widget _buildItem(Contact contact) {
    //if (contact.androidAccountName != "WhatsApp") return Container();
    return ListTile(
      contentPadding: EdgeInsets.all(10.0),
      leading: contact.avatar.length == 0 ? Icon(Icons.contacts) : Image.memory(contact.avatar),
      title: Text(contact.displayName),
      onTap: () {
        print("Tapped on Contact: " + contact.displayName);
      },
    );
  }

  Widget _buildContacts() {
    if (!granted) return Center(child: Text("Contacts Access Denied"),);
    if (_contacts == null) return Center(child: Text("Something Wrong"),);
    if (_contacts.length < 1) return Center(child: Text("No Contacts Found"),);
    return ListView.builder(
      itemCount: _contacts.length,
      itemBuilder: (context, index) => _buildItem(_contacts.elementAt(index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtil().themeDark,
        centerTitle: true,
        title: Text('Select Contacts'),
        bottom: PreferredSize(
          preferredSize: Size(20, 100),
          child: Text(_contacts.length.toString() + " contacts"),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print("Asked to Search");
            },
          ),
          PopupMenuButton(
            onSelected: (String val) {
              print("You asked for: " + val);
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>> [
              const PopupMenuItem(
                value: "invite",
                child: Text("Invite a friend"),
              ),
              const PopupMenuItem(
                value: "contacts",
                child: Text("Contacts"),
              ),
              const PopupMenuItem(
                value: "refresh",
                child: Text("Refresh"),
              ),
              const PopupMenuItem(
                value: "help",
                child: Text("Help"),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return _fetchdata();
        },
        child: _buildContacts(),
      ),
    );
  }

}
