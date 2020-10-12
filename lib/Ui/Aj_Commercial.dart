import 'package:flutter/material.dart';
import 'package:inventory_management/Core/Controllers/CommercialController.dart';
import 'package:inventory_management/Core/Models/Commercial.dart';
import 'package:inventory_management/Toasts.dart';
class AjouterCommercial extends StatefulWidget {
  final Commercial commercial;
  AjouterCommercial(this.commercial);
  @override
  _AjouterCommercialState createState() => _AjouterCommercialState(commercial);
}

class _AjouterCommercialState extends State<AjouterCommercial> {
  TextEditingController nomController = new TextEditingController();
   TextEditingController prenomController = new TextEditingController();
    TextEditingController loginController = new TextEditingController();
     TextEditingController passwordController = new TextEditingController();
  Commercial commercial;
  _AjouterCommercialState(this.commercial);
  @override
  Widget build(BuildContext context) {
    if(this.commercial != null)
    {
      nomController.text = this.commercial.nomCommercial;
      prenomController.text = this.commercial.passwordCommercial;
      loginController.text = this.commercial.loginCommercial;
      passwordController.text = this.commercial.passwordCommercial;
    }
    return  Scaffold(
        appBar: new AppBar(
          title: Text('Ajouter Commercial'),
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: ListView(children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: nomController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'nom',
                  hintText: 'Enter le nom',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: prenomController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'prenom',
                  hintText: 'Enter prenom',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: loginController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'login',
                  hintText: 'Entrer le login',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'password',
                  hintText: 'Enter password',
                ),
              ),
            ),
            RaisedButton(
              child: Text(
                this.commercial != null ? "modifier" : "ajouter",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () => this.commercial != null ? modifierCommercial(commercial) : enregistrerCommercial(),
              color: Colors.green,
              textColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.grey,
            ),
            
          ]),
        ));
  }
    void enregistrerCommercial() async {
    Commercial article = new Commercial(nomController.text,prenomController.text,loginController.text,passwordController.text);
    var saveResponse = await CommercialController.postCommercial(article);
    saveResponse == true
        ? Toasts.showSucssesToast('Ajouté avec succès')
        : Toasts.showFailedToast('une erreur est produite');
    Navigator.pop(context);
  }

  void modifierCommercial(Commercial commercial) async {
    commercial.nomCommercial = nomController.text;
    commercial.prenomCommercial = prenomController.text;
    commercial.loginCommercial = loginController.text;
    commercial.passwordCommercial = passwordController.text;
    var saveResponse = await CommercialController.putCommercial(commercial);
    saveResponse == true
        ? Toasts.showSucssesToast("modifié avec succès")
        : Toasts.showFailedToast("Erreur");
  }
}
