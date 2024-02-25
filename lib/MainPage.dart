import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';

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
    return Center(
      child: Text('Matchs'),
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
      );
    } else {
      // Si un utilisateur est connecté, afficher la page principale
      return MaterialApp(
        title: 'Main Page',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Main Page'),
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
