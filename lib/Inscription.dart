import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'MainPage.dart';
import 'auth.dart';
import 'package:intl/intl.dart';


class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  String? errorMessage = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _pseudoController = TextEditingController();
  final TextEditingController _dateNaissanceController =
      TextEditingController();

  Future<void> creerCompteWithEmailAndPassword() async {
  try {
    await Auth().creerCompteAvecInformationsSupplementaires(
      email: _emailController.text,
      password: _passwordController.text,
      pseudo: _pseudoController.text,
      dateNaissance: DateTime.parse(_dateNaissanceController.text),
    );
    // ignore: use_build_context_synchronously
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

Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );
  if (picked != null) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(picked); 
    setState(() {
      _dateNaissanceController.text = formattedDate; 
    });
  }
}

Widget _datePickerField(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: FractionallySizedBox(
      widthFactor: 0.7,
      child: InkWell(
        onTap: () => _selectDate(context), 
        child: InputDecorator(
          decoration: const InputDecoration(
            labelText: 'Date de Naissance',
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _dateNaissanceController.text,
              ),
              const Icon(Icons.calendar_today), 
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget _entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            labelText: title,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 30, top: 60),
              child: Image.asset(
                'assets/Logo_Footbest.png',
                height: 75,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Inscription',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _entryField('Pseudo', _pseudoController),
                _entryField('Adresse e-mail', _emailController),
                _entryField('Mot de passe', _passwordController,
                    isPassword: true),
                _datePickerField(context),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FractionallySizedBox(
                    widthFactor: 0.7,
                    child: ElevatedButton(
                      onPressed: creerCompteWithEmailAndPassword,
                      child: const Text('S\'inscrire'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: errorMessage != ''
                      ? Text(
                          errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        )
                      : Container(),
                ),
              ],
            ),
            const Divider(color: Colors.black), 
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  const Text(
                    'Déjà un compte ?',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 230,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Se connecter',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
