import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:simple_loginpage/Gps.dart';

import 'Login_page.dart';
import 'User_profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 0;
  List<String> images = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIpFRSCiEEGJiQesBaZbbbNOii9ZeZ7CCzovZlBNS49oQtENa8zI99__0KRrpMOtF_1Cw&usqp=CAU",
    "https://clipground.com/images/animal-control-clipart-1.jpg",
    "https://townofportbarre.com/images/images_mi/mi_68_istockphoto-486984070-612x612_1352902479_1095.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNinp9Goz6Clk9VSHiAGqw-B_80rv9J7UYbZ_jWxZ9Ar-fDJ9iXnsIet5BB3kL7gliPjs&usqp=CAU",
    "https://www.shutterstock.com/image-vector/dog-catcher-silhouette-vector-260nw-1311780212.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.yellow),
                ),
                Text(
                  "Name",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )
              ],
            ),
            decoration: BoxDecoration(color: Colors.blueAccent),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => User_profile()));
            },
            leading: Icon(Icons.person, color: Colors.blueAccent,size: 30,),
            title: Text("Profile", style: TextStyle(color: Colors.blueAccent,fontSize: 20)),
          ),


          ListTile(
            leading: Icon(Icons.dangerous, color: Colors.blueAccent,size: 30,),
            title: Text("Alert", style: TextStyle(color: Colors.blueAccent,fontSize: 20)),
          ),
          ListTile(
            onTap: (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Gps_page()));

            },
            leading: Icon(Icons.location_on, color: Colors.blueAccent,size: 30,),
            title: Text("Location", style: TextStyle(color: Colors.blueAccent,fontSize: 20)),
          ),
          ListTile(
            leading: Icon(Icons.history, color: Colors.blueAccent,size: 30,),
            title: Text("History", style: TextStyle(color: Colors.blueAccent,fontSize: 20)),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Login_page()));
            },
            leading: Icon(Icons.logout, color: Colors.blueAccent,size: 30,),
            title: Text("Logout", style: TextStyle(color: Colors.blueAccent,fontSize: 20
            )),
          ),
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: selected,
          onTap: (index) {
            setState(() {
              selected = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box), label: "Account"),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: "History")
          ]),
      appBar: AppBar(
        title: Text(
          "Home ",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 24,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text("Dog cather",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.blueAccent,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CarouselSlider(
                      items: images
                          .map((e) => Card(
                                child: Center(
                                    child: Image.network(
                                  e,
                                  fit: BoxFit.cover,
                                  width: 1000,
                                )),
                              ))
                          .toList(),
                      options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true)),
                  SizedBox(
                    height: 40,
                  ),
                  GridView(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.warning,
                              text: 'Stray dog has been found',
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              /*alignment: Alignment.center,*/
                              margin: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("images/dog.png"),
                                  ),
                                  color: Colors.blueAccent.shade100,
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "",
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.amber),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "",
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.amber),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Gps_page()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              width: 50,
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("images/map.png"),
                                  ),
                                  color: Colors.blueAccent.shade100,
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "  ",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.amber),
                                    ),
                                    Text(
                                      "",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.amber),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
