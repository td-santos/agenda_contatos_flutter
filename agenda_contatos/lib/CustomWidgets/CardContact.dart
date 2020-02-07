import 'dart:io';

import 'package:agenda_contatos/Helpers/Contact_helper.dart';
import 'package:agenda_contatos/Screens/ContactPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CardContact extends StatelessWidget {
  final Contact contact;
  const CardContact({this.contact});

  _dialogCorfimDelete(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text(
              "Excluir o contato abaixo?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.indigo[300], fontWeight: FontWeight.bold),
            ),
            content: Container(
              //width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    contact.name,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.05),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.02),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.indigo[300], width: 2),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              " Cancelar ",
                              style: TextStyle(
                                color: Colors.indigo[300],
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            ContactHelper ch = ContactHelper();
                            print(contact.id);
                            ch.deleteContact(contact);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.02),
                            decoration: BoxDecoration(
                                border:Border.all(color: Colors.red, width: 2),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "   Excluir   ",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  _bottomSheet(BuildContext context, Contact contact) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return BottomSheet(
            enableDrag: true,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            onClosing: () {},
            builder: (context) {
              return Container(
                  height: MediaQuery.of(context).size.height * 0.32,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                launch("tel:${contact.phone}");
                                Navigator.pop(context);
                              },
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(200),
                                        topRight: Radius.circular(200),
                                        bottomLeft: Radius.circular(200),
                                        bottomRight: Radius.circular(60),
                                      )),
                                  child: Center(
                                      child: Icon(
                                    Icons.phone_in_talk,
                                    color: Colors.white,
                                    size:
                                        MediaQuery.of(context).size.width * 0.2,
                                  ))),
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              //width: MediaQuery.of(context).size.width,
                              //height: 2,
                              //color: Colors.white,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ContactPage(
                                              contact: contact,
                                            )));
                              },
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(200),
                                        topRight: Radius.circular(200),
                                        bottomLeft: Radius.circular(200),
                                        bottomRight: Radius.circular(60),
                                      )),
                                  child: Center(
                                      child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size:
                                        MediaQuery.of(context).size.width * 0.2,
                                  ))),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        )
                      ],
                    ),
                  ));
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: GestureDetector(
            onLongPress: () {
              _dialogCorfimDelete(context);
            },
            onTap: () {
              _bottomSheet(context, contact);
            },
            child: Container(
              width: MediaQuery.of(context).size.width - 30,
              padding: EdgeInsets.only(
                left: 9,
              ),
              decoration: BoxDecoration(
                  color: contact.img != null
                      ? Colors.green
                      : contact.gen == "man" ? Colors.blue : Colors.pink,
                  borderRadius: BorderRadius.circular(17),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 7, offset: Offset(2, 1))
                  ]),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(17.0),
                      bottomRight: Radius.circular(17.0),
                      topLeft: Radius.circular(4.0),
                      bottomLeft: Radius.circular(4.0),
                    )),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                              bottomRight: Radius.circular(20),
                            ),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                image: contact.img != null
                                    ? FileImage(File(contact.img))
                                    : contact.gen == "man"
                                        ? AssetImage("assets/personImg2.jpg")
                                        : AssetImage("assets/girl2.jpg"),
                                fit: BoxFit.cover)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.58,
                              child: Text(
                                contact.name ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.cyan[800],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              contact.email ?? "",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.teal,
                              ),
                            ),
                            Text(
                              contact.phone ?? "",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
