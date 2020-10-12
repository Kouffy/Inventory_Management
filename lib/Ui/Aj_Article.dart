import 'package:flutter/material.dart';
import 'package:inventory_management/Core/Controllers/ArticleController.dart';
import 'package:inventory_management/Core/Models/Article.dart';
import 'package:inventory_management/Toasts.dart';

class AjouterArticle extends StatefulWidget {
  final Article article;
  final int id;
  final String libelle;
  AjouterArticle(this.id, this.libelle, this.article);
  @override
  _AjouterArticleState createState() =>
      _AjouterArticleState(id, libelle, article);
}

class _AjouterArticleState extends State<AjouterArticle> {
  int id;
  String libelle;
  Article article;
  _AjouterArticleState(this.id, this.libelle, this.article);
  TextEditingController libelleController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (this.article != null)
      libelleController.text = this.article.libelleArticle;
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
                this.article != null ? "Modifier" : "Ajouter",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () => this.article != null
                  ? modifierArticle(this.article)
                  : enregistrerArticle(),
              color: Colors.green,
              textColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.grey,
            ),
          ]),
        ));
  }

  void enregistrerArticle() async {
    Article article = new Article(libelleController.text, id);
    var saveResponse = await ArticleController.postArticle(article);
    saveResponse == true
        ? Toasts.showSucssesToast('Ajouté avec succès')
        : Toasts.showFailedToast('une erreur est produite');
    Navigator.pop(context);
  }

  void modifierArticle(Article article) async {
    article.libelleArticle = libelleController.text;
    var saveResponse = await ArticleController.putArticle(article);
    saveResponse == true
        ? Toasts.showSucssesToast("modifié avec succès")
        : Toasts.showFailedToast("Erreur");
  }
}
