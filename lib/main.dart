import 'package:flutter/material.dart';

void main() => runApp(MonAppli());

class MonAppli extends StatelessWidget {
  const MonAppli({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magazines',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: PageAccueil(),
    );
  }
}

class PageAccueil extends StatelessWidget {
  const PageAccueil({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Magazines Infos',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/images/magazines.jpg'),
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            PartieTitre(),
            PartieTexte(),
            PartieIcone(),
            PartieRubrique(),
          ],
        ),
      ),
      //floatingActionButton:,
      //bottomnavigationBar:,
    );
  }
}

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
            style: TextStyle(fontSize: 16, color: const Color.fromARGB(172, 37, 37, 37)),
          ),
        ],
      ),
    );
  }
}

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

class PartieIcone extends StatelessWidget {
  const PartieIcone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(Icons.phone, size: 50, color: Colors.pink),
                SizedBox(height: 10),
                Text('TEL', style: TextStyle(fontSize: 16, color: Colors.pink)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(Icons.email, size: 50, color: Colors.pink),
                SizedBox(height: 10),
                Text(
                  'EMAIL',
                  style: TextStyle(fontSize: 16, color: Colors.pink),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(Icons.share, size: 50, color: Colors.pink),
                SizedBox(height: 10),
                Text(
                  'PARTAGE',
                  style: TextStyle(fontSize: 16, color: Colors.pink),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/newspaper.png',
              width: 150,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/drinkingCups.jpg',
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
