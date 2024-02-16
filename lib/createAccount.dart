import 'package:flutter/material.dart';
import 'MainPage.dart';
import 'auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InscriptionPage extends StatefulWidget {
  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  String? erreurMsg = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Méthode pour créer un compte et rediriger vers la page principale
    Future<void> creerCompteWithEmailAndPassword() async {
    try {
      await Auth().creerCompteWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      // Redirection vers MainPage.dart après la création de compte réussie
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()), // Redirection vers MainPage.dart
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        erreurMsg = e.message;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Adresse e-mail',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: creerCompteWithEmailAndPassword,
              child: Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}
