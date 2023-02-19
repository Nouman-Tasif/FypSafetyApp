import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safetyapp2/Model/number_model.dart';
import 'package:safetyapp2/Widget/CustomListTile.dart';
import 'package:safetyapp2/aboutus.dart';
import 'package:safetyapp2/home.dart';

class ContactDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<ContactDetails> {
  TextEditingController controllernumber = TextEditingController();

  late DatabaseReference dbref;

  int ci = 0;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) => initWidget();

  Widget initWidget() {
    print(1);
    print(user!.uid);
    print(2);
    return Scaffold(

      //Bottom NavigationBar
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.deepOrangeAccent,
            showUnselectedLabels: true,
            selectedItemColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'home',
                  backgroundColor: Colors.deepOrangeAccent),
              BottomNavigationBarItem(
                  icon: Icon(Icons.contacts),
                  label: 'contact',
                  backgroundColor: Colors.deepOrangeAccent),
              BottomNavigationBarItem(
                  icon: Icon(Icons.info_outline),
                  label: 'info',
                  backgroundColor: Colors.deepOrangeAccent),
              BottomNavigationBarItem(
                  icon: Icon(Icons.logout),
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
                      ));
                }

                //ContactDetails Index
                if (ci == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactDetails(),
                      ));
                }

                //AboutUs Index
                if (ci == 2) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutUs(),
                      ));
                }

                //Home Index
                if (ci == 3) {
                  GestureDetector(
                    onTap: (){
                      FirebaseAuth.instance.signOut();
                    },
                  );
                }
              });
            }),
        body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: Column(

                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90)),
                      color: new Color(0xffF5591F),
                      gradient: LinearGradient(
                        colors: [
                          (new Color(0xffF5591F)),
                          new Color(0xffF2861E)
                        ],
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
                                height: 150,
                                width: 150,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 20, top: 20),
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "Contacts Detail",
                                style: TextStyle(fontSize: 18,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        )),
                  ),
                  InkWell(
                          onTap:(){

                          } ,
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 25),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              (new Color(0xffDD6E0F)),
                              (new Color(0xffDD6E0F))
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.grey[200],
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Color(0xffEEEEEE)),
                        ],
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                         primary: Color(0xffDD6E0F)
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Container(

                                  child: AlertDialog(
                                    title: Text(
                                      "Enter Number",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.black),
                                    ),
                                    content: TextField(
                                      controller: controllernumber,
                                      cursorColor: Color(0xffF5591F),
                                      keyboardType: TextInputType.number,
                                      maxLength: 12,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Enter a number',
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {

                                            String id = FirebaseFirestore
                                                .instance
                                                .collection("number")
                                                .doc(user!.uid)
                                                .collection("numbers")
                                                .doc()
                                                .id;


                                            await FirebaseFirestore.instance
                                                .collection("number").doc(
                                                user!.uid).collection("numbers")
                                                .doc(id).set(
                                                {
                                                  "num": controllernumber.text
                                                      .toString(),
                                                  "createdat": Timestamp.now(),
                                                  "id": id,
                                                })
                                                .then((value) {
                                              Fluttertoast.showToast(
                                                  msg: 'number Added');
                                            }).onError((error, stackTrace) {
                                              Fluttertoast.showToast(
                                                  msg: 'Error');
                                            }).whenComplete(() =>
                                                Navigator.pop(context));
                                          },

                                          child: Text("Submit")),
                                    ],
                                  ),

                                );
                              });
                        },
                        child: Text(
                          "Add Contact Number",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ),

                    ),
                  ),

           Expanded(child: StreamBuilder<List<Number>>(
               stream:getNumbers(),
               builder: (context, snapshot){
                 if(!snapshot.hasData){
return CircularProgressIndicator();
                 }else if(snapshot.hasData){
                   final numbers = snapshot.data!;
                           return ListView(children: numbers.map(allNumbers).toList(),);
                 }else if(snapshot.hasError){
                   print(snapshot.error);
                 }else{
                  return Center(child: Text("No number!"),);
    };
                 return SizedBox();
               },
           )),


                ],
              ),
            )));
  }

  Widget allNumbers(Number number) => Slidable(
    startActionPane: ActionPane(
      motion: const BehindMotion(),
      children: [
        SlidableAction(

          onPressed: (context) {
            FirebaseFirestore.instance
                .collection("number").doc(
                user!.uid).collection("numbers")
                .doc(number.id).delete();
          },
          icon: Icons.delete,
          label: "Delete",
          backgroundColor: Colors.red,
        ),
      ],
    ),
    endActionPane: ActionPane(
      motion: const DrawerMotion(),
      children: [
        SlidableAction(

          onPressed: (context) {

          },
          label: "edit",
          icon: Icons.edit,
          backgroundColor: Colors.blue,
        ),
      ],
    ),
    child: ListTile(

      title: Text(number.number),
    ),
  );

  Stream<List<Number>> getNumbers() =>
      FirebaseFirestore.instance.collection("number").doc(user!.uid).collection(
          "numbers").orderBy("createdat",descending: true).snapshots().map((snapshot) => snapshot.docs.map((doc) => Number.fromJson(doc.data())).toList());
}
