import 'package:flutter/material.dart';
import 'package:activite5/Modele/redacteur.dart';
import '../database/database_manager.dart';

class RedacteurInterface extends StatefulWidget {
  const RedacteurInterface({super.key});

  @override
  State<RedacteurInterface> createState() => _RedacteurInterfaceState();
}

class _RedacteurInterfaceState extends State<RedacteurInterface> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  List<Redacteur> _redacteurs = [];

  @override
  void initState() {
    super.initState();
    _loadRedacteurs();
  }

  Future<void> _loadRedacteurs() async {
    final redacteurs = await DatabaseManager.instance.getAllRedacteurs();
    if (mounted) {
      setState(() {
        _redacteurs = redacteurs;
      });
    }
  }

  bool _validerChamps({
    required String nom,
    required String prenom,
    required String email,
  }) {
    if (nom.trim().isEmpty || prenom.trim().isEmpty || email.trim().isEmpty) {
      _afficherMessage("Tous les champs sont obligatoires.");
      return false;
    }

    final emailRegex = RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$");
    if (!emailRegex.hasMatch(email.trim())) {
      _afficherMessage("Adresse email invalide.");
      return false;
    }

    return true;
  }

  void _afficherMessage(String message, {Color color = Colors.red}) {
    if (!mounted) return;
    final localContext = context;
    ScaffoldMessenger.of(
      localContext,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  Future<void> _ajouterRedacteur() async {
    final nom = _nomController.text.trim();
    final prenom = _prenomController.text.trim();
    final email = _emailController.text.trim();

    if (!_validerChamps(nom: nom, prenom: prenom, email: email)) return;

    final redacteur = Redacteur.withoutId(
      nom: nom,
      prenom: prenom,
      email: email,
    );
    await DatabaseManager.instance.insertRedacteur(redacteur);

    if (mounted) {
      _nomController.clear();
      _prenomController.clear();
      _emailController.clear();
      _loadRedacteurs();
      _afficherMessage("Rédacteur ajouté avec succès.", color: Colors.green);
    }
  }

  void _modifierRedacteur(Redacteur redacteur) {
    final nomCtrl = TextEditingController(text: redacteur.nom);
    final prenomCtrl = TextEditingController(text: redacteur.prenom);
    final emailCtrl = TextEditingController(text: redacteur.email);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Modifier le rédacteur"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nomCtrl,
              decoration: const InputDecoration(labelText: "Nom"),
            ),
            TextField(
              controller: prenomCtrl,
              decoration: const InputDecoration(labelText: "Prénom"),
            ),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: "Email"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () async {
              final nom = nomCtrl.text.trim();
              final prenom = prenomCtrl.text.trim();
              final email = emailCtrl.text.trim();

              if (!_validerChamps(nom: nom, prenom: prenom, email: email)) {
                return;
              }

              final modifie = redacteur.copyWith(
                nom: nom,
                prenom: prenom,
                email: email,
              );
              await DatabaseManager.instance.updateRedacteur(modifie);

              if (mounted) {
                // ignore: use_build_context_synchronously
                Navigator.pop(ctx);
                _loadRedacteurs();
                _afficherMessage(
                  "Rédacteur modifié avec succès.",
                  color: Colors.green,
                );
              }
            },
            child: const Text("Enregistrer"),
          ),
        ],
      ),
    );
  }

  void _confirmerSuppression(Redacteur redacteur) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Supprimer le rédacteur"),
        content: Text(
          "Voulez-vous vraiment supprimer ${redacteur.nom} ${redacteur.prenom} ?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (redacteur.id != null) {
                await DatabaseManager.instance.deleteRedacteur(redacteur.id!);
              }
              if (mounted) {
                // ignore: use_build_context_synchronously
                Navigator.pop(ctx);
                _loadRedacteurs();
                _afficherMessage("Rédacteur supprimé.", color: Colors.green);
              }
            },
            child: const Text("Supprimer"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion des Rédacteurs"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.pink,
      ),
      body: GestureDetector(
        onTap: () =>
            FocusScope.of(context).unfocus(), // Ferme le clavier au tap
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: 'Nom'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _prenomController,
                decoration: const InputDecoration(labelText: 'Prénom'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  onPressed: _ajouterRedacteur,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Ajouter un Rédacteur",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                icon: const Icon(Icons.list),
                label: const Text("Voir les rédacteurs"),
                onPressed: () =>
                    Navigator.pushNamed(context, '/listeRedacteurs'),
              ),
              const SizedBox(height: 15),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _redacteurs.length,
                itemBuilder: (context, index) {
                  final r = _redacteurs[index];
                  return ListTile(
                    title: Text("${r.nom} ${r.prenom}"),
                    subtitle: Text(r.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _modifierRedacteur(r),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _confirmerSuppression(r),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
