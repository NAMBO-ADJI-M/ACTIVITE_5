//import 'package:activite5/modele/redacteur.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.pink),
            child: Center(child: Text('')),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Paramètres'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('S\'enregister'),
            onTap: () {
              Navigator.pushNamed(context, '/Enregistrer');
            },
          ),

          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Déconnexion'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
