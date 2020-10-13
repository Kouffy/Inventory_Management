import 'package:flutter/material.dart';
import 'package:inventory_management/Core/Helpers/SessionManager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inventory_management/Ui/Navigation.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String nomuser;
  getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SessionManager.isUserLoggedIn().then((isLogged) {
      if (isLogged) {
        if (this.mounted) {
          setState(() {
            nomuser = prefs.getString('nom');
            nomuser += " ";
            nomuser += prefs.getString('prenom');
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getPreferences();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.exit_to_app,
              text: 'Deconnection',
              onTap: () => Navigation.logout(context)),
          ListTile(
            title: Text('0.0.1'),
            subtitle: Text('copyrights : el mouktafi mohamed 2020'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/DrawerHeader.jpeg'))),
      accountName: new Text(nomuser),
      accountEmail: new Text(
        "Administrateur du system",
        style: new TextStyle(fontSize: 13.0),
      ),
      currentAccountPicture: CircleAvatar(
          radius: 30.0, backgroundImage: AssetImage('assets/images/user.png')),
      onDetailsPressed: () {},
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
