import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  _MainPageState createState() => _MainPageState();
}

class Settings extends StatelessWidget {
  const Settings({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Paramètres'),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Profil'),
    );
  }
}

class Matches extends StatelessWidget {
  const Matches({super.key});
  @override
  Widget build(BuildContext context) {
    CollectionReference match = FirebaseFirestore.instance.collection('match');

    return Container(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children:[
              const SizedBox(height: 20),
              ExpansionTile(
              title: const Text(
                'Ligue 1',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),

              children: <Widget>[
              Card(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: StreamBuilder<QuerySnapshot>(
                stream: match.where('Compet', isEqualTo: 'Ligue 1').orderBy('Date', descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print("Error: ${snapshot.error}");
                    return const Text("Something went wrong");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Affichez un indicateur de chargement pendant le chargement
                  }

                  if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    return const Text("No matches available");
                  }

                  return ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      
                      // Compter le nombre de buts pour l'équipe A
                      Future<int> countGoalsTeamA() async {
                        QuerySnapshot querySnapshot = await match.doc(document.id)
                            .collection('but')
                            .where('Equipe', isEqualTo: 'A')
                            .get();
                        return querySnapshot.docs.length;
                      }
                      
                      // Compter le nombre de buts pour l'équipe B
                      Future<int> countGoalsTeamB() async {
                        QuerySnapshot querySnapshot = await match.doc(document.id)
                            .collection('but')
                            .where('Equipe', isEqualTo: 'B')
                            .get();
                        return querySnapshot.docs.length;
                      }

                      return FutureBuilder(
                        future: Future.wait([countGoalsTeamA(), countGoalsTeamB()]),
                        builder: (BuildContext context, AsyncSnapshot<List<int>> goalsSnapshot) {
                          if (goalsSnapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }

                          int goalsTeamA = goalsSnapshot.data![0];
                          int goalsTeamB = goalsSnapshot.data![1];

                        return Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Journée ${data['Journée']} sur 34',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Logo de l'équipe A
                                      Image.asset(
                                        'assets/${data['Equipe A']}.png',
                                        width: 100,
                                        height: 100,
                                      ),
                                      // Nom de l'équipe A
                                      Text(
                                        '${data['Equipe A']}',
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10), // Espacement entre le nom de l'équipe A et le score
                                  // Score du match
                                  Text(
                                    '$goalsTeamA - $goalsTeamB',
                                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 10), // Espacement entre le score et le nom de l'équipe B
                                  // Nom de l'équipe B
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Logo de l'équipe B
                                      Image.asset(
                                        'assets/${data['Equipe B']}.png',
                                        width: 100,
                                        height: 100,
                                      ),
                                      // Nom de l'équipe B
                                      Text(
                                        '${data['Equipe B']}',
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ]
                              ),
                          const SizedBox(height: 20), // Espacement à la fin
                          const Divider(), // Ajoute une ligne de séparation entre chaque match
                        ],
                      ),
                          ],
                        );
                    });
                    }).toList(),
                  );
                },
              ),
            ),
          ),
              ],
              ),
          const SizedBox(height: 20),
          ExpansionTile(
          title: const Text(
                'Premier League',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),
              
              children: <Widget>[
              Card(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: StreamBuilder<QuerySnapshot>(
                stream: match.where('Compet', isEqualTo: 'Premier League').orderBy('Date', descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print("Error: ${snapshot.error}");
                    return const Text("Something went wrong");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Affichez un indicateur de chargement pendant le chargement
                  }

                  if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    return const Text("No matches available");
                  }

                  return ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      
                      // Compter le nombre de buts pour l'équipe A
                      Future<int> countGoalsTeamA() async {
                        QuerySnapshot querySnapshot = await match.doc(document.id)
                            .collection('but')
                            .where('Equipe', isEqualTo: 'A')
                            .get();
                        return querySnapshot.docs.length;
                      }
                      
                      // Compter le nombre de buts pour l'équipe B
                      Future<int> countGoalsTeamB() async {
                        QuerySnapshot querySnapshot = await match.doc(document.id)
                            .collection('but')
                            .where('Equipe', isEqualTo: 'B')
                            .get();
                        return querySnapshot.docs.length;
                      }

                      return FutureBuilder(
                        future: Future.wait([countGoalsTeamA(), countGoalsTeamB()]),
                        builder: (BuildContext context, AsyncSnapshot<List<int>> goalsSnapshot) {
                          if (goalsSnapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }

                          int goalsTeamA = goalsSnapshot.data![0];
                          int goalsTeamB = goalsSnapshot.data![1];

                        return Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Journée ${data['Journée']} sur 38',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Logo de l'équipe A
                                    Image.asset(
                                      'assets/${data['Equipe A']}.png',
                                      width: 100,
                                      height: 100,
                                    ),
                                    // Nom de l'équipe A
                                    Text(
                                      '${data['Equipe A']}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10), // Espacement entre le nom de l'équipe A et le score
                                // Score du match
                                Text(
                                  '$goalsTeamA - $goalsTeamB',
                                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 10), // Espacement entre le score et le nom de l'équipe B
                                // Nom de l'équipe B
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Logo de l'équipe B
                                    Image.asset(
                                      'assets/${data['Equipe B']}.png',
                                      width: 100,
                                      height: 100,
                                    ),
                                    // Nom de l'équipe B
                                    Text(
                                      '${data['Equipe B']}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ]
                            ),
                          const SizedBox(height: 20), // Espacement à la fin
                          const Divider(), // Ajoute une ligne de séparation entre chaque match
                        ],
                      )
                          ]
                        );
                    });
                    }).toList(),
                  );
                },
              ),
            ),
          ),
              ],
          ),
          const SizedBox(height: 20),
          ExpansionTile(
          title: const Text(
                'La Liga',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),
              
              children: <Widget>[
              Card(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: StreamBuilder<QuerySnapshot>(
                stream: match.where('Compet', isEqualTo: 'La Liga').orderBy('Date', descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print("Error: ${snapshot.error}");
                    return const Text("Something went wrong");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Affichez un indicateur de chargement pendant le chargement
                  }

                  if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    return const Text("No matches available");
                  }

                  return ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      
                      // Compter le nombre de buts pour l'équipe A
                      Future<int> countGoalsTeamA() async {
                        QuerySnapshot querySnapshot = await match.doc(document.id)
                            .collection('but')
                            .where('Equipe', isEqualTo: 'A')
                            .get();
                        return querySnapshot.docs.length;
                      }
                      
                      // Compter le nombre de buts pour l'équipe B
                      Future<int> countGoalsTeamB() async {
                        QuerySnapshot querySnapshot = await match.doc(document.id)
                            .collection('but')
                            .where('Equipe', isEqualTo: 'B')
                            .get();
                        return querySnapshot.docs.length;
                      }

                      return FutureBuilder(
                        future: Future.wait([countGoalsTeamA(), countGoalsTeamB()]),
                        builder: (BuildContext context, AsyncSnapshot<List<int>> goalsSnapshot) {
                          if (goalsSnapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }

                          int goalsTeamA = goalsSnapshot.data![0];
                          int goalsTeamB = goalsSnapshot.data![1];

                        return Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Journée ${data['Journée']} sur 38',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Logo de l'équipe A
                                    Image.asset(
                                      'assets/${data['Equipe A']}.png',
                                      width: 100,
                                      height: 100,
                                    ),
                                    // Nom de l'équipe A
                                    Text(
                                      '${data['Equipe A']}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10), // Espacement entre le nom de l'équipe A et le score
                                // Score du match
                                Text(
                                  '$goalsTeamA - $goalsTeamB',
                                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 10), // Espacement entre le score et le nom de l'équipe B
                                // Nom de l'équipe B
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Logo de l'équipe B
                                    Image.asset(
                                      'assets/${data['Equipe B']}.png',
                                      width: 100,
                                      height: 100,
                                    ),
                                    // Nom de l'équipe B
                                    Text(
                                      '${data['Equipe B']}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ]
                            ),
                          const SizedBox(height: 20), // Espacement à la fin
                          const Divider(), // Ajoute une ligne de séparation entre chaque match
                        ],
                      )
                          ]
                        );
                    });
                    }).toList(),
                  );
                },
              ),
            ),
          ),
              ],
          ),
          const SizedBox(height: 20),
          ExpansionTile(
          title: const Text(
                'Serie A',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),
              
              children: <Widget>[
              Card(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: StreamBuilder<QuerySnapshot>(
                stream: match.where('Compet', isEqualTo: 'Serie A').orderBy('Date', descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print("Error: ${snapshot.error}");
                    return const Text("Something went wrong");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Affichez un indicateur de chargement pendant le chargement
                  }

                  if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    return const Text("No matches available");
                  }

                  return ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      
                      // Compter le nombre de buts pour l'équipe A
                      Future<int> countGoalsTeamA() async {
                        QuerySnapshot querySnapshot = await match.doc(document.id)
                            .collection('but')
                            .where('Equipe', isEqualTo: 'A')
                            .get();
                        return querySnapshot.docs.length;
                      }
                      
                      // Compter le nombre de buts pour l'équipe B
                      Future<int> countGoalsTeamB() async {
                        QuerySnapshot querySnapshot = await match.doc(document.id)
                            .collection('but')
                            .where('Equipe', isEqualTo: 'B')
                            .get();
                        return querySnapshot.docs.length;
                      }

                      return FutureBuilder(
                        future: Future.wait([countGoalsTeamA(), countGoalsTeamB()]),
                        builder: (BuildContext context, AsyncSnapshot<List<int>> goalsSnapshot) {
                          if (goalsSnapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }

                          int goalsTeamA = goalsSnapshot.data![0];
                          int goalsTeamB = goalsSnapshot.data![1];

                        return Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Journée ${data['Journée']} sur 38',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Logo de l'équipe A
                                    Image.asset(
                                      'assets/${data['Equipe A']}.png',
                                      width: 100,
                                      height: 100,
                                    ),
                                    // Nom de l'équipe A
                                    Text(
                                      '${data['Equipe A']}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10), // Espacement entre le nom de l'équipe A et le score
                                // Score du match
                                Text(
                                  '$goalsTeamA - $goalsTeamB',
                                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 10), // Espacement entre le score et le nom de l'équipe B
                                // Nom de l'équipe B
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Logo de l'équipe B
                                    Image.asset(
                                      'assets/${data['Equipe B']}.png',
                                      width: 100,
                                      height: 100,
                                    ),
                                    // Nom de l'équipe B
                                    Text(
                                      '${data['Equipe B']}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ]
                            ),
                          const SizedBox(height: 20), // Espacement à la fin
                          const Divider(), // Ajoute une ligne de séparation entre chaque match
                        ],
                      )
                          ]
                        );
                    });
                    }).toList(),
                  );
                },
              ),
            ),
          ),
              ],
          ),
          const SizedBox(height: 20),
          ExpansionTile(
          title: const Text(
                'Bundesliga',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),
              
              children: <Widget>[
              Card(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: StreamBuilder<QuerySnapshot>(
                stream: match.where('Compet', isEqualTo: 'Bundesliga').orderBy('Date', descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print("Error: ${snapshot.error}");
                    return const Text("Something went wrong");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Affichez un indicateur de chargement pendant le chargement
                  }

                  if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    return const Text("No matches available");
                  }

                  return ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      
                      // Compter le nombre de buts pour l'équipe A
                      Future<int> countGoalsTeamA() async {
                        QuerySnapshot querySnapshot = await match.doc(document.id)
                            .collection('but')
                            .where('Equipe', isEqualTo: 'A')
                            .get();
                        return querySnapshot.docs.length;
                      }
                      
                      // Compter le nombre de buts pour l'équipe B
                      Future<int> countGoalsTeamB() async {
                        QuerySnapshot querySnapshot = await match.doc(document.id)
                            .collection('but')
                            .where('Equipe', isEqualTo: 'B')
                            .get();
                        return querySnapshot.docs.length;
                      }

                      return FutureBuilder(
                        future: Future.wait([countGoalsTeamA(), countGoalsTeamB()]),
                        builder: (BuildContext context, AsyncSnapshot<List<int>> goalsSnapshot) {
                          if (goalsSnapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }

                          int goalsTeamA = goalsSnapshot.data![0];
                          int goalsTeamB = goalsSnapshot.data![1];

                        return Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Journée ${data['Journée']} sur 34',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Logo de l'équipe A
                                    Image.asset(
                                      'assets/${data['Equipe A']}.png',
                                      width: 100,
                                      height: 100,
                                    ),
                                    // Nom de l'équipe A
                                    Text(
                                      '${data['Equipe A']}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10), // Espacement entre le nom de l'équipe A et le score
                                // Score du match
                                Text(
                                  '$goalsTeamA - $goalsTeamB',
                                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 10), // Espacement entre le score et le nom de l'équipe B
                                // Nom de l'équipe B
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Logo de l'équipe B
                                    Image.asset(
                                      'assets/${data['Equipe B']}.png',
                                      width: 100,
                                      height: 100,
                                    ),
                                    // Nom de l'équipe B
                                    Text(
                                      '${data['Equipe B']}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ]
                            ),
                          const SizedBox(height: 20), // Espacement à la fin
                          const Divider(), // Ajoute une ligne de séparation entre chaque match
                        ],
                      )
                          ]
                        );
                    });
                    }).toList(),
                  );
                },
              ),
            ),
          ),
              ],
          ),
          const SizedBox(height: 10),
            ]
        ),
      ),
    )
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Accueil'),
    );
  }
}


class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // L'utilisateur ne peut pas fermer le dialogue en appuyant à l'extérieur
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Déconnexion'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer le dialogue sans déconnecter
              },
            ),
            TextButton(
              child: const Text('Se déconnecter'),
              onPressed: () {
                FirebaseAuth.instance.signOut(); // Déconnexion de l'utilisateur
                Navigator.of(context).pop(); // Fermer le dialogue
                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyApp()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  final List<Widget> _pages = [
    const Home(),
    const Matches(),
    const Profile(),
    const Settings(),
  ];

   void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Vérifier si un utilisateur est connecté
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      // Si aucun utilisateur n'est connecté, rediriger vers la page de connexion
      return const MaterialApp(
        home: MyApp(), // Redirection vers la page de connexion
        debugShowCheckedModeBanner: false,
      );
    } else {
      // Si un utilisateur est connecté, afficher la page principale
      return MaterialApp(
        title: 'Main Page',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            actions: [
              if (_selectedIndex == 2) // Afficher le bouton de déconnexion uniquement dans l'onglet Profil
                IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () {
                    _showLogoutConfirmationDialog(context); // Déconnexion de l'utilisateur
                  },
                ),
            ],
          ),
          body: _pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Accueil',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_soccer),
                label: 'Matchs',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Paramètres',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey[700],
            onTap: _onItemTapped,
          ),
        ),
      );
    }
  }
}
