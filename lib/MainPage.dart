import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Paramètres'),
    );
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profil'),
    );
  }
}

class Matches extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference match = FirebaseFirestore.instance.collection('match');

    return Container(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children:[
              SizedBox(height: 20),
              Text(
                'Ligue 1',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),
              Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: StreamBuilder<QuerySnapshot>(
                stream: match.where('Compet', isEqualTo: 'Ligue 1').orderBy('Date', descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print("Error: ${snapshot.error}");
                    return Text("Something went wrong");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Affichez un indicateur de chargement pendant le chargement
                  }

                  if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    return Text("No matches available");
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
                            return CircularProgressIndicator();
                          }

                          int goalsTeamA = goalsSnapshot.data![0];
                          int goalsTeamB = goalsSnapshot.data![1];

                        return Column(
                          children: [
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
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10), // Espacement entre le nom de l'équipe A et le score
                                // Score du match
                                Text(
                                  '$goalsTeamA - $goalsTeamB',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 10), // Espacement entre le score et le nom de l'équipe B
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
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ]
                            ),
                          SizedBox(height: 20), // Espacement à la fin
                          Divider(), // Ajoute une ligne de séparation entre chaque match
                        ],
                      );
                    });
                    }).toList(),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
                'Premier League',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),
              Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(20),
              child: StreamBuilder<QuerySnapshot>(
                stream: match.where('Compet', isEqualTo: 'Premier League').orderBy('Date', descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print("Error: ${snapshot.error}");
                    return Text("Something went wrong");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Affichez un indicateur de chargement pendant le chargement
                  }

                  if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    return Text("No matches available");
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
                            return CircularProgressIndicator();
                          }

                          int goalsTeamA = goalsSnapshot.data![0];
                          int goalsTeamB = goalsSnapshot.data![1];

                        return Column(
                          children: [
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
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10), // Espacement entre le nom de l'équipe A et le score
                                // Score du match
                                Text(
                                  '$goalsTeamA - $goalsTeamB',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 10), // Espacement entre le score et le nom de l'équipe B
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
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ]
                            ),
                          SizedBox(height: 20), // Espacement à la fin
                          Divider(), // Ajoute une ligne de séparation entre chaque match
                        ],
                      );
                    });
                    }).toList(),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
                'La Liga',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),
              Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(20),
              child: StreamBuilder<QuerySnapshot>(
                stream: match.where('Compet', isEqualTo: 'La Liga').orderBy('Date', descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print("Error: ${snapshot.error}");
                    return Text("Something went wrong");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Affichez un indicateur de chargement pendant le chargement
                  }

                  if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    return Text("No matches available");
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
                            return CircularProgressIndicator();
                          }

                          int goalsTeamA = goalsSnapshot.data![0];
                          int goalsTeamB = goalsSnapshot.data![1];

                        return Column(
                          children: [
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
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10), // Espacement entre le nom de l'équipe A et le score
                                // Score du match
                                Text(
                                  '$goalsTeamA - $goalsTeamB',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 10), // Espacement entre le score et le nom de l'équipe B
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
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ]
                            ),
                          SizedBox(height: 20), // Espacement à la fin
                          Divider(), // Ajoute une ligne de séparation entre chaque match
                        ],
                      );
                    });
                    }).toList(),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
                'Serie A',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),
              Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(20),
              child: StreamBuilder<QuerySnapshot>(
                stream: match.where('Compet', isEqualTo: 'Serie A').orderBy('Date', descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print("Error: ${snapshot.error}");
                    return Text("Something went wrong");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Affichez un indicateur de chargement pendant le chargement
                  }

                  if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    return Text("No matches available");
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
                            return CircularProgressIndicator();
                          }

                          int goalsTeamA = goalsSnapshot.data![0];
                          int goalsTeamB = goalsSnapshot.data![1];

                        return Column(
                          children: [
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
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10), // Espacement entre le nom de l'équipe A et le score
                                // Score du match
                                Text(
                                  '$goalsTeamA - $goalsTeamB',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 10), // Espacement entre le score et le nom de l'équipe B
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
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ]
                            ),
                          SizedBox(height: 20), // Espacement à la fin
                          Divider(), // Ajoute une ligne de séparation entre chaque match
                        ],
                      );
                    });
                    }).toList(),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
                'Bundesliga',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),
              Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(20),
              child: StreamBuilder<QuerySnapshot>(
                stream: match.where('Compet', isEqualTo: 'Bundesliga').orderBy('Date', descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print("Error: ${snapshot.error}");
                    return Text("Something went wrong");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Affichez un indicateur de chargement pendant le chargement
                  }

                  if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    return Text("No matches available");
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
                            return CircularProgressIndicator();
                          }

                          int goalsTeamA = goalsSnapshot.data![0];
                          int goalsTeamB = goalsSnapshot.data![1];

                        return Column(
                          children: [
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
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10), // Espacement entre le nom de l'équipe A et le score
                                // Score du match
                                Text(
                                  '$goalsTeamA - $goalsTeamB',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 10), // Espacement entre le score et le nom de l'équipe B
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
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ]
                            ),
                          SizedBox(height: 20), // Espacement à la fin
                          Divider(), // Ajoute une ligne de séparation entre chaque match
                        ],
                      );
                    });
                    }).toList(),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 10),
            ]
        ),
      ),
    )
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Accueil'),
    );
  }
}


class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Home(),
    Matches(),
    Profile(),
    Settings(),
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
      return MaterialApp(
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
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    FirebaseAuth.instance.signOut(); // Déconnexion de l'utilisateur
                  },
                ),
            ],
          ),
          body: _pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
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
