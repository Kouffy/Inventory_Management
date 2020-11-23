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
  FocusNode emailNode=FocusNode() , passwordNode=FocusNode();
  int selectedRadio = 1;
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo_inventory.png",height: 200.0,width: 200.0,),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                  setSelectedRadio(val);
                },
              ),
              Text("Commercial"),
              Radio(
                value: 2,
                groupValue: selectedRadio,
                activeColor: Colors.blue,
                onChanged: (val) {
                  setSelectedRadio(val);
                },
              ),
            ],
          ),
                    Text("Login",style: TextStyle(fontSize: 30,color: Color(0XFF0E2433)),),
                    SizedBox(height: 30,),
                    emailText(),
                    SizedBox(height: 20,),
                    passwordText(),
                    SizedBox(height: 15,),
                    Align(
                      alignment: Alignment.centerRight,
                        child: Text("Mot de pass oublié ?",style: TextStyle(color: Color(0XFF0E2433),fontSize: 12,fontWeight: FontWeight.w500),textAlign: TextAlign.end,)),
                   SizedBox(height: 20,),
                    GestureDetector(
                      onTap: (){
                        if(selectedRadio == 1)
                        {
                          loginInAdmin();
                        }
                        else if(selectedRadio == 2)
                        {
                           loginInCommercial();
                        }
                        else
                        {
                          Toasts.showSucssesToast("Veillez sellectionner le type d'identification");
                        }
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: MediaQuery.of(context).size.width/2,
                          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Color(0XFF0E2433),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0,2),
                                blurRadius: 2
                              )
                            ]
                          ),
                          child:  Text("Login",style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.center,),
                          ),
                      ),
                    ),
                    SizedBox(height: 10.0,)
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
Container emailText() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200],
              blurRadius: 3,
              offset: Offset(0,4),
            )
          ]),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        child:  TextField(style:TextStyle(fontSize: 16,color:Color(0XFF0E2433),fontWeight: FontWeight.w400),
        controller: loginController,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: !emailNode.hasFocus?"Login ou email":null,
            labelText: emailNode.hasFocus?"Login":null,
            labelStyle: TextStyle(color: Colors.grey[600],fontSize: 18,fontWeight: FontWeight.w400),
            hintStyle: TextStyle(fontSize: 15,color: Color(0XFF0E2433),fontWeight: FontWeight.w400),
            fillColor: Colors.grey[500],
            border: emailNode.hasFocus?InputBorder.none:UnderlineInputBorder(),
            prefixIcon:  Icon(Icons.mail_outline,color: Color(0XFF0E2433),),
          ),
          focusNode: emailNode,
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onSubmitted: (value){
            FocusScope.of(context).requestFocus(passwordNode);

          },
        ),
      ),
    );
  }
  Container passwordText() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white70),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              blurRadius: 3,
              offset: Offset(0,3),
            )
          ]),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        child:  TextField(style:TextStyle(fontSize: 14,color: Colors.grey[500],letterSpacing: 2),
        controller: passwordController,
          textAlignVertical: TextAlignVertical.center,
          obscureText: true,
          decoration: InputDecoration(
            border: passwordNode.hasFocus?InputBorder.none:UnderlineInputBorder(),
            hintText: !passwordNode.hasFocus?"*********":null,
            labelText: passwordNode.hasFocus?"Password":null,
            labelStyle: TextStyle(fontSize: 17,color: Color(0XFF0E2433),),
            hintStyle: TextStyle(fontSize: 17,color: Color(0XFF0E2433),letterSpacing: 3),
            fillColor: Colors.grey[500],
            prefixIcon:  Icon(Icons.lock_outline,color: Color(0XFF0E2433),),
          ),
          focusNode: passwordNode,
          maxLines: 1,
          textInputAction: TextInputAction.go,
          onSubmitted: (valeur){
          passwordNode.unfocus();
          },
        ),
      ),
    );
  }
  void loginInAdmin() async {
    try {
      Response userlogedin =
          await AdministrateurController.getAdministrateurLogin(
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
    } catch (e) {
      Toasts.showFailedToast("Serveur indisponible");
    }
  }

  void loginInCommercial() async {
    try {
      Response userlogedin = await CommercialController.getCommercialLogin(
          loginController.text, passwordController.text);
      print(userlogedin.statusCode);
      if (userlogedin.statusCode == 200) {
        var resulat = json.decode(userlogedin.body);
        Commercial user = Commercial.fromObject(resulat);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool('is_logedin', true);
        pref.setInt('id', user.idCommercial);
        pref.setString('nom', user.nomCommercial);
        pref.setString('prenom', user.prenomCommercial);
        Navigation.navigateToWidget(context, HomeCommercial());
      } else {
        Toasts.showFailedToast("Connection échoué");
      }
    } catch (e) {
      Toasts.showFailedToast("Serveur indisponible");
    }
  }
}
