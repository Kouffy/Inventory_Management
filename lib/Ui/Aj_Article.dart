import 'package:flutter/material.dart';
import 'package:inventory_management/Core/Controllers/ArticleController.dart';
import 'package:inventory_management/Core/Models/Article.dart';
import 'package:inventory_management/Toasts.dart';

class AjouterArticle extends StatefulWidget {
    final int id;
  final String libelle;
  AjouterArticle(this.id,this.libelle);
  @override
  _AjouterArticleState createState() => _AjouterArticleState(id,libelle);
}

class _AjouterArticleState extends State<AjouterArticle> {
    int id;
  String libelle;
  _AjouterArticleState(this.id,this.libelle);
  TextEditingController libelleController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text('Nouvel Article dans $libelle'),
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
                  labelText: 'libelle de l\'Article',
                  hintText: 'Entrer le libelle de l\'Article',
                ),
              ),
            ),
            RaisedButton(
              child: Text(
                "Ajouter",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () => enregistrerArticle(),
              color: Colors.green,
              textColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.grey,
            ),
          ]),
        ));
  }
    void enregistrerArticle() async {
     Article article = new Article(libelleController.text,id);
    var saveResponse = await ArticleController.postArticle(article);
    saveResponse == true
        ? Toasts.showSucssesToast('Ajouté avec succès')
        : Toasts.showFailedToast('une erreur est produite');
        Navigator.pop(context);
  }

}