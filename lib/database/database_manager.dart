// Importation du package sqflite pour la gestion de base de données SQLite
import 'package:sqflite/sqflite.dart';
// Importation du package path pour manipuler les chemins de fichiers
import 'package:path/path.dart';
// Importation du modèle Redacteur
import '../Modele/redacteur.dart';

// Classe pour gérer la base de données
class DatabaseManager {
  // Instance unique de DatabaseManager
  static final DatabaseManager instance = DatabaseManager._init();

  // Référence à la base de données SQLite
  static Database? _database;

  // Constructeur privé pour empêcher l’instanciation multiple
  DatabaseManager._init();

  // Getter asynchrone pour accéder à la base de données
  Future<Database> get database async {
    // Si la base est déjà initialisée, on la retourne
    if (_database != null) return _database!;
    // Sinon, on l'initialise
    _database = await _initDB('redacteurs.db');
    return _database!;
  }

  // Initialise la base de données avec le nom de fichier donné
  Future<Database> _initDB(String filePath) async {
    // Récupère le chemin du dossier des bases de données
    final dbPath = await getDatabasesPath();
    // Concatène le chemin avec le nom du fichier
    final path = join(dbPath, filePath);

    // Ouvre la base de données et exécute _createDB si elle n'existe pas
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Crée la table 'redacteurs' lors de la première ouverture
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE redacteurs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT,
        prenom TEXT,
        email TEXT
      )
    ''');
  }

  // Insère un nouvel objet Redacteur dans la table
  Future<int> insertRedacteur(Redacteur redacteur) async {
    final db = await instance.database;
    // Convertit l'objet en map et l'insère dans la table
    return await db.insert('redacteurs', redacteur.toMap());
  }

  // Récupère tous les rédacteurs depuis la base
  Future<List<Redacteur>> getAllRedacteurs() async {
    final db = await instance.database;
    // Exécute une requête SELECT * sur la table
    final result = await db.query('redacteurs');
    // Convertit chaque map en objet Redacteur
    return result.map((map) => Redacteur.fromMap(map)).toList();
  }

  // Met à jour un rédacteur existant dans la base
  Future<int> updateRedacteur(Redacteur redacteur) async {
    final db = await instance.database;
    // Met à jour la ligne correspondant à l'id du rédacteur
    return await db.update(
      'redacteurs',
      redacteur.toMap(),
      where: 'id = ?',
      whereArgs: [redacteur.id],
    );
  }

  // Supprime un rédacteur par son id
  Future<int> deleteRedacteur(int id) async {
    final db = await instance.database;
    // Exécute une requête DELETE sur la ligne ciblée
    return await db.delete('redacteurs', where: 'id = ?', whereArgs: [id]);
  }
}
