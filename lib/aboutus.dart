import 'package:flutter/material.dart';
import 'package:safetyapp2/contactdetails.dart';
import 'package:safetyapp2/home.dart';

class AboutUs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<AboutUs> {
  int ci=0;
  @override
  Widget build(BuildContext context) => initWidget();

  Widget initWidget() {
    return Scaffold(


      //Bottom NavigationBar
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.deepOrangeAccent,
            showUnselectedLabels: true,
            selectedItemColor: Colors.white,
            items:[
              BottomNavigationBarItem(icon: Icon(Icons.home),
                  label: 'home',
                  backgroundColor: Colors.deepOrangeAccent),
              BottomNavigationBarItem(icon: Icon(Icons.contacts),
                  label: 'contact',
                  backgroundColor: Colors.deepOrangeAccent),
              BottomNavigationBarItem(icon: Icon(Icons.info_outline),
                  label: 'info',
                  backgroundColor: Colors.deepOrangeAccent),
              BottomNavigationBarItem(icon: Icon(Icons.logout),
                  label: 'logout',
                  backgroundColor: Colors.deepOrangeAccent),
            ],
            onTap:(index){
              setState(() {
                ci=index;
                //HomeScreen Index
                if(ci==0)
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      )
                  );}

                //ContactDetails Index
                if(ci==1)
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactDetails(),
                      )
                  );}

                //AboutUs Index
                if(ci==2)
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutUs(),
                      )
                  );}

                //Home Index
                if(ci==3)
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutUs(),
                      )
                  );}


              });
            }
        ),




        body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
                    color: new Color(0xffF5591F),
                    gradient: LinearGradient(colors: [(new  Color(0xffF5591F)), new Color(0xffF2861E)],
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
                              "AboutUs",
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  alignment: Alignment.centerLeft,

                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => AboutUs(),
                      //     )
                      // );
                      // };
                      // Write Click Listener Code Here
                    },
                    child: Text("Safety App is designed for user safety in emergnecy situation "
                        "\n1-User Will add contact Number from dashboard=>Contact=>plus Icon"
                        "\n2 There are Maximum Four possible Alerts that will send to added contact Number"
                        "or on whatsapp"
                        "\n3-A hard coded alert message will be send to added contact number ob sim card"
                        "\n4-If Phone GPS is on your location will be send to added contact Number"
                        "\n5-If User has Balance in sim a possible call will be ring to added number"
                        "\n6-An automatic scnerio picture or video will send on email or on whatsapp"
                        "\n Guidelines"
                        "\n1-User Phone GPS must be on for location Alert"
                        "\n2-User must have a Balance for Call alert"
                        "\n3-User must have Internet Connection for picture alert",
                      style: TextStyle(
                          color: Color(0xff989393),

                      ),
                    ),


                  ),
                ),


              ],

            )
        )
    );
  }
}