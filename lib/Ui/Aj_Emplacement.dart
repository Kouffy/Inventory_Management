import 'package:flutter/material.dart';
import 'package:inventory_management/Core/Controllers/EmplacementController.dart';
import 'package:inventory_management/Core/Models/Emplacement.dart';
import 'package:inventory_management/Toasts.dart';
import 'package:inventory_management/Ui/Aj_Sous_Emplacement.dart';

class AjouterEmplacement extends StatefulWidget {
  final Emplacement emplacement;
  AjouterEmplacement(this.emplacement);
  @override
  _AjouterEmplacementState createState() =>
      _AjouterEmplacementState(emplacement);
}

class _AjouterEmplacementState extends State<AjouterEmplacement> {
  Emplacement emplacement;
  _AjouterEmplacementState(this.emplacement);
  TextEditingController libelleController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (this.emplacement != null)
      libelleController.text = this.emplacement.libelleEmplacement;
    return Scaffold(
        appBar: new AppBar(
          title: Text('Nouvel Emplacement'),
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
                  labelText: 'libelle de l\'emplacement',
                  hintText: 'Entrer le libelle de l\'emplacement',
                ),
              ),
            ),
            RaisedButton(
              child: Text(
                this.emplacement == null ? "Ajouter" : "Modifier",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () => this.emplacement != null
                  ? modifierEmplacement(this.emplacement)
                  : enregistrerEmplacement(),
              color: Colors.green,
              textColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.grey,
            ),
          ]),
        ));
  }

  void enregistrerEmplacement() async {
    Emplacement emplacement = new Emplacement(libelleController.text, null, 0);
    var saveResponse = await EmplacementController.postEmplacement(emplacement);
    saveResponse == true
        ? Toasts.showSucssesToast('Ajouté avec succès')
        : Toasts.showFailedToast('une erreur est produite');
    Navigator.pop(context);
  }

  void modifierEmplacement(Emplacement emplacement) async {
    emplacement.libelleEmplacement = libelleController.text;
    var saveResponse = await EmplacementController.putEmplacement(emplacement);
    saveResponse == true
        ? Toasts.showSucssesToast("modifié avec succès")
        : Toasts.showFailedToast("Erreur");
  }
}
