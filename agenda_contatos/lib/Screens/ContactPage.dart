
import 'dart:io';

import 'package:agenda_contatos/Helpers/Contact_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ContactPage extends StatefulWidget {
  final Contact contact;
  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  String gen = "man";

  Contact _editedContact;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPhone = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact.toMap());
      _controllerName.text = _editedContact.name;
      _controllerPhone.text = _editedContact.phone;
      _controllerEmail.text = _editedContact.email;
      gen = _editedContact.gen;
    }
  }

  _backgroundSliver() {
    return GestureDetector(
        onTap: () {
          ImagePicker.pickImage(source: ImageSource.gallery).then((file) {
            if (file == null) return;
            setState(() {
              _editedContact.img = file.path;
            });
          });
        },
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              //height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: _editedContact.img != null
                          ? FileImage(File(_editedContact.img))
                          : gen == "man"
                              ? AssetImage("assets/personImg2.jpg")
                              : AssetImage("assets/girl2.jpg"),
                      fit: BoxFit.cover)),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.08,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  if (_editedContact.img != null) {
                    setState(() {
                      _editedContact.img = null;
                      gen = "man";
                    });
                  }
                  if (gen == "man") {
                    setState(() {
                      gen = "whoman";
                    });
                  } else {
                    setState(() {
                      gen = "man";
                    });
                  }
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.redAccent[400],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20, right: 10, top: 7, bottom: 8),
                      child: Text(
                        "Mudar img",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              backgroundColor: Colors.indigo[300],
              //title: Text(_editedContact.name ?? "Novo Contato"),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                title: Text(
                  _editedContact.name ?? "Novo Contato",
                  style: TextStyle(fontWeight: FontWeight.bold, shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(2.0, 2.0),
                    ),
                  ]),
                ),
                background: _backgroundSliver(),
              ),
            ),
            SliverFillRemaining(
                child: SingleChildScrollView(
                    child: Container(
              //height: MediaQuery.of(context).size.height *0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 50,
                    height: MediaQuery.of(context).size.height * 0.05,
                    color: Colors.transparent,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 15, right: 15, bottom: 15, top: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width * 0.07,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                          height: 1,
                        ),
                        Flexible(
                          child: TextField(
                              controller: _controllerName,
                              style: TextStyle(fontSize: 22),
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              decoration: new InputDecoration(
                                hintText: "Nome...",
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: const EdgeInsets.only(
                                    left: 15, top: 17, bottom: 17),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(17),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 3.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(17),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 3.0,
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 15, right: 15, bottom: 15, top: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width * 0.07,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                          height: 1,
                        ),
                        Flexible(
                          child: TextField(
                              controller: _controllerPhone,
                              style: TextStyle(fontSize: 22),
                              keyboardType: TextInputType.phone,
                              maxLines: 1,
                              decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    left: 15, top: 17, bottom: 17),
                                hintText: "Phone...",
                                hintStyle: TextStyle(color: Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(17),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 3.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(17),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 3.0,
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 15, right: 15, bottom: 15, top: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            Icons.email,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width * 0.07,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                          height: 1,
                        ),
                        Flexible(
                          child: TextField(
                              controller: _controllerEmail,
                              style: TextStyle(fontSize: 22),
                              keyboardType: TextInputType.emailAddress,
                              maxLines: 1,
                              decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    left: 15, top: 17, bottom: 17),
                                hintText: "Email...",
                                hintStyle: TextStyle(color: Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(17),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 3.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(17),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 3.0,
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.05,
                      right: MediaQuery.of(context).size.height * 0.05,
                      //left: MediaQuery.of(context).size.height * 0.25,
                      //right: MediaQuery.of(context).size.height * 0.017,
                      top: 10,
                      bottom: 10,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        if (_controllerName.text == null ||
                            _controllerName.text.isEmpty) {
                          Navigator.pop(context);
                        } else {
                          ContactHelper ch = ContactHelper();
                          _editedContact.name = _controllerName.text;
                          _editedContact.phone = _controllerPhone.text;
                          _editedContact.email = _controllerEmail.text;
                          _editedContact.gen = gen;
                          if (widget.contact != null) {
                            ch.updateContact(_editedContact);
                            Navigator.pop(context);
                          } else {
                            ch.saveContact(_editedContact);
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          //width: MediaQuery.of(context).size.height * 0.6 ,
                          decoration: BoxDecoration(
                              color: Colors.indigo[300],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    MediaQuery.of(context).size.height * 0.04),
                                topRight: Radius.circular(
                                    MediaQuery.of(context).size.height * 0.04),
                                bottomLeft: Radius.circular(
                                    MediaQuery.of(context).size.height * 0.1),
                                bottomRight: Radius.circular(
                                    MediaQuery.of(context).size.height * 0.1),
                              )),
                          child: Center(
                            child: Text(
                                widget.contact != null ? "editar" : "salvar",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.03,
                                    fontWeight: FontWeight.bold)),
                          )),
                    ),
                  )
                ],
              ),
            )))
          ],
        ),
      ),
      
    );
  }
}
