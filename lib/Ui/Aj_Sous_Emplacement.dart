import 'package:flutter/material.dart';
import 'package:inventory_management/Core/Controllers/EmplacementController.dart';
import 'package:inventory_management/Core/Models/Emplacement.dart';
import 'package:inventory_management/Toasts.dart';

class AjouterSousEmplacement extends StatefulWidget {
  final int id;
  final String libelle;
  AjouterSousEmplacement(this.id,this.libelle);
  @override
  _AjouterSousEmplacementState createState() => _AjouterSousEmplacementState(id,libelle);
}

class _AjouterSousEmplacementState extends State<AjouterSousEmplacement> {
  int id;
  String libelle;
  _AjouterSousEmplacementState(this.id,this.libelle);
  TextEditingController libelleController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text('Nouvel Sous Emplacement du $libelle'),
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: libelleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'libelle du sous emplacement',
                  hintText: 'Entrer le libelle du sous emplacement',
                ),
              ),
            ),
            RaisedButton(
              child: Text(
                "Ajouter",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () => enregistrerEmplacement(),
              color: Colors.green,
              textColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.grey,
            ),
          ]),
        ));
  }
  
    void enregistrerEmplacement() async {
     Emplacement emplacement = new Emplacement(libelleController.text,id,1);
    var saveResponse = await EmplacementController.postEmplacement(emplacement);
    saveResponse == true
        ? Toasts.showSucssesToast('Ajouté avec succès')
        : Toasts.showFailedToast('une erreur est produite');
        Navigator.pop(context);
  }
}