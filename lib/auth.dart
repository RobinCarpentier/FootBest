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
  final age = DateTime.now().year - dateNaissance.year;

  if (age < 13) {
    throw FirebaseAuthException(
      code: 'age_restriction',
      message: 'Vous devez avoir au moins 13 ans pour vous inscrire.',
    );
  }
   final RegExp regex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*]).{8,}$');

  if (!regex.hasMatch(password)) {
    throw FirebaseAuthException(
      code: 'faible_password',
      message:
          'Le mot de passe doit contenir au moins une majuscule, un nombre, '
          'un caractère spécial et avoir au moins 8 caractères.',
    );
  }

  final pseudoSnapshot = await FirebaseFirestore.instance
      .collection('utilisateurs')
      .where('pseudo', isEqualTo: pseudo)
      .get();

  if (pseudoSnapshot.docs.isNotEmpty) {
    throw FirebaseAuthException(
      code: 'pseudo_pris',
      message: 'Le pseudo est déjà utilisé !',
    );
  }
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    
    String userId = userCredential.user!.uid;

    await FirebaseFirestore.instance.collection('utilisateurs').doc(userId).set({
      'pseudo': pseudo,
      'dateNaissance': dateNaissance,
      'description': '',
      'photoUrl': '',
      'amis': [],
      'club': [],
      'ligue': [],
    });

  } on FirebaseAuthException {
    rethrow;
  }
}
}