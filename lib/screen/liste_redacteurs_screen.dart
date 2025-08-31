import 'package:flutter/material.dart'; // Pour les widgets Flutter
import '../Modele/redacteur.dart'; // Ton modèle Redacteur (ajuste le chemin si nécessaire)
import '../database/database_manager.dart'; // Ton gestionnaire de base de données

class ListeRedacteursScreen extends StatefulWidget {
  const ListeRedacteursScreen({super.key});

  @override
  State<ListeRedacteursScreen> createState() => _ListeRedacteursScreenState();
}

class _ListeRedacteursScreenState extends State<ListeRedacteursScreen> {
  List<Redacteur> _redacteurs = [];

  @override
  void initState() {
    super.initState();
    _chargerRedacteurs();
  }

  Future<void> _chargerRedacteurs() async {
    final liste = await DatabaseManager.instance.getAllRedacteurs();
    if (mounted) {
      setState(() => _redacteurs = liste);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des Rédacteurs"),
        backgroundColor: Colors.pink,
      ),
      body: _redacteurs.isEmpty
          ? const Center(child: Text("Aucun rédacteur inscrit."))
          : ListView.builder(
              itemCount: _redacteurs.length,
              itemBuilder: (context, index) {
                final r = _redacteurs[index];
                return ListTile(
                  title: Text("${r.nom} ${r.prenom}"),
                  subtitle: Text(r.email),
                );
              },
            ),
    );
  }
}
