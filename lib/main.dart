import 'package:flutter/material.dart';
import 'package:footbest/createAccount.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart'; 
import 'auth.dart'; 
import 'MainPage.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}); 
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? erreurMsg = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> loginWithEmailAndPassword() async {
    try {
      await Auth().connexionWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      // Redirection vers MainPage.dart après la connexion réussie
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

  Future<void> creerCompteWithEmailAndPassword() async {
    try {
      await Auth().creerCompteWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
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

  Widget _entryField(
    String title,
    TextEditingController controller,
    {bool isPassword = false}
  ) {
    return TextField(
      controller: controller,
      obscureText: isPassword, // Masquer le texte si isPassword est vrai
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _erreurMsg() {
    return Text(erreurMsg == '' ? '' : 'Erreur ? $erreurMsg');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: isLogin ? loginWithEmailAndPassword : creerCompteWithEmailAndPassword,
      child: Text(isLogin ? 'Connexion' : 'Inscription'),
    );
  }

  Widget _loginOuInscriptionButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Page Inscription' : 'Page Connexion'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 30), // Décalage horizontal de 20 pixels
              child: Image.asset(
                'assets/Logo_Footbest.png',
                height: 75, // Ajustez la hauteur
              ),
            ),
            const SizedBox(height: 50), // Ajouter de l'espace
            Text(
              'Connexion',
              style: Theme.of(context).textTheme.headline6, // Utilisez headline6 pour un style de texte plus grand
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: FractionallySizedBox(
                widthFactor: 0.7, // Définir la largeur souhaitée
                child: _entryField('Adresse Mail', _controllerEmail),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: FractionallySizedBox(
                widthFactor: 0.7, // Définir la largeur souhaitée
                child: _entryField('Mot de passe', _controllerPassword, isPassword: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FractionallySizedBox(
                widthFactor: 0.7, // Définir la largeur souhaitée
                child: _submitButton(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FractionallySizedBox(
                widthFactor: 0.7, // Définir la largeur souhaitée
                child: _erreurMsg(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0), // Espace vertical avant la ligne
              child: SizedBox(
                child: Divider(
                  color: Colors.black, // Couleur de la ligne
                  thickness: 1.0, // Épaisseur de la ligne (ajustez selon vos besoins)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FractionallySizedBox(
                widthFactor: 0.7, // Définir la largeur souhaitée
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => InscriptionPage()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("S'inscrire "),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
