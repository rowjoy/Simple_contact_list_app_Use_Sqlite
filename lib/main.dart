// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, avoid_print, sized_box_for_whitespace

import 'package:contact_apps/createduser.dart';
import 'package:contact_apps/database_halper.dart';
import 'package:contact_apps/usermodel.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomepage(),
    );
  }
}

enum popvalu { edit, delete, details }

class MyHomepage extends StatefulWidget {
  const MyHomepage({Key? key}) : super(key: key);

  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  TextEditingController nameconteroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();

  bool islodding = false;
  var userID = 0;
  @override
  void initState() {
    nameconteroller = TextEditingController();
    numbercontroller = TextEditingController();
    addresscontroller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Createduser()));
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: islodding
            ? CircularProgressIndicator()
            : Container(
                child: FutureBuilder(
                    future: DatabaseHelper.instance.getuser(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Usermodel>> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListView(
                        children: snapshot.data!.map((user) {
                          return Container(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 20, left: 25, right: 25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            CircleAvatar(),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  Text(
                                                    "${user.name}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text("${user.number}"),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      PopupMenuButton(
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            child: Text('Edit'),
                                            value: popvalu.edit,
                                          ),
                                          PopupMenuItem(
                                            child: Text('Delete'),
                                            value: popvalu.delete,
                                          ),
                                          PopupMenuItem(
                                            child: Text('Details'),
                                            value: popvalu.details,
                                          ),
                                        ],
                                        onSelected: (value) {
                                          if (value == popvalu.edit) {
                                            setState(() {
                                              updatedata(context);
                                              nameconteroller.text = user.name!;
                                              numbercontroller.text =
                                                  user.number!;
                                              addresscontroller.text =
                                                  user.address!;
                                              userID = user.id!;
                                            });
                                          }
                                          if (value == popvalu.delete) {
                                            setState(() {
                                              DatabaseHelper.instance
                                                  .delete(user.id);
                                            });
                                          }
                                          if (value == popvalu.details) {
                                            datails(context, user);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }),
              ),
      ),
    );
  }

  PersistentBottomSheetController<dynamic> datails(
      BuildContext context, Usermodel user) {
    return showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      Text("${user.name}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text("${user.number}"),
                      Text("${user.address}"),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'))
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  PersistentBottomSheetController<dynamic> updatedata(BuildContext context) {
    return showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            margin: EdgeInsets.only(top: 40, left: 25, right: 25),
            height: 350,
            color: Colors.white,
            child: Column(
              children: [
                TextField(
                  controller: nameconteroller,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: numbercontroller,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: addresscontroller,
                  decoration: InputDecoration(
                    labelText: 'Your Address',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        final user = Usermodel(
                          id: userID,
                          name: nameconteroller.text,
                          number: numbercontroller.text,
                          address: addresscontroller.text,
                        );
                        DatabaseHelper.instance.update(user);
                        Navigator.pop(context);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 100, right: 100, top: 5, bottom: 5),
                      child: Text('Update Date'),
                    ))
              ],
            ),
          );
        });
  }
}
