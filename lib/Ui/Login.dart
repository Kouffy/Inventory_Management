import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inventory_management/Core/Controllers/AdministrateurController.dart';
import 'package:inventory_management/Core/Controllers/CommercialController.dart';
import 'package:inventory_management/Core/Models/Administrateur.dart';
import 'package:inventory_management/Core/Models/Commercial.dart';
import 'package:inventory_management/Toasts.dart';
import 'package:inventory_management/Ui/Home.dart';
import 'package:inventory_management/Ui/Home_Commercial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Navigation.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int selectedRadio;
  TextEditingController loginController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  setSelectedRadio(int val) {
  setState(() {
    selectedRadio = val;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Authentification'),
      ),
      body: ListView(
        children: [
          ButtonBar(
  alignment: MainAxisAlignment.center,
  children: <Widget>[
    Text("Admin"),
    Radio(
      value: 1,
      groupValue: selectedRadio,
      activeColor: Colors.green,
      onChanged: (val) {
        print("Radio $val");
        setSelectedRadio(val);
      },
    ),
    Text("Commercial"),
    Radio(
      value: 2,
      groupValue: selectedRadio,
      activeColor: Colors.blue,
      onChanged: (val) {
        print("Radio $val");
        setSelectedRadio(val);
      },
    ),
  ],
),
          TextField(
            controller: loginController,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Login",
                hintStyle: TextStyle(color: Colors.grey[400])),
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.grey[400])),
          ),
          RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              onPressed:() {
                if(selectedRadio==1)
                {
                  loginInAdmin();
                }
                else if(selectedRadio == 2)
                {
                  loginInCommercial();
                }
                else
                {
                  Toasts.showFailedToast("Selectionner le type de votre identité");
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(143, 148, 251, 1),
                      Color.fromRGBO(143, 148, 251, .6),
                    ])),
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text('Se connecter',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
              )),
        ],
      ),
    );
  }
  void loginInAdmin() async {
    try
    {
    Response userlogedin = await AdministrateurController.getAdministrateurLogin(
        loginController.text, passwordController.text);
        print(userlogedin.statusCode);
    if (userlogedin.statusCode == 200) {
      var resulat = json.decode(userlogedin.body);
      Administrateur user = Administrateur.fromObject(resulat);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool('is_logedin', true);
      pref.setInt('id', user.idAdministrateur);
      pref.setString('nom', user.nomAdministrateur);
      pref.setString('prenom', user.prenomAdministrateur);
      Navigation.navigateToWidget(context, Home());
    } else {
      print(userlogedin.statusCode);
      Toasts.showFailedToast("Connection échoué");
    }
    }
    catch(e)
    {
      Toasts.showFailedToast("Serveur indisponible");
    }
  }
   void loginInCommercial() async {
    try
    {
    Response userlogedin = await CommercialController.getCommercialLogin(
        loginController.text, passwordController.text);
        print(userlogedin.statusCode);
    if (userlogedin.statusCode == 200) {
      var resulat = json.decode(userlogedin.body);
      Commercial user = Commercial.fromObject(resulat);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool('is_logedin', true);
      pref.setInt('id', user.id);
      pref.setString('nom', user.nom);
      pref.setString('prenom', user.prenom);
      Navigation.navigateToWidget(context, HomeCommercial());
    } else {
      Toasts.showFailedToast("Connection échoué");
    }
    }
    catch(e)
    {
      Toasts.showFailedToast("Serveur indisponible");
    }
  }
}
