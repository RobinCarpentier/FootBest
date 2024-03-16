import 'package:flutter/material.dart';
import 'package:footbest/Inscription.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';
import 'MainPage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FootBest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home Page FootBest'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerPseudo = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();

  Future<void> loginWithEmailAndPassword() async {
    try {
      await Auth().connexionWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> signUpWithEmailAndPassword() async {
    try {
      await Auth().creerCompteAvecInformationsSupplementaires(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
        pseudo: _controllerPseudo.text,
        dateNaissance: DateTime.parse(_controllerDate.text),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Error: $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
          isLogin ? loginWithEmailAndPassword : signUpWithEmailAndPassword,
      child: Text(isLogin ? 'Connexion' : 'Inscription'),
    );
  }

  Widget _loginOrSignUpButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Inscription' : 'Connexion'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Image.asset(
                  'assets/Logo_Footbest.png',
                  height: 75,
                ),
              ),
              const SizedBox(height: 50),
              Text(
                'Connexion',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  child: _entryField('Email', _controllerEmail),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  child: _entryField('Mot de passe', _controllerPassword,
                      isPassword: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  child: _submitButton(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  child: _errorMessage(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: SizedBox(
                  child: Divider(
                    color: Colors.black,
                    thickness: 1.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  child: Column(
                    children: [
                      const Text(
                        "Pas encore de compte ?",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                          height: 8),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const InscriptionPage()),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Inscription "),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
