import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart';
import 'package:inventory_management/Core/Controllers/ArticleController.dart';
import 'package:inventory_management/Core/Controllers/InventaireController.dart';
import 'package:inventory_management/Core/Models/Article.dart';
import 'package:inventory_management/Core/Models/Inventaire.dart';
import 'package:inventory_management/Ui/Rapport.dart';

class EffectuerInventaire extends StatefulWidget {
  final int id;
  EffectuerInventaire(this.id);
  @override
  _EffectuerInventaireState createState() => _EffectuerInventaireState(id);
}

class _EffectuerInventaireState extends State<EffectuerInventaire> {
  int id;
  _EffectuerInventaireState(this.id);
  String _data = "", libelleArt = "";
  List<Article> Nouvauxarts;
  List<Article> Ancienarts;
  List<Article> Mouvedarts;
  Article article;
  getArticle(int idart) async {
    Response userres = await ArticleController.getArticleID(idart);
    if (userres.statusCode == 200) {
      var resulat = json.decode(userres.body);
      Article art = Article.fromObject(resulat);
      if (this.mounted) {
        setState(() {
          article = art;
        });
      }
    }
  }

  Future<String> _scan() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#000000", "cancel", true, ScanMode.BARCODE)
        .then((value) => setState(() => _data = value));

    return _data;
  }

  @override
  Widget build(BuildContext context) {
    if (_data != "") {
      getArticle(int.parse(_data));
      if (article != null && article.idEmplacement != this.id) {
        article.idEmplacement = this.id;
        ArticleController.putArticle(article);
        libelleArt = article.libelleArticle;
        Nouvauxarts.add(article);
        _data = "";
        article = null;
      } else if (article != null && article.idEmplacement == this.id) {
        libelleArt = article.libelleArticle;
        Ancienarts.add(article);
        _data = "";
        article = null;
      }
    }
    return Scaffold(
      floatingActionButton: _buildFloatingButton(),
      appBar: AppBar(
        title: Text('Effectuer un inventaires'),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Center(
                child: Text('Dernier Article scanné : ' + libelleArt),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              // fillOverscroll: true, // Set true to change overscroll behavior. Purely preference.
              child: Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      Inventaire inventaire =
                          new Inventaire(this.id, DateTime.now().toString());
                      InventaireController.postInventaire(inventaire);
                      reportView(context);
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
                        child: Text('Terminer L\'inventaire',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _scan();
        });
  }
}
