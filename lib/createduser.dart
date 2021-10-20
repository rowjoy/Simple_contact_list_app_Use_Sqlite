// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:math';

import 'package:contact_apps/database_halper.dart';
import 'package:contact_apps/main.dart';
import 'package:contact_apps/usermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Createduser extends StatefulWidget {
  const Createduser({Key? key}) : super(key: key);

  @override
  _CreateduserState createState() => _CreateduserState();
}

class _CreateduserState extends State<Createduser> {
  TextEditingController nameconteroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  Random random = Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Created new contact'),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 25, right: 25),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                'Contact Data Created',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
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
                  style: ButtonStyle(),
                  onPressed: () {
                    try {
                      setState(() {
                        final user = Usermodel(
                          id: random.nextInt(100),
                          name: nameconteroller.text,
                          number: numbercontroller.text,
                          address: addresscontroller.text,
                        );
                        DatabaseHelper.instance.adduser(user);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomepage()));
                      });
                      nameconteroller.clear();
                      numbercontroller.clear();
                      addresscontroller.clear();
                    } catch (e) {
                      // ignore: void_checks
                      print(e);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 122, right: 122),
                    child: Text('Save'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
