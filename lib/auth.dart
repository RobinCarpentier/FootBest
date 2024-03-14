import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Auth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> connexionWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> creerCompteAvecInformationsSupplementaires({
  required String email,
  required String password,
  required String pseudo,
  required DateTime dateNaissance,
}) async {
  // Calcul de l'âge de l'utilisateur
  final age = DateTime.now().year - dateNaissance.year;

  // Vérification si l'utilisateur a au moins 13 ans
  if (age < 13) {
    throw FirebaseAuthException(
      code: 'age_restriction',
      message: 'Vous devez avoir au moins 13 ans pour vous inscrire.',
    );
  }
  try {
    // Création du compte utilisateur avec Firebase Auth
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    
    // Récupération de l'identifiant utilisateur
    String userId = userCredential.user!.uid;

    // Stockage des informations supplémentaires dans Firestore
    await FirebaseFirestore.instance.collection('utilisateurs').doc(userId).set({
      'pseudo': pseudo,
      'dateNaissance': dateNaissance,
    });
    
    // Enregistrement des informations supplémentaires localement si nécessaire

  } on FirebaseAuthException {
    rethrow;
  }
}
}