import 'package:flutter/material.dart';
import 'package:footbest/main.dart';

class createAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/Logo_Footbest.png',
              width: 100, // Ajustez la largeur selon vos besoins
              height: 100, // Ajustez la hauteur selon vos besoins
            ),
            Text(
              'Inscription',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const Padding(
            padding: EdgeInsets.all(8.0),
            child: FractionallySizedBox(
              widthFactor: 0.7, // Définir la largeur souhaitée
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Pseudonyme',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            ),
            const Padding(
            padding: EdgeInsets.all(8.0),
            child: FractionallySizedBox(
              widthFactor: 0.7, // Définir la largeur souhaitée
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Adresse mail',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
            ),
            const Padding(
            padding: EdgeInsets.all(8.0),
            child: FractionallySizedBox(
              widthFactor: 0.7, // Définir la largeur souhaitée
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
            ),
            ),
            const Padding(
            padding: EdgeInsets.all(8.0),
            child: FractionallySizedBox(
              widthFactor: 0.7, // Définir la largeur souhaitée
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Confirmer Mot de passe',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
            ),
            ),
            Padding(
            padding: const EdgeInsets.all(16.0),
            child: FractionallySizedBox(
              widthFactor: 0.7, // Définir la largeur souhaitée
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Créer un compte '),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
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
                    MaterialPageRoute(builder: (context) => const MyApp()),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Se connecter "),
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