import 'package:flutter/material.dart';
import 'package:footbest/createAccount.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Colors.white,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
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
              height: 75, // Ajustez la hauteur
            ),
            const SizedBox(height: 50), // Ajouter de l'espace
            Text(
              'Connexion',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const Padding(
            padding: EdgeInsets.all(16.0),
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
            padding: EdgeInsets.all(16.0),
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
                    Text('Se connecter '),
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
                    MaterialPageRoute(builder: (context) => createAccount()),
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
