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
                color: Colors.blue[50],
                elevation: 2.0,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(listeArticles[index].libelleArticle),
                         SizedBox(
                          width: 10.0,
                        ),
                        RaisedButton(
                          child: Text(
                            "Modifier",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () => Navigation.navigateToWidget(context, AjouterArticle(id,libelle,listeArticles[index])),
                          color: Colors.green,
                          textColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.grey,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        RaisedButton(
                          child: Text(
                            "Supprimer",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () => supprimerArticle(listeArticles[index].id),
                          color: Colors.green,
                          textColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                )),
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
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (BuildContext context) => AjouterArticle(id, libelle,null)));
        });
  }
    void supprimerArticle(int id) async {
    var saveResponse = await ArticleController.deleteArticle(id);
    saveResponse == true
        ? Toasts.showSucssesToast("supprimé avec succès")
        : Toasts.showFailedToast("Erreur");
  }
}
