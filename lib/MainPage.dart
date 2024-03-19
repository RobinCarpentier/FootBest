import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

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
    return const Center(
        child: Text(
          'Modifier son pseudo',
          style: TextStyle(
            color: Colors.black, // Couleur du texte en noir
            fontWeight: FontWeight.normal, // Poids de la police normal
            decoration: TextDecoration.none,
            fontSize: 18, // Aucune décoration de texte
          ),
        ),
      );
  }
}

class ModifMail extends StatelessWidget {
  const ModifMail({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
          'Modifier son mail',
          style: TextStyle(
            color: Colors.black, // Couleur du texte en noir
            fontWeight: FontWeight.normal, // Poids de la police normal
            decoration: TextDecoration.none,
            fontSize: 18, // Aucune décoration de texte
          ),
        ),
      );
  }
}

class ModifMdp extends StatelessWidget {
  const ModifMdp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
          'Modifier son mot de passe',
          style: TextStyle(
            color: Colors.black, // Couleur du texte en noir
            fontWeight: FontWeight.normal, // Poids de la police normal
            decoration: TextDecoration.none,
            fontSize: 18, // Aucune décoration de texte
          ),
        ),
      );
  }
}

class SupCompte extends StatelessWidget {
  const SupCompte({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
          'Supprimer son compte',
          style: TextStyle(
            color: Colors.black, // Couleur du texte en noir
            fontWeight: FontWeight.normal, // Poids de la police normal
            decoration: TextDecoration.none,
            fontSize: 18, // Aucune décoration de texte
          ),
        ),
      );
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
                  height: MediaQuery.of(context).size.height * 0.5, // Ajustez la hauteur selon vos besoins
                  child: SingleChildScrollView(
                    child: Column(
                      children: _searchResults.map((user) {
                        return ListTile(
                          title: Text(user['pseudo']),
                          onTap: () {
                            Navigator.pop(context); // Fermer la boîte de dialogue de recherche
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserProfilePage(user),
                              ),
                            );
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
      print('Error fetching clubs: $e');
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
      // Gérer l'erreur selon vos besoins
    }
  }
}

class UserProfilePage extends StatelessWidget {
  final DocumentSnapshot user;

  UserProfilePage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil de ${user['pseudo']}'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Add subscription logic here
          },
          child: Text('S\'abonner'),
        ),
      ),
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
                                  '${data['Date'].toDate().day}/${data['Date'].toDate().month}/${data['Date'].toDate().year} (Journée ${data['Journée']} sur 34)',
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
                                  '${data['Date'].toDate().day}/${data['Date'].toDate().month}/${data['Date'].toDate().year} (Journée ${data['Journée']} sur 38)',
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
                                  '${data['Date'].toDate().day}/${data['Date'].toDate().month}/${data['Date'].toDate().year} (Journée ${data['Journée']} sur 38)',
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
                                  '${data['Date'].toDate().day}/${data['Date'].toDate().month}/${data['Date'].toDate().year} (Journée ${data['Journée']} sur 38)',
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
                                  '${data['Date'].toDate().day}/${data['Date'].toDate().month}/${data['Date'].toDate().year} (Journée ${data['Journée']} sur 34)',
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
    CollectionReference match = FirebaseFirestore.instance.collection('match');
    CollectionReference article = FirebaseFirestore.instance.collection('article');

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

                        return ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: allDocuments.map((document) {
                            if (document.reference.parent.id == 'article') {
                              // Si le document provient de la collection 'article'
                              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                              List<String> paragraphes = List.from(data['Paragraphes']);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20), // Ajoute de l'espace entre chaque Card
                                child:Card(
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
                                              child: Image.network(
                                                paragraphe,
                                              ),
                                            );
                                          } else {
                                            // Sinon, afficher du texte
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 5), // Ajoute de l'espace entre chaque paragraphe
                                              child: Text(paragraphe),
                                            );
                                          }
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
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

                      return FutureBuilder(
                        future: Future.wait([countGoalsTeamA(), countGoalsTeamB()]),
                        builder: (BuildContext context, AsyncSnapshot<List<int>> goalsSnapshot) {
                          if (goalsSnapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }

                          int goalsTeamA = goalsSnapshot.data![0];
                          int goalsTeamB = goalsSnapshot.data![1];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20), // Ajoute de l'espace entre chaque Card
                          child:Card(
                          color: Colors.white,
                          elevation: 5,
                          child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  '${data['Compet']} - ${data['Date'].toDate().day}/${data['Date'].toDate().month}/${data['Date'].toDate().year} (Journée ${data['Journée']} sur 34)',
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
                        ],
                      )
                          ]
                        ),
                        ));
                    }
                    );
                    } else{
                      // Handle other content types if any
                      return Container();
                    }}).whereType<Widget>().toList());}
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
    Profile(),
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
          FirebaseAuth.instance.signOut(); // Déconnexion de l'utilisateur
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
