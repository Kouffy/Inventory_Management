import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inventory_management/Core/Controllers/ArticleController.dart';
import 'package:inventory_management/Core/Controllers/CommercialController.dart';
import 'package:inventory_management/Core/Models/Commercial.dart';
import 'package:inventory_management/Toasts.dart';
import 'package:inventory_management/Ui/Aj_Commercial.dart';
import 'package:inventory_management/Ui/Navigation.dart';

class ListeComerciaux extends StatefulWidget {
  @override
  _ListeComerciauxState createState() => _ListeComerciauxState();
}

class _ListeComerciauxState extends State<ListeComerciaux> {
  List<Commercial> listCommerciaux;
  getComerciaux() {
    CommercialController.getCommercial().then((response) {
      Iterable list = json.decode(response.body);
      List<Commercial> comercialList = List<Commercial>();
      comercialList =
          list.map((model) => Commercial.fromObject(model)).toList();
      if (this.mounted) {
        setState(() {
          listCommerciaux = comercialList;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getComerciaux();
    return Scaffold(
      floatingActionButton: _buildFloatingButton(),
      appBar: AppBar(
        title: Text('Les Commerciaux'),
      ),
      body: (listCommerciaux == null || listCommerciaux.length == 0)
          ? Center(
              child: Text('Aucun elemnet a afficher'),
            )
          : _buildCommerciauxList(),
    );
  }

  Widget _buildCommerciauxList() {
    return ListView.builder(
      itemCount: listCommerciaux.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            child: Card(
              child: ListTile(
                title: Text(listCommerciaux[index].nomCommercial +
                    " " +
                    listCommerciaux[index].prenomCommercial),
                leading: Image.asset(
                  "assets/images/emplacement.png",
                  height: 40,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RaisedButton(
                      child: Text(
                        "Modifier",
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () => Navigation.navigateToWidget(
                          context, AjouterCommercial(listCommerciaux[index])),
                      color: Colors.lightBlue,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.grey,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    RaisedButton(
                      child: Text(
                        "Supprimer",
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () => supprimerCommercial(
                          listCommerciaux[index].idCommercial),
                      color: Colors.red,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              // Navigation.navigateToWidget(context, null);
            });
      },
    );
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => AjouterCommercial(null)));
        });
  }

  void supprimerCommercial(int id) async {
    var saveResponse = await CommercialController.deleteCommercial(id);
    saveResponse == true
        ? Toasts.showSucssesToast("supprimé avec succès")
        : Toasts.showFailedToast("Erreur");
  }
}
