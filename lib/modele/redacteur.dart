/*import 'package:flutter/material.dart';
import 'package:activite4/interface_redacteur/redacteur_interface.dart';

class RedacteurWidget extends StatelessWidget {
  const RedacteurWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GESTIONNAIRE',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.pinkAccent,
          foregroundColor: Colors.white,
          title: Text('Gestion des Redacteurs'),
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(Icons.menu),
            ),
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        ),
        body: RedacteurInterface(),
      ),
    );
  }
}*/

class Redacteur {
  int? id;
  String nom;
  String prenom;
  String email;

  Redacteur({
    this.id,
    required this.nom,
    required this.prenom,
    required this.email,
  });
   // Méthode copyWith
  Redacteur copyWith({
    int? id,
    String? nom,
    String? prenom,
    String? email,
  }) {
    return Redacteur(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      email: email ?? this.email,
    );
  }

  // Constructeur sans id
  Redacteur.withoutId({
    required this.nom,
    required this.prenom,
    required this.email,
  });

  // Conversion en Map
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'nom': nom, 'prenom': prenom, 'email': email};
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Conversion depuis Map
  factory Redacteur.fromMap(Map<String, dynamic> map) {
    return Redacteur(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
    );
  }
}
