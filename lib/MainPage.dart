import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class Amis {
  final String name;
  final String url;

  Amis(this.name, this.url);
}

class Club {
  final String name;
  bool isSelected;

  Club(this.name, this.isSelected);
}

class Ligue {
  final String name;
  bool isSelected;

  Ligue(this.name, this.isSelected);
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isClicked = false;
  bool isClicked2 = false;
  bool isClicked3 = false;
  bool isClicked4 = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            setState(() {
              isClicked = !isClicked; // Inverser l'état du clic
            });
            await Future.delayed(const Duration(milliseconds: 100));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ModifPseudo()),
            );
            setState(() {
              isClicked = !isClicked; // Inverser l'état du clic
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 50,
            decoration: BoxDecoration(
              color: isClicked ? Colors.grey : Colors.white,
              border: const Border(
                top: BorderSide(
                  color: Colors.grey, // Modifier la couleur en fonction de l'état du clic
                  width: 1.0,
                ),
              ),
            ),
            child: const Center(
              child: Text(
                'Modifier son pseudo',
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            setState(() {
              isClicked2 = !isClicked2; // Inverser l'état du clic
            });
            await Future.delayed(const Duration(milliseconds: 100));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ModifMail()),
            );
            setState(() {
              isClicked2 = !isClicked2; // Inverser l'état du clic
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 50,
            decoration: BoxDecoration(
              color: isClicked2 ? Colors.grey : Colors.white,
              border: const Border(
                top: BorderSide(
                  color: Colors.grey, // Modifier la couleur en fonction de l'état du clic
                  width: 1.0,
                ),
              ),
            ),
            child: const Center(
              child: Text(
                'Modifier son mail',
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            setState(() {
              isClicked3 = !isClicked3; // Inverser l'état du clic
            });
            await Future.delayed(const Duration(milliseconds: 100));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ModifMdp()),
            );
            setState(() {
              isClicked3 = !isClicked3; // Inverser l'état du clic
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 50,
            decoration: BoxDecoration(
              color: isClicked3 ? Colors.grey : Colors.white,
              border: const Border(
                top: BorderSide(
                  color: Colors.grey, // Modifier la couleur en fonction de l'état du clic
                  width: 1.0,
                ),
              ),
            ),
            child: const Center(
              child: Text(
                'Modifier son mot de passe',
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            setState(() {
              isClicked4 = !isClicked4; // Inverser l'état du clic
            });
            await Future.delayed(const Duration(milliseconds: 100));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SupCompte()),
            );
            setState(() {
              isClicked4 = !isClicked4; // Inverser l'état du clic
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 50,
            decoration: BoxDecoration(
              color: isClicked4 ? Colors.grey : Colors.white,
              border: const Border(
                top: BorderSide(
                  color: Colors.grey, // Modifier la couleur en fonction de l'état du clic
                  width: 1.0,
                ),
                bottom: BorderSide(
                  color: Colors.grey, // Modifier la couleur en fonction de l'état du clic
                  width: 1.0,
                ),
              ),
            ),
            child: const Center(
              child: Text(
                'Supprimer son compte',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ModifPseudo extends StatelessWidget {
  const ModifPseudo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier son pseudo'),
      ),
      body: ModifierPseudoForm(),
    );
  }
}

class ModifierPseudoForm extends StatefulWidget {
  @override
  _ModifierPseudoFormState createState() => _ModifierPseudoFormState();
}

class _ModifierPseudoFormState extends State<ModifierPseudoForm> {
  final TextEditingController _pseudoController = TextEditingController();
  String _errorMessage = '';
  String _pseudo = '';

  @override
  void initState() {
    super.initState();
    getUserPseudo();
  }

  Future<void> getUserPseudo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('utilisateurs')
          .doc(user.uid)
          .get();
      setState(() {
        _pseudo = userData.data()?['pseudo'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_pseudo.isNotEmpty)
            Text(
              'Pseudo actuel : $_pseudo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          TextField(
            controller: _pseudoController,
            decoration: InputDecoration(
              labelText: 'Nouveau pseudo',
            ),
          ),
          if (_errorMessage.isNotEmpty)
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              modifierPseudo(context);
            },
            child: Text('Modifier'),
          ),
        ],
      ),
    );
  }
  void modifierPseudo(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('utilisateurs')
            .doc(user.uid)
            .update({'pseudo': _pseudoController.text});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Pseudo modifié avec succès'),
          ),
        );
        Navigator.pop(
            context); // Retour à l'écran précédent après la modification
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur lors de la modification du pseudo : $e';
      });
    }
  }
}

class ModifMail extends StatelessWidget {
  const ModifMail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier son adresse e-mail'),
      ),
      body: ModifierMailForm(),
    );
  }
}

class ModifierMailForm extends StatefulWidget {
  @override
  _ModifierMailFormState createState() => _ModifierMailFormState();
}

class _ModifierMailFormState extends State<ModifierMailForm> {
  final TextEditingController _emailController = TextEditingController();
  String _errorMessage = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    getUserEmail();
  }

  Future<void> getUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _email = user.email ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_email.isNotEmpty)
            Text(
              'Adresse e-mail actuelle : $_email',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Nouvelle adresse e-mail',
            ),
          ),
          if (_errorMessage.isNotEmpty)
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              modifierMail(context);
            },
            child: Text('Modifier'),
          ),
        ],
      ),
    );
  }
  void modifierMail(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.verifyBeforeUpdateEmail(_emailController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Un lien de vérification a été envoyé à votre nouvelle adresse e-mail. Veuillez vérifier et suivre les instructions pour confirmer le changement.'),
          ),
        );
        Navigator.pop(
            context); // Retour à l'écran précédent après la modification
      }
    } catch (e) {
      setState(() {
        _errorMessage =
            'Erreur lors de la modification de l\'adresse e-mail : $e';
      });
    }
  }
}

class ModifMdp extends StatelessWidget {
  const ModifMdp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier son mot de passe'),
      ),
      body: ModifierMotDePasseForm(),
    );
  }
}

class ModifierMotDePasseForm extends StatefulWidget {
  @override
  _ModifierMotDePasseFormState createState() => _ModifierMotDePasseFormState();
}

class _ModifierMotDePasseFormState extends State<ModifierMotDePasseForm> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _oldPasswordController,
            decoration: InputDecoration(
              labelText: 'Ancien mot de passe',
            ),
            obscureText: true,
          ),
          TextField(
            controller: _newPasswordController,
            decoration: InputDecoration(
              labelText: 'Nouveau mot de passe',
            ),
            obscureText: true,
          ),
          TextField(
            controller: _confirmPasswordController,
            decoration: InputDecoration(
              labelText: 'Confirmer le nouveau mot de passe',
            ),
            obscureText: true,
          ),
          if (_errorMessage.isNotEmpty)
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              modifierMotDePasse(context);
            },
            child: Text('Modifier'),
          ),
        ],
      ),
    );
  }

  void modifierMotDePasse(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String newPassword = _newPasswordController.text;

        // Vérifier si le nouveau mot de passe respecte les critères
        if (!_verifierMotDePasse(newPassword)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Le nouveau mot de passe ne respecte pas les critères requis. Une majuscule, un caractère spécial, un chiffre et 8 caractères minimums sont requis.'),
            ),
          );
          return;
        }

        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: _oldPasswordController.text,
        );
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPassword);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Mot de passe modifié avec succès'),
          ),
        );
        Navigator.pop(
            context); // Retour à l'écran précédent après la modification
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur lors de la modification du mot de passe : $e';
      });
    }
  }

  bool _verifierMotDePasse(String password) {
    // Vérifier si le mot de passe contient au moins une majuscule, un caractère spécial et un chiffre, et a une longueur d'au moins 8 caractères
    String pattern = r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }
}

class SupCompte extends StatelessWidget {
  const SupCompte({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supprimer son compte'),
      ),
      body: SupprimerCompteConfirmation(),
    );
  }
}

class SupprimerCompteConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Êtes-vous sûr de vouloir supprimer votre compte ?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              confirmerSuppressionCompte(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: Text(
              'Confirmer la suppression',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void confirmerSuppressionCompte(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Supprimer l'utilisateur de la liste d'amis de tous les autres utilisateurs
        QuerySnapshot friendLists =
            await FirebaseFirestore.instance.collection('utilisateurs').get();
        for (QueryDocumentSnapshot userDoc in friendLists.docs) {
          await FirebaseFirestore.instance
              .collection('utilisateurs')
              .doc(userDoc.id)
              .update({
            'amis': FieldValue.arrayRemove(
                [user.uid]) // Supprimer l'utilisateur de la liste d'amis
          });
        }

        // Supprimer le document de l'utilisateur
        await FirebaseFirestore.instance
            .collection('utilisateurs')
            .doc(user.uid)
            .delete();

        // Supprimer l'utilisateur
        await user.delete();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Votre compte a été supprimé avec succès'),
          ),
        );

        // Afficher un dialog de confirmation avant de rediriger vers MyApp
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Compte supprimé"),
              content: Text("Votre compte a été supprimé avec succès."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la suppression du compte : $e'),
        ),
      );
    }
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  final ImagePicker _picker = ImagePicker();
  File? _image;
  final TextEditingController _descriptionController = TextEditingController();
  int followingCount = 0;
  int clubsCount = 0;
  int leaguesCount = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('utilisateurs').doc(userId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Une erreur est survenue'),
          );
        } else {
           final userData = snapshot.data?.data() as Map<String, dynamic>?;;
          if (userData == null) {
            return const Center(
              child: Text('Aucune donnée disponible'),
            );
          }
          final pseudo = userData['pseudo'] ?? '';
          String photoUrl = userData['photoUrl'] ?? '';
          if(photoUrl == ''){
            photoUrl = 'assets/Inconnu.png';
          }
          final description = userData['description'] ?? '';
          int followingCount = (userData['amis'] as List<dynamic>?)?.length ?? 0;
          int clubsCount = (userData['club'] as List<dynamic>?)?.length ?? 0;
          int leaguesCount = (userData['ligue'] as List<dynamic>?)?.length ?? 0;
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(photoUrl),
                          radius: 50,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          pseudo,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    InkWell(
                      onTap: () {
                        showAbonneList(context, pseudo);
                      },
                      child: Column(
                        children: [
                          FutureBuilder<int>(
                            future: getFollowersCount(pseudo),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else {
                                final followersCount = snapshot.data ?? 0;
                                return Text(
                                  '$followersCount',
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                );
                              }
                            },
                          ),
                          const Text('Abonnés'),
                        ]
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        showAbonnementList(context);
                      },
                      child: Column(
                        children: [
                          Text(
                            '$followingCount',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Text('Abonnements'),
                        ]
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        showClubList(context);
                      },
                      child: Column(
                        children: [
                          Text(
                            '$clubsCount',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Text('Clubs suivis'),
                        ]
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                        onTap: () {
                          showLigueList(context);
                        },
                        child: Column(
                        children: [
                          Text(
                            '$leaguesCount',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Text('Ligues suivies'),
                        ]
                      ),
                    ),
                  ],),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(description),
                    ],
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      _showEditDescriptionDialog(description);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Couleur de fond du bouton
                      foregroundColor: Colors.white, // Couleur du texte du bouton
                    ),
                    child: const Text(
                      'Modifier la description',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _pickImage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Couleur de fond du bouton
                      foregroundColor: Colors.white, // Couleur du texte du bouton
                    ),
                    child: const Text(
                      'Changer de photo',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                context: context,
                builder: (BuildContext context) {
                  TextEditingController _searchController =
                      TextEditingController();
                  List<DocumentSnapshot> _searchResults = [];

                  Future<List<DocumentSnapshot>> searchUsers(String searchTerm) async {
                    var querySnapshot = await FirebaseFirestore.instance
                      .collection('utilisateurs')
                      .where('pseudo', isEqualTo: searchTerm)
                      .where('pseudo', isNotEqualTo: pseudo)
                      .get();
                    return querySnapshot.docs;
                  }

                  return AlertDialog(
  title: Text('Ajouter un utilisateur'),
  content: StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Rechercher un utilisateur',
            ),
            onChanged: (value) async {
              List<DocumentSnapshot> results = await searchUsers(value);
              setState(() {
                _searchResults = results;
              });
            },
          ),
          SizedBox(height: 20),
          _searchResults.isEmpty
              ? Center(
                  child: Text('Aucun résultat trouvé'),
                )
              : SizedBox(
                  child: SingleChildScrollView(
                    child: Column(
                      children: _searchResults.map((user) {
                        String photoUserUrl = user['photoUrl'] ?? '';
                        if(photoUserUrl == ''){
                          photoUserUrl = 'assets/Inconnu.png';
                        }
                        return ListTile(
                          title: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(photoUserUrl),
                                    radius: 15,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(user['pseudo'],style: const TextStyle(fontSize: 15))
                                ],
                              ),
                            ],
                          ),
                          onTap: () async {
                            Navigator.pop(context); // Fermer la boîte de dialogue de recherche
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserProfilePage(user['pseudo'],userId),
                              ),
                            );
                            if (result != null && result is bool && result) {
                              setState(() {});
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
        ],
      );
    },
  ),
);
                },
              );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Couleur de fond du bouton
                      foregroundColor: Colors.white, // Couleur du texte du bouton
                    ),
                    child: const Text(
                      'Ajouter un utilisateur',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final selectedClubs = <Club>[];
                      final clubs = await fetchClubsFromFirebase(selectedClubs);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                title: Text('Ajouter un club'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: clubs.map((club) {
                                      return Container(width: 500, child: CheckboxListTile(
                                        title: Row(
                                          children: [
                                            Image.asset('assets/${club.name}.png', width: 30, height: 30) ,// Ici vous pouvez remplacer l'icône par votre propre image/logo
                                            SizedBox(width: 10), // Espacement entre l'icône et le titre
                                            Text(club.name,style: TextStyle(fontSize: 15)),
                                          ],
                                        ),
                                        value: club.isSelected,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            club.isSelected = value ?? false;
                                            if (value ?? false) {
                                              selectedClubs.add(club);
                                            } else {
                                              selectedClubs.removeWhere((c) => c.name == club.name);
                                            }
                                          });
                                        },// Icône affichée à droite du titre
                                      ),);
                                    }).toList(),
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Annuler'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await updateUserClubsInFirebase(selectedClubs);
                                      Navigator.of(context).pop();
                                      refreshUserData();
                                    },
                                    child: Text('Valider'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Couleur de fond du bouton
                      foregroundColor: Colors.white, // Couleur du texte du bouton
                    ),
                    child: const Text(
                      'Ajouter un club',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final selectedLigues = <Ligue>[];
                      final ligues = await fetchLiguesFromFirebase(selectedLigues);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                title: Text('Ajouter un championnat'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: ligues.map((ligue) {
                                      return Container(width: 500, child: CheckboxListTile(
                                        title: Row(
                                          children: [
                                            Image.asset('assets/${ligue.name}.png', width: 30, height: 30) ,// Ici vous pouvez remplacer l'icône par votre propre image/logo
                                            SizedBox(width: 10), // Espacement entre l'icône et le titre
                                            Text(ligue.name,style: TextStyle(fontSize: 15)),
                                          ],
                                        ),
                                        value: ligue.isSelected,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            ligue.isSelected = value ?? false;
                                            if (value ?? false) {
                                              selectedLigues.add(ligue);
                                            } else {
                                              selectedLigues.removeWhere((l) => l.name == ligue.name);
                                            }
                                          });
                                        },
                                      ),);
                                    }).toList(),
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Annuler'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await updateUserLiguesInFirebase(selectedLigues);
                                      Navigator.of(context).pop();
                                      refreshUserData();
                                    },
                                    child: Text('Valider'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Couleur de fond du bouton
                      foregroundColor: Colors.white, // Couleur du texte du bouton
                    ),
                    child: const Text(
                      'Ajouter un championnat',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<int> getFollowersCount(String userPseudo) async {
    int compteur = 0;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('utilisateurs').get();
    querySnapshot.docs.forEach((doc) {
      if(doc["pseudo"] != userPseudo){
        if(doc["amis"].contains(userPseudo)){
          compteur++;
        }
      }
    });
    return compteur;
  }

  Future<void> refreshUserData() async {
    final userData = await FirebaseFirestore.instance.collection('utilisateurs').doc(userId).get();
    setState(() {
      clubsCount = (userData['club'] as List<dynamic>?)?.length ?? 0;
      leaguesCount = (userData['ligue'] as List<dynamic>?)?.length ?? 0;
    });
  }

  void _showEditDescriptionDialog(String currentDescription) {
    _descriptionController.text = currentDescription;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Modifier la description'),
          content: TextField(
            controller: _descriptionController,
            decoration: InputDecoration(hintText: 'Nouvelle description'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                String newDescription = _descriptionController.text;
                FirebaseFirestore.instance.collection('utilisateurs').doc(userId).update({
                  'description': newDescription,
                }).then((value) {
                  print('Description mise à jour avec succès');
                  setState(() {});
                }).catchError((error) {
                  print('Erreur lors de la mise à jour de la description: $error');
                });
                Navigator.of(context).pop();
              },
              child: Text('Valider'),
            ),
          ],
        );
      },
    );
  }
  void _pickImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _uploadImageToFirebaseStorage();
      Navigator.of(context).pop();
    }
  }
  void _uploadImageToFirebaseStorage() async {
    if (_image == null) return;

    try {
      String fileName = Path.basename(_image!.path);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('profile_images/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(_image!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      // Mettre à jour l'URL de l'image dans Firestore
      FirebaseFirestore.instance.collection('utilisateurs').doc(userId).update({
        'photoUrl': imageUrl,
      }).then((value) {
        print('Photo de profil mise à jour avec succès');
      }).catchError((error) {
        print('Erreur lors de la mise à jour de la photo de profil: $error');
      });
    } catch (e) {
      print('Erreur lors de la mise à jour de la photo de profil: $e');
    }
  }
  
  Future<List<Club>> fetchClubsFromFirebase(List<Club> selectedClubs) async {
    List<Club> clubs = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Championnat').get();
      final userDocument = await FirebaseFirestore.instance.collection('utilisateurs').doc(userId).get();
      final List<dynamic>? userClubs = userDocument.data()?['club'];
      querySnapshot.docs.forEach((doc) {
        if(doc.id == "Ligue 1"){
          for(int i = 1;i<=18;i++){
            if(userClubs != null && userClubs.contains(doc["Equipe $i"])){
              clubs.add(Club(doc["Equipe $i"],true));
              selectedClubs.add(Club(doc["Equipe $i"],true));
            }
            else{
              clubs.add(Club(doc["Equipe $i"],false));
            }
          }
        }
        if(doc.id == "La Liga"){
          for(int i = 1;i<=20;i++){
            if(userClubs != null && userClubs.contains(doc["Equipe $i"])){
              clubs.add(Club(doc["Equipe $i"],true));
              selectedClubs.add(Club(doc["Equipe $i"],true));
            }
            else{
              clubs.add(Club(doc["Equipe $i"],false));
            }
          }
        }
        if(doc.id == "Premier League"){
          for(int i = 1;i<=20;i++){
            if(userClubs != null && userClubs.contains(doc["Equipe $i"])){
              clubs.add(Club(doc["Equipe $i"],true));
              selectedClubs.add(Club(doc["Equipe $i"],true));
            }
            else{
              clubs.add(Club(doc["Equipe $i"],false));
            }
          }
        }
        if(doc.id == "Serie A"){
          for(int i = 1;i<=20;i++){
            if(userClubs != null && userClubs.contains(doc["Equipe $i"])){
              clubs.add(Club(doc["Equipe $i"],true));
              selectedClubs.add(Club(doc["Equipe $i"],true));
            }
            else{
              clubs.add(Club(doc["Equipe $i"],false));
            }
          }
        }
        if(doc.id == "Bundesliga"){
          for(int i = 1;i<=18;i++){
            if(userClubs != null && userClubs.contains(doc["Equipe $i"])){
              clubs.add(Club(doc["Equipe $i"],true));
              selectedClubs.add(Club(doc["Equipe $i"],true));
            }
            else{
              clubs.add(Club(doc["Equipe $i"],false));
            }
          }
        }
      });
    } catch (e) {
      print('Error fetching clubs: $e');
    }
    return clubs;
  }

  Future<List<Ligue>> fetchLiguesFromFirebase(List<Ligue> selectedLigues) async {
    List<Ligue> ligues = [];
    try {
      final userDocument = await FirebaseFirestore.instance.collection('utilisateurs').doc(userId).get();
      final List<dynamic>? userLigues = userDocument.data()?['ligue'];
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Championnat').get();
      querySnapshot.docs.forEach((doc) {
        if(userLigues != null && userLigues.contains(doc.id)){
          ligues.add(Ligue(doc.id,true));
          selectedLigues.add(Ligue(doc.id,true));
        }
        else{
          ligues.add(Ligue(doc.id,false));
        }
      });
      QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance.collection('Compétitions Européennes ').get();
      querySnapshot2.docs.forEach((doc) {
        if(userLigues != null && userLigues.contains(doc.id)){
          ligues.add(Ligue(doc.id,true));
          selectedLigues.add(Ligue(doc.id,true));
        }
        else{
          ligues.add(Ligue(doc.id,false));
        }
      });
    } catch (e) {
      print('Error fetching ligues: $e');
    }
    return ligues;
  }

  Future<void> updateUserClubsInFirebase(List<Club> selectedClubs) async {
    try {
      final userRef = FirebaseFirestore.instance.collection('utilisateurs').doc(userId);
      List<String> selectedClubNames = selectedClubs.map((club) => club.name).toList();
      await userRef.update({'club': selectedClubNames});
      print('Clubs mis à jour avec succès dans Firebase !');
    } catch (error) {
      print('Erreur lors de la mise à jour des clubs dans Firebase: $error');
    }
  }

  Future<void> updateUserLiguesInFirebase(List<Ligue> selectedLigues) async {
    try {
      final userRef = FirebaseFirestore.instance.collection('utilisateurs').doc(userId);
      List<String> selectedLigueNames = selectedLigues.map((ligue) => ligue.name).toList();
      await userRef.update({'ligue': selectedLigueNames});
      print('Ligues mis à jour avec succès dans Firebase !');
    } catch (error) {
      print('Erreur lors de la mise à jour des ligues dans Firebase: $error');
    }
  }

  void showAbonneList(BuildContext context, String pseudo) async {
    List<Amis> subscriptions = await fetchAbonneFromFirebase(pseudo);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Vos abonnés'),
          content: SingleChildScrollView(
            child: ListBody(
              children: subscriptions.map((subscription) {
                String urlAbo = subscription.url;
                if(urlAbo == ""){
                  urlAbo = "assets/Inconnu.png";
                }
                return ListTile(
                  title: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(urlAbo),
                            radius: 15,
                          ),
                          const SizedBox(width: 10),
                          Text(subscription.name,style: const TextStyle(fontSize: 15))
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
  Future<List<Amis>> fetchAbonneFromFirebase(String userPseudo) async {
    List<Amis> abonne = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('utilisateurs').get();
    querySnapshot.docs.forEach((doc) {
      if(doc["pseudo"] != userPseudo){
        if(doc["amis"].contains(userPseudo)){
          abonne.add(Amis(doc["pseudo"],doc["photoUrl"]));
        }
      }
    });
    return abonne;
  }

  void showAbonnementList(BuildContext context) async {
    List<Amis> subscriptions = await fetchAbonnementFromFirebase();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Vos abonnements'),
          content: SingleChildScrollView(
            child: ListBody(
              children: subscriptions.map((subscription) {
                String urlAbo = subscription.url;
                if(urlAbo == ""){
                  urlAbo = "assets/Inconnu.png";
                }
                return ListTile(
                  title: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(urlAbo),
                            radius: 15,
                          ),
                          const SizedBox(width: 10),
                          Text(subscription.name,style: const TextStyle(fontSize: 15))
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
   Future<List<Amis>> fetchAbonnementFromFirebase() async {
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('utilisateurs');
    DocumentSnapshot userSnapshot = await usersCollection.doc(userId).get();

    if (userSnapshot.exists && userSnapshot.data() != null) {
      Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
      if (userData.containsKey('amis')) {
        List<dynamic> subscriptions = userData['amis'];
        List<Amis> abonnements = [];
        for (var subscription in subscriptions) {
          String pseudo = subscription.toString();
          String photoUrl = await recupUrl(pseudo);
          abonnements.add(Amis(pseudo, photoUrl));
        }
        return abonnements;
      }
    }
    return [];
  }
  Future<String> recupUrl(String userPseudo) async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('utilisateurs').get();
    String photoUrl = "";
    querySnapshot.docs.forEach((doc) {
      if(doc["pseudo"] == userPseudo){
        photoUrl = doc["photoUrl"];
      }
    });
    return photoUrl;
  }

  void showClubList(BuildContext context) async {
    List<String> clubs = await fetchClubFromFirebase();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Vos clubs suivis'),
          content: SingleChildScrollView(
            child: ListBody(
              children: clubs.map((club) {
                return Container(
                  child: Column(
                    children: [
                      Row(
                      children: [
                        Image.asset('assets/${club}.png', width: 30, height: 30) ,// Ici vous pouvez remplacer l'icône par votre propre image/logo
                        SizedBox(width: 10), // Espacement entre l'icône et le titre
                        Text(club,style: TextStyle(fontSize: 15)),
                      ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  Future<List<String>> fetchClubFromFirebase() async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('utilisateurs');
    DocumentSnapshot userSnapshot = await usersCollection.doc(userId).get();

    if (userSnapshot.exists && userSnapshot.data() != null) {
      Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
      if (userData.containsKey('club')) {
        List<dynamic> clubsData = userData['club'];
        List<String> clubs = clubsData.map((subscription) => subscription.toString()).toList();
        return clubs;
      }
    }
    return [];
  }

  void showLigueList(BuildContext context) async {
    List<String> ligues = await fetchLigueFromFirebase();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Vos ligues suivis'),
          content: SingleChildScrollView(
            child: ListBody(
              children: ligues.map((ligue) {
                return Container(
                  child: Column( 
                    children: [
                      Row(
                      children: [
                        Image.asset('assets/${ligue}.png', width: 30, height: 30) ,// Ici vous pouvez remplacer l'icône par votre propre image/logo
                        SizedBox(width: 10), // Espacement entre l'icône et le titre
                        Text(ligue,style: TextStyle(fontSize: 15)),
                      ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
   Future<List<String>> fetchLigueFromFirebase() async {
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('utilisateurs');
    DocumentSnapshot userSnapshot = await usersCollection.doc(userId).get();

    if (userSnapshot.exists && userSnapshot.data() != null) {
      Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
      if (userData.containsKey('ligue')) {
        List<dynamic> liguesData = userData['ligue'];
        List<String> ligues = liguesData.map((subscription) => subscription.toString()).toList();
        return ligues;
      }
    }
    return [];
  }
}

class UserProfilePage extends StatefulWidget {
  final String userPseudo;
  final String? myUserID;

  UserProfilePage(this.userPseudo,this.myUserID);

  @override
  _UserProfilePageState createState() => _UserProfilePageState(userPseudo,myUserID);
}

class _UserProfilePageState extends State<UserProfilePage> {
  final String userPseudo;
  final String? myUserID;

  _UserProfilePageState(this.userPseudo,this.myUserID);

  Future<DocumentSnapshot?> searchUsers(String searchTerm) async {
    var querySnapshot = await FirebaseFirestore.instance
      .collection('utilisateurs')
      .where('pseudo', isEqualTo: searchTerm)
      .limit(1)
      .get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first;
    } else {
      return null; // Aucun résultat trouvé
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot?>(
      future: searchUsers(userPseudo),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError || snapshot.data == null) {
          return const Center(
            child: Text('Une erreur est survenue ou aucun résultat trouvé'),
          );
        } else {
          final userData = snapshot.data!.data() as Map<String, dynamic>;
          String photoUrl = userData['photoUrl'] ?? '';
          if(photoUrl == ''){
            photoUrl = 'assets/Inconnu.png';
          }
          final description = userData['description'] ?? '';
          int followingCount = (userData['amis'] as List<dynamic>?)?.length ?? 0;
          int clubsCount = (userData['club'] as List<dynamic>?)?.length ?? 0;
          int leaguesCount = (userData['ligue'] as List<dynamic>?)?.length ?? 0;
          return Scaffold(
            appBar: AppBar(
              title: Text('Profil de ${userData['pseudo']}'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(photoUrl),
                          radius: 50,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          userPseudo,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    InkWell(
                      onTap: () {
                        showAbonneList(context, userPseudo);
                      },
                      child: Column(
                        children: [
                          FutureBuilder<int>(
                            future: getFollowersCount(userPseudo),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else {
                                final followersCount = snapshot.data ?? 0;
                                return Text(
                                  '$followersCount',
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                );
                              }
                            },
                          ),
                          const Text('Abonnés'),
                        ]
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        showAbonnementList(context);
                      },
                      child: Column(
                        children: [
                          Text(
                            '$followingCount',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Text('Abonnements'),
                        ]
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        showClubList(context);
                      },
                      child: Column(
                        children: [
                          Text(
                            '$clubsCount',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Text('Clubs suivis'),
                        ]
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                        onTap: () {
                          showLigueList(context);
                        },
                        child: Column(
                        children: [
                          Text(
                            '$leaguesCount',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Text('Ligues suivies'),
                        ]
                      ),
                    ),
                  ],),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(description),
                    ],
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      bool? isSubscribed = await estAbonne();
                      if (isSubscribed) {
                        // Si l'utilisateur est déjà abonné, le désabonner
                        removeUser();
                      } else {
                        // Sinon, l'abonner
                        addUser();
                      }
                      setState((){});
                    },
                    child: FutureBuilder<bool>(
                      future: estAbonne(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text('Chargement...'); // Afficher un texte de chargement pendant que nous attendons le résultat
                        }
                        if (snapshot.hasError || snapshot.data == null) {
                          return Text('Erreur'); // Afficher un message d'erreur si la récupération a échoué ou si la valeur est nulle
                        }
                        return Text(snapshot.data! ? 'Se désabonner' : 'S\'abonner'); // Utiliser le résultat retourné par estAbonne()
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        }
      }
    );
  }
  Future<int> getFollowersCount(String userPseudo) async {
    int compteur = 0;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('utilisateurs').get();
    querySnapshot.docs.forEach((doc) {
      if(doc["pseudo"] != userPseudo){
        if(doc["amis"].contains(userPseudo)){
          compteur++;
        }
      }
    });
    return compteur;
  }
  void showAbonneList(BuildContext context, String pseudo) async {
    List<Amis> subscriptions = await fetchAbonneFromFirebase(pseudo);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Vos abonnés'),
          content: SingleChildScrollView(
            child: ListBody(
              children: subscriptions.map((subscription) {
                String urlAbo = subscription.url;
                if(urlAbo == ""){
                  urlAbo = "assets/Inconnu.png";
                }
                return ListTile(
                  title: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(urlAbo),
                            radius: 15,
                          ),
                          const SizedBox(width: 10),
                          Text(subscription.name,style: const TextStyle(fontSize: 15))
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
  Future<List<Amis>> fetchAbonneFromFirebase(String userPseudo) async {
    List<Amis> abonne = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('utilisateurs').get();
    querySnapshot.docs.forEach((doc) {
      if(doc["pseudo"] != userPseudo){
        if(doc["amis"].contains(userPseudo)){
          abonne.add(Amis(doc["pseudo"],doc["photoUrl"]));
        }
      }
    });
    return abonne;
  }

  Future<bool> estAbonne() async {
    final abo = await FirebaseFirestore.instance.collection('utilisateurs').doc(myUserID).get();
    if(abo["amis"].contains(userPseudo)){
      return true;
    }
    return false;
  }

  void showAbonnementList(BuildContext context) async {
    List<Amis> subscriptions = await fetchAbonnementFromFirebase();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Vos abonnements'),
          content: SingleChildScrollView(
            child: ListBody(
              children: subscriptions.map((subscription) {
                String urlAbo = subscription.url;
                if(urlAbo == ""){
                  urlAbo = "assets/Inconnu.png";
                }
                return ListTile(
                  title: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(urlAbo),
                            radius: 15,
                          ),
                          const SizedBox(width: 10),
                          Text(subscription.name,style: const TextStyle(fontSize: 15))
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
  Future<String> recupUrl(String userPseudo) async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('utilisateurs').get();
    String photoUrl = "";
    querySnapshot.docs.forEach((doc) {
      if(doc["pseudo"] == userPseudo){
        photoUrl = doc["photoUrl"];
      }
    });
    return photoUrl;
  }
  Future<List<Amis>> fetchAbonnementFromFirebase() async {
    List<Amis> abonnement = [];
    String url;
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('utilisateurs').get();
    await Future.forEach(querySnapshot.docs, (doc) async {
      if (doc["pseudo"] == userPseudo) {
        await Future.forEach(doc["amis"], (dynamic a) async {
          url = await recupUrl(a);
          abonnement.add(Amis(a, url));
        });
      }
    });
    return abonnement;
  }

  void showClubList(BuildContext context) async {
    List<String> clubs = await fetchClubFromFirebase();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Vos clubs suivis'),
          content: SingleChildScrollView(
            child: ListBody(
              children: clubs.map((club) {
                return Container(
                  child: Column(
                    children: [
                      Row(
                      children: [
                        Image.asset('assets/${club}.png', width: 30, height: 30) ,// Ici vous pouvez remplacer l'icône par votre propre image/logo
                        SizedBox(width: 10), // Espacement entre l'icône et le titre
                        Text(club,style: TextStyle(fontSize: 15)),
                      ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
   Future<List<String>> fetchClubFromFirebase() async {
    List<String> club = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('utilisateurs').get();
    querySnapshot.docs.forEach((doc) {
      if(doc["pseudo"] == userPseudo){
        List<dynamic> clubData = doc['club'];
        club = clubData.map((c) => c.toString()).toList();
      }
    });
    return club;
  }

  void showLigueList(BuildContext context) async {
    List<String> ligues = await fetchLigueFromFirebase();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Vos ligues suivis'),
          content: SingleChildScrollView(
            child: ListBody(
              children: ligues.map((ligue) {
                return Container(
                  child: Column( 
                    children: [
                      Row(
                      children: [
                        Image.asset('assets/${ligue}.png', width: 30, height: 30) ,// Ici vous pouvez remplacer l'icône par votre propre image/logo
                        SizedBox(width: 10), // Espacement entre l'icône et le titre
                        Text(ligue,style: TextStyle(fontSize: 15)),
                      ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
  Future<List<String>> fetchLigueFromFirebase() async {
    List<String> ligue = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('utilisateurs').get();
    querySnapshot.docs.forEach((doc) {
      if(doc["pseudo"] == userPseudo){
        List<dynamic> ligueData = doc['club'];
        ligue = ligueData.map((l) => l.toString()).toList();
      }
    });
    return ligue;
  }
  void addUser() async {
    try {
      final userRef = FirebaseFirestore.instance.collection('utilisateurs').doc(myUserID);
      await userRef.update({'amis': FieldValue.arrayUnion([userPseudo])});
      print('Amis mis à jour avec succès dans Firebase !');
    } catch (error) {
      print('Erreur lors de la mise à jour des amis dans Firebase: $error');
    }
  }
  void removeUser() async {
    try {
      final userRef = FirebaseFirestore.instance.collection('utilisateurs').doc(myUserID);
      await userRef.update({'amis': FieldValue.arrayRemove([userPseudo])});
      print('Amis retiré avec succès de Firebase !');
    } catch (error) {
      print('Erreur lors de la suppression des amis de Firebase: $error');
    }
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
              const SizedBox(height: 10),
              const Text(
                "Matchs",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ExpansionTile(
              title: Row( children: [
              Image.asset(
                'assets/Ligue 1.png',
                width: 50,
                height:50,
              ),
              const Text(
                'Ligue 1',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),],),

              children: <Widget>[
              InkWell(
                onTap: (){},
                child: Card(
            elevation: 5,
            child: Container(
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
                              children: [
                                Text(
                                  '${data['Date'].toDate().day}/${data['Date'].toDate().month}/${data['Date'].toDate().year} (Journée ${data['Journée']} sur 34) : ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )
                                ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Logo de l'équipe A
                                      Image.asset(
                                        'assets/${data['Equipe A']}.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                      // Nom de l'équipe A
                                      Text(
                                        ' ${data['Equipe A']} ',
                                        style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10), // Espacement entre le nom de l'équipe A et le score
                                  // Score du match
                                  Text(
                                    '$goalsTeamA - $goalsTeamB',
                                    style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 10), // Espacement entre le score et le nom de l'équipe B
                                  // Nom de l'équipe B
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Nom de l'équipe B
                                      Text(
                                        ' ${data['Equipe B']} ',
                                        style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),
                                      ),
                                      // Logo de l'équipe B
                                      Image.asset(
                                        'assets/${data['Equipe B']}.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ]
                              ), // Espacement à la fin
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
          ),
              ],
              ),
          const SizedBox(height: 20),
          ExpansionTile(
          title: Row( children: [
              Image.asset(
                'assets/Premier League.png',
                width: 50,
                height:50,
              ),
              const Text(
                'Premier League',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),],),
              
              children: <Widget>[
              InkWell(
                onTap: (){},
                child: Card(
            elevation: 5,
            child: Container(
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
                              children: [
                                Text(
                                  '${data['Date'].toDate().day}/${data['Date'].toDate().month}/${data['Date'].toDate().year} (Journée ${data['Journée']} sur 38) : ',
                                  style: const TextStyle(fontWeight: FontWeight.bold,),
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Logo de l'équipe A
                                    Image.asset(
                                      'assets/${data['Equipe A']}.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                    // Nom de l'équipe A
                                    Text(
                                      ' ${data['Equipe A']} ',
                                      style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10), // Espacement entre le nom de l'équipe A et le score
                                // Score du match
                                Text(
                                  '$goalsTeamA - $goalsTeamB',
                                  style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),
                                ),
                                const SizedBox(width: 10), // Espacement entre le score et le nom de l'équipe B
                                // Nom de l'équipe B
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Nom de l'équipe B
                                    Text(
                                      ' ${data['Equipe B']} ',
                                      style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),
                                    ),
                                    // Logo de l'équipe B
                                    Image.asset(
                                      'assets/${data['Equipe B']}.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ]
                            ),
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
              ),
              ],
          ),
          const SizedBox(height: 20),
          ExpansionTile(
          title: Row( children: [
              Image.asset(
                'assets/La Liga.png',
                width: 50,
                height:50,
              ),
              const Text(
                'La Liga',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),],),
              
              children: <Widget>[
              InkWell(
                onTap: (){},
                child: Card(
            elevation: 5,
            child: Container(
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
                              children: [
                                Text(
                                  '${data['Date'].toDate().day}/${data['Date'].toDate().month}/${data['Date'].toDate().year} (Journée ${data['Journée']} sur 38) : ',
                                  style: const TextStyle(fontWeight: FontWeight.bold,)
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Logo de l'équipe A
                                    Image.asset(
                                      'assets/${data['Equipe A']}.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                    // Nom de l'équipe A
                                    Text(
                                      ' ${data['Equipe A']} ',
                                      style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10), // Espacement entre le nom de l'équipe A et le score
                                // Score du match
                                Text(
                                  '$goalsTeamA - $goalsTeamB',
                                  style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),
                                ),
                                const SizedBox(width: 10), // Espacement entre le score et le nom de l'équipe B
                                // Nom de l'équipe B
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Nom de l'équipe B
                                    Text(
                                      ' ${data['Equipe B']} ',
                                      style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),
                                    ),
                                    // Logo de l'équipe B
                                    Image.asset(
                                      'assets/${data['Equipe B']}.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ]
                            ),
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
              ),
              ],
          ),
          const SizedBox(height: 20),
          ExpansionTile(
          title: Row( children: [
              Image.asset(
                'assets/Serie A.png',
                width: 50,
                height:50,
              ),
              const Text(
                'Serie A',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),],),
              
              children: <Widget>[
              InkWell(
                onTap: (){},
                child: Card(
            elevation: 5,
            child: Container(
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
                              children: [
                                Text(
                                  '${data['Date'].toDate().day}/${data['Date'].toDate().month}/${data['Date'].toDate().year} (Journée ${data['Journée']} sur 38) : ',
                                  style: const TextStyle(fontWeight: FontWeight.bold,)
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Logo de l'équipe A
                                    Image.asset(
                                      'assets/${data['Equipe A']}.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                    // Nom de l'équipe A
                                    Text(
                                      ' ${data['Equipe A']} ',
                                      style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10), // Espacement entre le nom de l'équipe A et le score
                                // Score du match
                                Text(
                                  '$goalsTeamA - $goalsTeamB',
                                  style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),
                                ),
                                const SizedBox(width: 10), // Espacement entre le score et le nom de l'équipe B
                                // Nom de l'équipe B
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Nom de l'équipe B
                                    Text(
                                      ' ${data['Equipe B']} ',
                                      style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),
                                    ),
                                    // Logo de l'équipe B
                                    Image.asset(
                                      'assets/${data['Equipe B']}.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ]
                            ),
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
              ),
              ],
          ),
          const SizedBox(height: 20),
          ExpansionTile(
          title: Row( children: [
              Image.asset(
                'assets/Bundesliga.png',
                width: 50,
                height:50,
              ),
              const Text(
                'Bundesliga',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),],),
              
              children: <Widget>[
              InkWell(
                onTap: (){},
                child: Card(
            elevation: 5,
            child: Container(
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
                              children: [
                                Text(
                                  '${data['Date'].toDate().day}/${data['Date'].toDate().month}/${data['Date'].toDate().year} (Journée ${data['Journée']} sur 34) : ',
                                  style: const TextStyle(fontWeight: FontWeight.bold,)
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Logo de l'équipe A
                                    Image.asset(
                                      'assets/${data['Equipe A']}.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                    // Nom de l'équipe A
                                    Text(
                                      ' ${data['Equipe A']} ',
                                      style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10), // Espacement entre le nom de l'équipe A et le score
                                // Score du match
                                Text(
                                  '$goalsTeamA - $goalsTeamB',
                                  style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),
                                ),
                                const SizedBox(width: 10), // Espacement entre le score et le nom de l'équipe B
                                // Nom de l'équipe B
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Nom de l'équipe B
                                    Text(
                                      ' ${data['Equipe B']} ',
                                      style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),
                                    ),
                                    // Logo de l'équipe B
                                    Image.asset(
                                      'assets/${data['Equipe B']}.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ]
                            ),
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
    CollectionReference match = FirebaseFirestore.instance.collection('match');
    CollectionReference article = FirebaseFirestore.instance.collection('article');
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    Future<List<String>> getUserFollowClub() async {
      List<String> followClub = [];
      DocumentSnapshot<Map<String, dynamic>> userFollowClub =
          await FirebaseFirestore.instance.collection('utilisateurs').doc(userId).get();
      followClub = List.from(userFollowClub['club']);
      return followClub;
    }

    Future<List<String>> getUserFollowLeague() async {
      List<String> followLeague = [];
      DocumentSnapshot<Map<String, dynamic>> userFollowLeague =
          await FirebaseFirestore.instance.collection('utilisateurs').doc(userId).get();
      followLeague = List.from(userFollowLeague['ligue']);
      return followLeague;
    }

    return Container(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: StreamBuilder<QuerySnapshot>(
                  stream: article.orderBy('Date', descending: true).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> articleSnapshot) {
                    if (articleSnapshot.hasError) {
                      print("Error: ${articleSnapshot.error}");
                      return const Text("Something went wrong");
                    }

                    if (articleSnapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Affichez un indicateur de chargement pendant le chargement
                    }

                    if (articleSnapshot.hasData && articleSnapshot.data!.docs.isEmpty) {
                      return const Text("No article available");
                    }

                    List<QueryDocumentSnapshot> allDocuments = articleSnapshot.data!.docs.toList();

                    return StreamBuilder<QuerySnapshot>(
                      stream: match.orderBy('Date', descending: true).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> matchSnapshot) {
                        if (matchSnapshot.hasError) {
                          print("Error: ${matchSnapshot.error}");
                          return const Text("Something went wrong");
                        }

                        if (matchSnapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Affichez un indicateur de chargement pendant le chargement
                        }

                        if (matchSnapshot.hasData && matchSnapshot.data!.docs.isEmpty) {
                          return const Text("No match available");
                        }

                        allDocuments.addAll(matchSnapshot.data!.docs);

                        allDocuments.sort((a, b) => (b['Date'] as Timestamp).compareTo(a['Date'] as Timestamp));

                        return FutureBuilder(
                          future: Future.wait([getUserFollowClub(), getUserFollowLeague()]),
                          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> userSnapshot) {
                            if (userSnapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }

                            List<String> followClubs = userSnapshot.data![0];
                            List<String> followLeagues = userSnapshot.data![1];
                            List<QueryDocumentSnapshot> filtered = allDocuments.where((match) {
                              DateTime matchDate = (match['Date'] as Timestamp).toDate();
                              return matchDate.isBefore(DateTime.now());
                            }).toList();
                            List<QueryDocumentSnapshot> filteredMatches = allDocuments
                              .where((match) {
                                DateTime matchDate = (match['Date'] as Timestamp).toDate();
                                return matchDate.isAfter(DateTime.now());
                              })
                              .toList();

                            filteredMatches.sort((a, b) {
                              DateTime dateA = (a['Date'] as Timestamp).toDate();
                              DateTime dateB = (b['Date'] as Timestamp).toDate();
                              return dateA.compareTo(dateB);
                            });

                            // Prendre le premier élément de la liste (le match le plus proche de la date actuelle)
                            if (filteredMatches.isNotEmpty) {
                              filteredMatches = [filteredMatches.first];
                            }

                        return Column(
                        children: [
                          filteredMatches.isNotEmpty
                            ? Column (
                              children: [const Text(
                              "Prochain match",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            const SizedBox(height: 5),
                            ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: filteredMatches.map((document) {
                              if (document.reference.parent.id == 'article') {
                                // Si le document provient de la collection 'article'
                                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                                List<String> paragraphes = List.from(data['Paragraphes']);
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20), // Ajoute de l'espace entre chaque Card
                                  child: InkWell(
                                    onTap: (){_showArticleContent(context,data,paragraphes);},
                                    child: Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10), // Ajoute de l'espace entre le contenu et les bords de la Card
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data['Titre'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: paragraphes.map((paragraphe) {
                                          if (paragraphe.endsWith(".jpg")) {
                                            // Si le paragraphe se termine par ".jpg", afficher une image
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 5), // Ajoute de l'espace entre chaque paragraphe
                                              child: Column(children: [Image.network(
                                                paragraphe,
                                              ),const Text("...")]
                                            ));
                                          } else {
                                            // Sinon, afficher du texte
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 5), // Ajoute de l'espace entre chaque paragraphe
                                              child: Column(children: [Text("$paragraphe ...")])
                                            );
                                          }
                                        }).take(1).toList(),
                                      ),
                                      ],
                                    ),
                                  ),
                                )));
                              } else if (document.reference.parent.id == 'match') {
                                // Si le document provient de la collection 'match'
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
                        if (followClubs.contains(data['Equipe A']) ||
                          followClubs.contains(data['Equipe B']) ||
                          followLeagues.contains(data['Compet'])) {
                        return Padding(
                            padding: const EdgeInsets.only(bottom: 20), // Ajoute de l'espace entre chaque Card
                            child: InkWell( 
                              onTap: (){},
                              child: Card(
                            color: Colors.white,
                            elevation: 5,
                            child: Column(
                            children: [
                              Padding(
    padding: const EdgeInsets.all(10), // Ajoute de l'espace entre le contenu et les bords de la Card
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${data['Compet']} - ${data['Date'].toDate().day}/${data['Date'].toDate().month}/${data['Date'].toDate().year} (Journée ${data['Journée']} sur 34)',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        FutureBuilder(
          future: Future.wait([countGoalsTeamA(), countGoalsTeamB()]),
          builder: (BuildContext context, AsyncSnapshot<List<int>> goalsSnapshot) {
            if (goalsSnapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            int goalsTeamA = goalsSnapshot.data![0];
            int goalsTeamB = goalsSnapshot.data![1];

            return Row(
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
              ],
            );
          },
        ),
        const SizedBox(height: 20), // Espacement à la fin
      ],
    ),
  )
                            ]
                          ),
                          )));
                      } else{
                        // Handle other content types if any
                        return Container();
                      }}}).whereType<Widget>().toList()),
                      const SizedBox(height: 5),
                      const Divider(
                        thickness: 2.0, // Épaisseur de la ligne
                        height: 0, // Hauteur de la ligne (0 pour une ligne horizontale)
                        indent: 20, // Marge à gauche
                        endIndent: 20, // Marge à droite
                      ),
                      const SizedBox(height: 10),
                        ])
                        : Container(),
                    const Text(
                      "Accueil",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 5),
                        ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: filtered.map((document) {
                            if (document.reference.parent.id == 'article') {
                              // Si le document provient de la collection 'article'
                              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                              List<String> paragraphes = List.from(data['Paragraphes']);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20), // Ajoute de l'espace entre chaque Card
                                child: InkWell(
                                  onTap: (){_showArticleContent(context,data,paragraphes);},
                                  child: Card(
                                color: Colors.white,
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(10), // Ajoute de l'espace entre le contenu et les bords de la Card
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['Titre'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: paragraphes.map((paragraphe) {
                                          if (paragraphe.endsWith(".jpg")) {
                                            // Si le paragraphe se termine par ".jpg", afficher une image
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 5), // Ajoute de l'espace entre chaque paragraphe
                                              child: Column(children: [Image.network(
                                                paragraphe,
                                              ),const Text("...")]
                                            ));
                                          } else {
                                            // Sinon, afficher du texte
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 5), // Ajoute de l'espace entre chaque paragraphe
                                              child: Column(children: [Text("$paragraphe ...")])
                                            );
                                          }
                                        }).take(1).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              )));
                            } else if (document.reference.parent.id == 'match') {
                              // Si le document provient de la collection 'match'
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
                      if (followClubs.contains(data['Equipe A']) ||
                        followClubs.contains(data['Equipe B']) ||
                        followLeagues.contains(data['Compet'])) {
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 20), // Ajoute de l'espace entre chaque Card
                          child: InkWell(
                            onTap: (){},
                            child: Card(
                          color: Colors.white,
                          elevation: 5,
                          child: Column(
                          children: [
                            Padding(
  padding: const EdgeInsets.all(10), // Ajoute de l'espace entre le contenu et les bords de la Card
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        '${data['Compet']} - ${data['Date'].toDate().day}/${data['Date'].toDate().month}/${data['Date'].toDate().year} (Journée ${data['Journée']} sur 34)',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      FutureBuilder(
        future: Future.wait([countGoalsTeamA(), countGoalsTeamB()]),
        builder: (BuildContext context, AsyncSnapshot<List<int>> goalsSnapshot) {
          if (goalsSnapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          int goalsTeamA = goalsSnapshot.data![0];
          int goalsTeamB = goalsSnapshot.data![1];

          return Row(
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
            ],
          );
        },
      ),
      const SizedBox(height: 20), // Espacement à la fin
    ],
  ),
)
                          ]
                        ),
                        )));
                    } else{
                      // Handle other content types if any
                      return Container();
                    }}}).whereType<Widget>().toList())]);
                    });}
                    );
                    },
                )
              )
            ]
          )
        )
      )
    );
  }
   void _showArticleContent(BuildContext context, Map<String, dynamic> data, List<String> paragraphes) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['Titre'], // Assurez-vous que 'data' est accessible ici
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: paragraphes.map((paragraphe) {
                    if (paragraphe.endsWith(".jpg")) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Image.network(paragraphe),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(paragraphe),
                      );
                    }
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
}

class Classement extends StatelessWidget {
  const Classement({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference listeMatch = FirebaseFirestore.instance.collection('match');

    return Container(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children:[
              const SizedBox(height: 10),
              const Text(
                "Classement",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ExpansionTile(
              title: Row( children: [
              Image.asset(
                'assets/Ligue 1.png',
                width: 50,
                height:50,
              ),
              const Text(
                'Ligue 1',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),],),

              children: <Widget>[
              Card(
            elevation: 5,
            child: FutureBuilder<QuerySnapshot>(
  future: listeMatch.where('Compet', isEqualTo: 'Ligue 1').get(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }

    List<DocumentSnapshot> matches = snapshot.data!.docs;
    List<DocumentSnapshot> matchesToday = matches.where((doc) {
      DateTime dateMatch = (doc["Date"] as Timestamp).toDate();
      return dateMatch.isBefore(DateTime.now());
    }).toList();

    Map<String, int> teamPoints = {};
    List<String> clubs = [];

    // Fonction asynchrone pour traiter les matchs
    Future<void> processMatches() async {
      for (var match in matchesToday) {
        int AGoals = 0;
        int BGoals = 0;
        QuerySnapshot butsSnapshot = await FirebaseFirestore.instance
          .collection('match')
          .doc(match.id)
          .collection('but')
          .get();

        butsSnapshot.docs.forEach((butDoc) {
          AGoals = butsSnapshot.docs.where((doc) => doc['Equipe'] == 'A').length;
          BGoals = butsSnapshot.docs.where((doc) => doc['Equipe'] == 'B').length;
        });

        if (AGoals > BGoals) {
          teamPoints[match['Equipe A']] ??= 0;
          teamPoints[match['Equipe A']] = (teamPoints[match['Equipe A']] ?? 0) + 3;
        } else if (AGoals < BGoals) {
          teamPoints[match['Equipe B']] ??= 0;
          teamPoints[match['Equipe B']] = (teamPoints[match['Equipe B']] ?? 0) + 3;
        } else {
          teamPoints[match['Equipe A']] ??= 0;
          teamPoints[match['Equipe A']] = (teamPoints[match['Equipe A']] ?? 0) + 1;

          teamPoints[match['Equipe B']] ??= 0;
          teamPoints[match['Equipe B']] = (teamPoints[match['Equipe B']] ?? 0) + 1;
        }
      }
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Championnat').get();
        querySnapshot.docs.forEach((doc) {
          if(doc.id == "Ligue 1"){
            for(int i = 1;i<=18;i++){
                clubs.add(doc["Equipe $i"]);
            }
          }
        });
      } catch (e) {
        print('Error fetching clubs: $e');
      }
    }

    // Appeler la fonction asynchrone et attendre sa fin
    return FutureBuilder<void>(
      future: processMatches(),
      builder: (BuildContext context, AsyncSnapshot<void> _) {
        // Trier les équipes par points
        List<MapEntry<String, int>> sortedTeams = teamPoints.entries.toList();
        for(String club in clubs){
          bool clubExists = sortedTeams.any((entry) => entry.key == club);
          if(!clubExists){
            sortedTeams.add(MapEntry(club, 0));
          }
        }
        sortedTeams.sort((a, b) => b.value.compareTo(a.value));

        // Retourner le widget ListView une fois que le traitement est terminé
        return ListView.builder(
          shrinkWrap: true,
          itemCount: sortedTeams.length,
          itemBuilder: (context, index) {
            return Row(
              children:[
                Text(
                  '${index+1} )',
                  style: const TextStyle(fontWeight: FontWeight.bold,)
                ),
                Image.asset(
                  'assets/${sortedTeams[index].key}.png',
                  height: 30,
                  width: 30,
                ),
                Text(
                  '${sortedTeams[index].key} : ${sortedTeams[index].value} points',
                  style: const TextStyle(fontWeight: FontWeight.bold,)
                ),
              ]
            );
          },
        );
      },
    );
  },
),
          ),
              ],
              ),
          const SizedBox(height: 20),
          ExpansionTile(
          title: Row( children: [
              Image.asset(
                'assets/Premier League.png',
                width: 50,
                height:50,
              ),
              const Text(
                'Premier League',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),],),
              
              children: <Widget>[
              Card(
            elevation: 5,
            child: FutureBuilder<QuerySnapshot>(
  future: listeMatch.where('Compet', isEqualTo: 'Premier League').get(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }

    List<DocumentSnapshot> matches = snapshot.data!.docs;
    List<DocumentSnapshot> matchesToday = matches.where((doc) {
      DateTime dateMatch = (doc["Date"] as Timestamp).toDate();
      return dateMatch.isBefore(DateTime.now());
    }).toList();

    Map<String, int> teamPoints = {};
    List<String> clubs = [];

    // Fonction asynchrone pour traiter les matchs
    Future<void> processMatches() async {
      for (var match in matchesToday) {
        int AGoals = 0;
        int BGoals = 0;
        QuerySnapshot butsSnapshot = await FirebaseFirestore.instance
          .collection('match')
          .doc(match.id)
          .collection('but')
          .get();

        butsSnapshot.docs.forEach((butDoc) {
          AGoals = butsSnapshot.docs.where((doc) => doc['Equipe'] == 'A').length;
          BGoals = butsSnapshot.docs.where((doc) => doc['Equipe'] == 'B').length;
        });

        if (AGoals > BGoals) {
          teamPoints[match['Equipe A']] ??= 0;
          teamPoints[match['Equipe A']] = (teamPoints[match['Equipe A']] ?? 0) + 3;
        } else if (AGoals < BGoals) {
          teamPoints[match['Equipe B']] ??= 0;
          teamPoints[match['Equipe B']] = (teamPoints[match['Equipe B']] ?? 0) + 3;
        } else {
          teamPoints[match['Equipe A']] ??= 0;
          teamPoints[match['Equipe A']] = (teamPoints[match['Equipe A']] ?? 0) + 1;

          teamPoints[match['Equipe B']] ??= 0;
          teamPoints[match['Equipe B']] = (teamPoints[match['Equipe B']] ?? 0) + 1;
        }
      }
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Championnat').get();
        querySnapshot.docs.forEach((doc) {
          if(doc.id == "Premier League"){
            for(int i = 1;i<=20;i++){
                clubs.add(doc["Equipe $i"]);
            }
          }
        });
      } catch (e) {
        print('Error fetching clubs: $e');
      }
    }

    // Appeler la fonction asynchrone et attendre sa fin
    return FutureBuilder<void>(
      future: processMatches(),
      builder: (BuildContext context, AsyncSnapshot<void> _) {
        // Trier les équipes par points
        List<MapEntry<String, int>> sortedTeams = teamPoints.entries.toList();
        for(String club in clubs){
          bool clubExists = sortedTeams.any((entry) => entry.key == club);
          if(!clubExists){
            sortedTeams.add(MapEntry(club, 0));
          }
        }
        sortedTeams.sort((a, b) => b.value.compareTo(a.value));

        // Retourner le widget ListView une fois que le traitement est terminé
        return ListView.builder(
          shrinkWrap: true,
          itemCount: sortedTeams.length,
          itemBuilder: (context, index) {
            return Row(
              children:[
                Text(
                  '${index+1} )',
                  style: const TextStyle(fontWeight: FontWeight.bold,)
                ),
                Image.asset(
                  'assets/${sortedTeams[index].key}.png',
                  height: 30,
                  width: 30,
                ),
                Text(
                  '${sortedTeams[index].key} : ${sortedTeams[index].value} points',
                  style: const TextStyle(fontWeight: FontWeight.bold,)
                ),
              ]
            );
          },
        );
      },
    );
  },
),
          ),
              ],
          ),
          const SizedBox(height: 20),
          ExpansionTile(
          title: Row( children: [
              Image.asset(
                'assets/La Liga.png',
                width: 50,
                height:50,
              ),
              const Text(
                'La Liga',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),],),
              
              children: <Widget>[
              Card(
            elevation: 5,
            child: FutureBuilder<QuerySnapshot>(
  future: listeMatch.where('Compet', isEqualTo: 'La Liga').get(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }

    List<DocumentSnapshot> matches = snapshot.data!.docs;
    List<DocumentSnapshot> matchesToday = matches.where((doc) {
      DateTime dateMatch = (doc["Date"] as Timestamp).toDate();
      return dateMatch.isBefore(DateTime.now());
    }).toList();

    Map<String, int> teamPoints = {};
    List<String> clubs = [];

    // Fonction asynchrone pour traiter les matchs
    Future<void> processMatches() async {
      for (var match in matchesToday) {
        int AGoals = 0;
        int BGoals = 0;
        QuerySnapshot butsSnapshot = await FirebaseFirestore.instance
          .collection('match')
          .doc(match.id)
          .collection('but')
          .get();

        butsSnapshot.docs.forEach((butDoc) {
          AGoals = butsSnapshot.docs.where((doc) => doc['Equipe'] == 'A').length;
          BGoals = butsSnapshot.docs.where((doc) => doc['Equipe'] == 'B').length;
        });

        if (AGoals > BGoals) {
          teamPoints[match['Equipe A']] ??= 0;
          teamPoints[match['Equipe A']] = (teamPoints[match['Equipe A']] ?? 0) + 3;
        } else if (AGoals < BGoals) {
          teamPoints[match['Equipe B']] ??= 0;
          teamPoints[match['Equipe B']] = (teamPoints[match['Equipe B']] ?? 0) + 3;
        } else {
          teamPoints[match['Equipe A']] ??= 0;
          teamPoints[match['Equipe A']] = (teamPoints[match['Equipe A']] ?? 0) + 1;

          teamPoints[match['Equipe B']] ??= 0;
          teamPoints[match['Equipe B']] = (teamPoints[match['Equipe B']] ?? 0) + 1;
        }
      }
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Championnat').get();
        querySnapshot.docs.forEach((doc) {
          if(doc.id == "La Liga"){
            for(int i = 1;i<=20;i++){
                clubs.add(doc["Equipe $i"]);
            }
          }
        });
      } catch (e) {
        print('Error fetching clubs: $e');
      }
    }

    // Appeler la fonction asynchrone et attendre sa fin
    return FutureBuilder<void>(
      future: processMatches(),
      builder: (BuildContext context, AsyncSnapshot<void> _) {
        // Trier les équipes par points
        List<MapEntry<String, int>> sortedTeams = teamPoints.entries.toList();
        for(String club in clubs){
          bool clubExists = sortedTeams.any((entry) => entry.key == club);
          if(!clubExists){
            sortedTeams.add(MapEntry(club, 0));
          }
        }
        sortedTeams.sort((a, b) => b.value.compareTo(a.value));

        // Retourner le widget ListView une fois que le traitement est terminé
        return ListView.builder(
          shrinkWrap: true,
          itemCount: sortedTeams.length,
          itemBuilder: (context, index) {
            return Row(
              children:[
                Text(
                  '${index+1} )',
                  style: const TextStyle(fontWeight: FontWeight.bold,)
                ),
                Image.asset(
                  'assets/${sortedTeams[index].key}.png',
                  height: 30,
                  width: 30,
                ),
                Text(
                  '${sortedTeams[index].key} : ${sortedTeams[index].value} points',
                  style: const TextStyle(fontWeight: FontWeight.bold,)
                ),
              ]
            );
          },
        );
      },
    );
  },
),
          ),
              ],
          ),
          const SizedBox(height: 20),
          ExpansionTile(
          title: Row( children: [
              Image.asset(
                'assets/Serie A.png',
                width: 50,
                height:50,
              ),
              const Text(
                'Serie A',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),],),
              
              children: <Widget>[
              Card(
            elevation: 5,
            child: FutureBuilder<QuerySnapshot>(
  future: listeMatch.where('Compet', isEqualTo: 'Serie A').get(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }

    List<DocumentSnapshot> matches = snapshot.data!.docs;
    List<DocumentSnapshot> matchesToday = matches.where((doc) {
      DateTime dateMatch = (doc["Date"] as Timestamp).toDate();
      return dateMatch.isBefore(DateTime.now());
    }).toList();

    Map<String, int> teamPoints = {};
    List<String> clubs = [];

    // Fonction asynchrone pour traiter les matchs
    Future<void> processMatches() async {
      for (var match in matchesToday) {
        int AGoals = 0;
        int BGoals = 0;
        QuerySnapshot butsSnapshot = await FirebaseFirestore.instance
          .collection('match')
          .doc(match.id)
          .collection('but')
          .get();

        butsSnapshot.docs.forEach((butDoc) {
          AGoals = butsSnapshot.docs.where((doc) => doc['Equipe'] == 'A').length;
          BGoals = butsSnapshot.docs.where((doc) => doc['Equipe'] == 'B').length;
        });

        if (AGoals > BGoals) {
          teamPoints[match['Equipe A']] ??= 0;
          teamPoints[match['Equipe A']] = (teamPoints[match['Equipe A']] ?? 0) + 3;
        } else if (AGoals < BGoals) {
          teamPoints[match['Equipe B']] ??= 0;
          teamPoints[match['Equipe B']] = (teamPoints[match['Equipe B']] ?? 0) + 3;
        } else {
          teamPoints[match['Equipe A']] ??= 0;
          teamPoints[match['Equipe A']] = (teamPoints[match['Equipe A']] ?? 0) + 1;

          teamPoints[match['Equipe B']] ??= 0;
          teamPoints[match['Equipe B']] = (teamPoints[match['Equipe B']] ?? 0) + 1;
        }
      }
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Championnat').get();
        querySnapshot.docs.forEach((doc) {
          if(doc.id == "Serie A"){
            for(int i = 1;i<=20;i++){
                clubs.add(doc["Equipe $i"]);
            }
          }
        });
      } catch (e) {
        print('Error fetching clubs: $e');
      }
    }

    // Appeler la fonction asynchrone et attendre sa fin
    return FutureBuilder<void>(
      future: processMatches(),
      builder: (BuildContext context, AsyncSnapshot<void> _) {
        // Trier les équipes par points
        List<MapEntry<String, int>> sortedTeams = teamPoints.entries.toList();
        for(String club in clubs){
          bool clubExists = sortedTeams.any((entry) => entry.key == club);
          if(!clubExists){
            sortedTeams.add(MapEntry(club, 0));
          }
        }
        sortedTeams.sort((a, b) => b.value.compareTo(a.value));

        // Retourner le widget ListView une fois que le traitement est terminé
        return ListView.builder(
          shrinkWrap: true,
          itemCount: sortedTeams.length,
          itemBuilder: (context, index) {
            return Row(
              children:[
                Text(
                  '${index+1} )',
                  style: const TextStyle(fontWeight: FontWeight.bold,)
                ),
                Image.asset(
                  'assets/${sortedTeams[index].key}.png',
                  height: 30,
                  width: 30,
                ),
                Text(
                  '${sortedTeams[index].key} : ${sortedTeams[index].value} points',
                  style: const TextStyle(fontWeight: FontWeight.bold,)
                ),
              ]
            );
          },
        );
      },
    );
  },
),
          ),
              ],
          ),
          const SizedBox(height: 20),
          ExpansionTile(
          title: Row( children: [
              Image.asset(
                'assets/Bundesliga.png',
                width: 50,
                height:50,
              ),
              const Text(
                'Bundesliga',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),],),
              
              children: <Widget>[
              Card(
            elevation: 5,
            child: FutureBuilder<QuerySnapshot>(
  future: listeMatch.where('Compet', isEqualTo: 'Bundesliga').get(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }

    List<DocumentSnapshot> matches = snapshot.data!.docs;
    List<DocumentSnapshot> matchesToday = matches.where((doc) {
      DateTime dateMatch = (doc["Date"] as Timestamp).toDate();
      return dateMatch.isBefore(DateTime.now());
    }).toList();

    Map<String, int> teamPoints = {};
    List<String> clubs = [];

    // Fonction asynchrone pour traiter les matchs
    Future<void> processMatches() async {
      for (var match in matchesToday) {
        int AGoals = 0;
        int BGoals = 0;
        QuerySnapshot butsSnapshot = await FirebaseFirestore.instance
          .collection('match')
          .doc(match.id)
          .collection('but')
          .get();

        butsSnapshot.docs.forEach((butDoc) {
          AGoals = butsSnapshot.docs.where((doc) => doc['Equipe'] == 'A').length;
          BGoals = butsSnapshot.docs.where((doc) => doc['Equipe'] == 'B').length;
        });

        if (AGoals > BGoals) {
          teamPoints[match['Equipe A']] ??= 0;
          teamPoints[match['Equipe A']] = (teamPoints[match['Equipe A']] ?? 0) + 3;
        } else if (AGoals < BGoals) {
          teamPoints[match['Equipe B']] ??= 0;
          teamPoints[match['Equipe B']] = (teamPoints[match['Equipe B']] ?? 0) + 3;
        } else {
          teamPoints[match['Equipe A']] ??= 0;
          teamPoints[match['Equipe A']] = (teamPoints[match['Equipe A']] ?? 0) + 1;

          teamPoints[match['Equipe B']] ??= 0;
          teamPoints[match['Equipe B']] = (teamPoints[match['Equipe B']] ?? 0) + 1;
        }
      }
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Championnat').get();
        querySnapshot.docs.forEach((doc) {
          if(doc.id == "Bundesliga"){
            for(int i = 1;i<=18;i++){
                clubs.add(doc["Equipe $i"]);
            }
          }
        });
      } catch (e) {
        print('Error fetching clubs: $e');
      }
    }

    // Appeler la fonction asynchrone et attendre sa fin
    return FutureBuilder<void>(
      future: processMatches(),
      builder: (BuildContext context, AsyncSnapshot<void> _) {
        // Trier les équipes par points
        List<MapEntry<String, int>> sortedTeams = teamPoints.entries.toList();
        for(String club in clubs){
          bool clubExists = sortedTeams.any((entry) => entry.key == club);
          if(!clubExists){
            sortedTeams.add(MapEntry(club, 0));
          }
        }
        sortedTeams.sort((a, b) => b.value.compareTo(a.value));

        // Retourner le widget ListView une fois que le traitement est terminé
        return ListView.builder(
          shrinkWrap: true,
          itemCount: sortedTeams.length,
          itemBuilder: (context, index) {
            return Row(
              children:[
                Text(
                  '${index+1} )',
                  style: const TextStyle(fontWeight: FontWeight.bold,)
                ),
                Image.asset(
                  'assets/${sortedTeams[index].key}.png',
                  height: 30,
                  width: 30,
                ),
                Text(
                  '${sortedTeams[index].key} : ${sortedTeams[index].value} points',
                  style: const TextStyle(fontWeight: FontWeight.bold,)
                ),
              ]
            );
          },
        );
      },
    );
  },
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

Future<String> RecupPseudoUtilisateur() async {
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  if (userId != null) {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore.instance
        .collection('utilisateurs')
        .doc(userId)
        .get();

    if (userSnapshot.exists) {
      return userSnapshot.data()?['pseudo'] ?? 'Pseudo inconnu';
    } else {
      return 'Pseudo inconnu';
    }
  } else {
    return 'Pseudo inconnu';
  }
}


class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
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
                Navigator.of(context).pop(); 
              },
            ),
            TextButton(
              child: const Text('Se déconnecter'),
              onPressed: () {
                FirebaseAuth.instance.signOut(); 
                Navigator.of(context).pop(); 
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
    const Classement(),
    const Settings(),
  ];

   void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return const MaterialApp(
        home: MyApp(),
        debugShowCheckedModeBanner: false,
      );
    } else {
      return MaterialApp(
        title: 'Main Page',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
  actions: [
    Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/Logo_Footbest.png',
          ),
        ],
      ),
    ),
    if (_selectedIndex == 2) // Afficher dans l'onglet Profil uniquement
      FutureBuilder(
        future: RecupPseudoUtilisateur(), // Supposons que cette méthode obtient le pseudo de l'utilisateur actuel
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(); // Afficher un widget vide pendant le chargement
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                snapshot.data!,
                style: const TextStyle(fontSize: 16),
              ),
            );
          } else {
            return const SizedBox(); // Afficher un widget vide si aucune donnée n'est disponible
          }
        },
      ),
    if (_selectedIndex == 2) // Afficher dans l'onglet Profil uniquement
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
                icon: Icon(Icons.emoji_events),
                label: 'Classement',
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
