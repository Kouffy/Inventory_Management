import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inventory_management/Core/Controllers/ArticleController.dart';
import 'package:inventory_management/Core/Models/Article.dart';
import 'package:inventory_management/Toasts.dart';
import 'package:inventory_management/Ui/Aj_Article.dart';

import 'Navigation.dart';

class ListeArticles extends StatefulWidget {
  final String libelle;
  final int id;
  ListeArticles(this.libelle, this.id);
  @override
  _ListeArticlesState createState() => _ListeArticlesState(libelle, id);
}

class _ListeArticlesState extends State<ListeArticles> {
  String libelle;
  int id;
  _ListeArticlesState(this.libelle, this.id);
  List<Article> listeArticles;
  getArticles() {
    ArticleController.getArticlesEmplacment(id).then((response) {
      Iterable list = json.decode(response.body);
      List<Article> articleList = List<Article>();
      articleList = list.map((model) => Article.fromObject(model)).toList();
      setState(() {
        listeArticles = articleList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getArticles();
    return Scaffold(
      floatingActionButton: _buildFloatingButton(),
      appBar: AppBar(
        title: Text('Les articles de $libelle'),
      ),
      body: (listeArticles == null || listeArticles.length == 0)
          ? Center(
              child: Text('Aucun elemnet a afficher'),
            )
          : _buildArticlesList(),
    );
  }

  Widget _buildArticlesList() {
    return ListView.builder(
      itemCount: listeArticles.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            child: Card(
              child: ListTile(
                title: Text(listeArticles[index].libelleArticle),
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
                      onPressed: () => Navigation.navigateToWidget(context,
                          AjouterArticle(id, libelle, listeArticles[index])),
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
                      onPressed: () =>
                          supprimerArticle(listeArticles[index].id),
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
              builder: (BuildContext context) =>
                  AjouterArticle(id, libelle, null)));
        });
  }

  void supprimerArticle(int id) async {
    var saveResponse = await ArticleController.deleteArticle(id);
    saveResponse == true
        ? Toasts.showSucssesToast("supprimé avec succès")
        : Toasts.showFailedToast("Erreur");
  }
}
