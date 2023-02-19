import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safetyapp2/Widget/RoundContainer.dart';
import 'package:safetyapp2/aboutus.dart';
import 'package:safetyapp2/contactdetails.dart';
import 'package:safetyapp2/login.dart';
import 'package:safetyapp2/newalertpage.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<HomeScreen> {

  String? name;
  int ci = 0;
  String? id;
  String getname = "";
  User? user = FirebaseAuth.instance.currentUser;

  getData() async {
    // Get docs from collection reference
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get().then((value) {
      getname = value.get(FieldPath(["username"]));
      setState(() {

      });});}

        @override
        void initState()
    {
      // TODO: implement initState
      super.initState();
      //getData();
    }

  @override
  Widget build(BuildContext context) => initWidget();

  Widget initWidget() {
   final size = MediaQuery.of(context).size;
    return Scaffold(

//Bottom NavigationBar
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.deepOrangeAccent,
          showUnselectedLabels: true,
          selectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),
                label: 'home',
                backgroundColor: Colors.deepOrangeAccent),
            BottomNavigationBarItem(icon: Icon(Icons.contacts),
                label: 'contacts',
                backgroundColor: Colors.deepOrangeAccent),
            BottomNavigationBarItem(icon: Icon(Icons.info_outline),
                label: 'info',
                backgroundColor: Colors.deepOrangeAccent),
            BottomNavigationBarItem(icon: IconButton(onPressed: (){
              FirebaseAuth.instance.signOut().whenComplete(() => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => LoginScreen())), (route) => false));
            },icon: Icon(Icons.logout)),
                label: 'logout',
                backgroundColor: Colors.deepOrangeAccent),
          ],
          onTap: (index) {
            setState(() {


              ci = index;
              //HomeScreen Index
              if (ci == 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    )
                );
              }

              //ContactDetails Index
              if (ci == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactDetails(),
                    )
                );
              }

              //AboutUs Index
              if (ci == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutUs(),
                    )
                );
              }

              //Home Index
              if (ci == 3) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),

                    )
                );
              }
            });
          }
      ),


      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance.collection("users").doc(user!.uid).get(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    var data = snapshot.data!.data();
                    print(getname);
                    getname = data!["username"];
                    print(getname);

                  }
                  return theContainer();
                }
            ),
          ],
        ),
      ),
    );
  }

  Widget theContainer() => Column(
    children: [
      Container(
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(90)),
          color: new Color(0xffF5591F),
          gradient: LinearGradient(
            colors: [(new Color(0xffF5591F)), new Color(0xffF2861E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Image.asset(
                    "images/logo.png",
                    height: 130,
                    width: 130,
                  ),
                ),
                Text(getname,
                  style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.w900),),
                Container(
                  margin: EdgeInsets.only(right: 20, top: 20),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Dashboard",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                )
              ],

            )
        ),
      ),
      SizedBox(height: 100,),
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(child: RoundContainer(
                  icon: 'images/phone_book.png', title: 'Contact No'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (
                      builder) => ContactDetails()));
                },),
              GestureDetector(child: RoundContainer(
                  icon: 'images/whatsapp.png', title: 'Whatsapp No'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (
                      builder) => ContactDetails()));
                },),

            ],
          ),
          SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
  onTap: (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => NewAleartPage()));
  },
  child:Container(
  width: MediaQuery.of(context).size.width * 0.4,
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(16)),
  boxShadow: [
  BoxShadow(
  color: Colors.black26,
  blurRadius: 20,
  spreadRadius: 5,
  )
  ]

  ),
  child: Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
  Image.asset('images/warningpic.png',width: 80,height: 80),
  SizedBox(height: 20,),
  Text("Alert",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Color(0xffF5591F)),),

  ],
  ),
  ),




),
              GestureDetector(child: RoundContainer(
                  icon: 'images/information.png', title: 'Info'), onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (
                    builder) => AboutUs()));
              },),

            ],
          ),
        ],
      )
    ],
  );
}