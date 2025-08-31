import 'package:flutter/material.dart'; // Importation des widgets Flutter
import 'package:activite5/widgets/drawer_widget.dart'; // Importation du widget Drawer personnalisé
import 'package:activite5/interface_redacteur/redacteur_interface.dart'; // Écran d'enregistrement d'un rédacteur
import 'package:activite5/screen/liste_redacteurs_screen.dart'; // Écran de liste des rédacteurs
//import 'package:google_fonts/google_fonts.dart'; // Optionnel : pour utiliser Google Fonts

// Point d'entrée de l'application
void main() => runApp(MonAppli());

// Widget racine de l'application
class MonAppli extends StatelessWidget {
  const MonAppli({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', // Route initiale
      routes: {
        '/': (context) => PageAccueil(), // Page d'accueil
        '/Enregistrer': (context) => RedacteurInterface(), // Formulaire d'enregistrement
        '/listeRedacteurs': (context) => const ListeRedacteursScreen(), // Liste des rédacteurs
      },
      title: 'Magazines', // Titre de l'application
      theme: ThemeData(
        primarySwatch: Colors.blue, // Couleur principale
        fontFamily: 'poppins', // Police personnalisée
      ),
      debugShowCheckedModeBanner: false, // Masquer le bandeau "debug"
    );
  }
}

// Page d'accueil de l'application
class PageAccueil extends StatelessWidget {
  const PageAccueil({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Magazines Infos',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Style du titre
        ),
        centerTitle: true, // Centrer le titre
        backgroundColor: Colors.pink, // Couleur de fond
        foregroundColor: Colors.white, // Couleur du texte et des icônes
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu), // Icône du menu
            color: Colors.white,
            onPressed: () => Scaffold.of(context).openDrawer(), // Ouvre le drawer
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))], // Icône de recherche
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/images/magazines.jpg'), // Image d'en-tête
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            PartieTitre(), // Titre de bienvenue
            PartieTexte(), // Texte descriptif
            PartieIcone(), // Section avec icônes
            PartieRubrique(), // Section avec images de rubriques
          ],
        ),
      ),
      //floatingActionButton:, // Optionnel : bouton flottant
      //bottomnavigationBar:, // Optionnel : barre de navigation en bas
      drawer: DrawerWidget(), // Menu latéral
    );
  }
}

// Section de titre de la page d'accueil
class PartieTitre extends StatelessWidget {
  const PartieTitre({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bienvenue au Magazines infos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Votre Magazine numérique, votre source d\'inspirations',
            style: TextStyle(
              fontSize: 16,
              color: const Color.fromARGB(172, 37, 37, 37), // Couleur grisée
            ),
          ),
        ],
      ),
    );
  }
}

// Section de texte explicatif
class PartieTexte extends StatelessWidget {
  const PartieTexte({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Text(
        'Magazines Infos est bien plus qu\'une simple magazine d\'informations. C\'est votre passerelle vers le monde, une source inestimable de connaissances et d\'actualités soigneusement selectionnés pour vous éclairer sur les enjeux mondiaux,la culture, la science, la et voir même le divertissement(les jeux). ',
      ),
    );
  }
}

// Section avec icônes de contact
class PartieIcone extends StatelessWidget {
  const PartieIcone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, // Répartition équitable
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(Icons.phone, size: 50, color: Colors.pink), // Icône téléphone
                SizedBox(height: 10),
                Text('TEL', style: TextStyle(fontSize: 16, color: Colors.pink)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(Icons.email, size: 50, color: Colors.pink), // Icône email
                SizedBox(height: 10),
                Text('EMAIL', style: TextStyle(fontSize: 16, color: Colors.pink)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(Icons.share, size: 50, color: Colors.pink), // Icône partage
                SizedBox(height: 10),
                Text('PARTAGE', style: TextStyle(fontSize: 16, color: Colors.pink)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Section avec images illustrant les rubriques
class PartieRubrique extends StatelessWidget {
  const PartieRubrique({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20), // Coins arrondis
            child: Image.asset(
              'assets/images/newspaper.png', // Image de presse
              width: 150,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/drinkingCups.jpg', // Image de détente
              width: 150,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
