import 'package:flutter/material.dart';
import 'package:inventory_management/Ui/Drawer.dart';
import 'package:inventory_management/Ui/Liste_Comerciaux.dart';
import 'package:inventory_management/Ui/Liste_Emplacements.dart';
import 'package:inventory_management/Ui/Navigation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: new AppBar(
        title: Text("Page d'acceille"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bienvenue,",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey[600]),),
                      Text("John",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,color: Colors.grey[700]),)
                    ],
                  ),
                ],
              ),
              SizedBox(height:40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildItemMenu("assets/images/emplacement.png", "Emplacements",ListeEmplacement()),
                buildItemMenu("assets/images/commercial.jpg", "Commerciaux",ListeComerciaux()),
              ],),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildItemMenu("assets/images/dashboard.png", "Tableux de bord",ListeComerciaux()),
              ],),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dernier inventaire effectué :",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500,color: Colors.grey[700]),),
                  Text("afficher tous",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.blue),),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3,
                      offset: Offset(0,1)
                    )
                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                     
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0,1),
                            blurRadius: 1
                          )
                        ]
                      ),
                      child: ClipRRect(
                        child: Image.asset("assets/images/inventory.jpg",height: 40,),
                        borderRadius: BorderRadius.circular(20),  
                        ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Invetaire No : #1234567890 ",style: TextStyle(fontWeight: FontWeight.w500),),
                        Text("Le : 10/50/2020 ",style: TextStyle(fontWeight: FontWeight.w500),),
                        Text("dans A1",style: TextStyle(color: Colors.blue),),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
    Widget buildItemMenu(String image,String text,Object target) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => target),
        );
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          boxShadow:[
            BoxShadow(
              color: Colors.grey,
              blurRadius: 7,
              offset: Offset(0, 2), // changes position of shadow
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)
        ),
                  child: Column(
                    children: [
                      ClipRect(child: Image.asset(image,width: 100,height: 80,fit: BoxFit.fill,)),
                      SizedBox(height: 15,),
                      Text(text,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black54),),
                    ],
                  ),
                ),
    );
  }
}
