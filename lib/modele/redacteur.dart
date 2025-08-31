// Définition de la classe Redacteur représentant un rédacteur dans l'application
class Redacteur {
  // Identifiant unique du rédacteur (nullable car non requis à la création)
  int? id;

  // Nom, prénom et email du rédacteur
  String nom;
  String prenom;
  String email;

  // Constructeur principal avec tous les champs, y compris l'id optionnel
  Redacteur({
    this.id,
    required this.nom,
    required this.prenom,
    required this.email,
  });

  // Méthode utilitaire permettant de créer une copie du rédacteur
  // avec des champs modifiés si nécessaire
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

  // Constructeur alternatif sans id, utile pour l'insertion en base
  Redacteur.withoutId({
    required this.nom,
    required this.prenom,
    required this.email,
  });

  // Méthode pour convertir un objet Redacteur en Map (clé-valeur)
  // utilisée pour l'insertion ou la mise à jour en base de données
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'nom': nom,
      'prenom': prenom,
      'email': email,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Factory constructor pour créer un objet Redacteur à partir d'une Map
  // utilisée lors de la lecture depuis la base de données
  factory Redacteur.fromMap(Map<String, dynamic> map) {
    return Redacteur(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
    );
  }
}
