import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_agenda/helpers/contact_helper.dart';
import 'package:flutter_agenda/pages/home/bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeTile extends StatelessWidget {
  final Contact contact;
  final HomeBloc bloc;
  final Function onEditContact;

  HomeTile({
    @required this.contact,
    @required this.bloc,
    @required this.onEditContact,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: contact.img == null
                      ? Text(
                          contact.name[0].toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Image(
                            image: FileImage(File(contact.img)),
                            fit: BoxFit.cover,
                            width: 64,
                            height: 64,
                          ),
                        ),
                  radius: 32,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        contact.name,
                        style: TextStyle(fontSize: 22),
                      ),
                      Text(contact.phone),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey,
            height: 1,
          ),
        ],
      ),
      onTap: () => _selectContact(context),
    );
  }

  void _selectContact(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (c) => Wrap(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.call, color: Colors.green),
            title: Text('Ligar', style: TextStyle(color: Colors.green)),
            onTap: () => launch('tel:${contact.phone}'),
          ),
          ListTile(
            leading: Icon(Icons.edit, color: Colors.orange),
            title: Text('Editar', style: TextStyle(color: Colors.orange)),
            onTap: () {
              Navigator.of(context).pop();
              onEditContact(context, contact);
            },
          ),
          ListTile(
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text('Excluir', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.of(context).pop();
              _confirmRemove(context);
            },
          ),
        ],
      ),
    );
  }

  Future _confirmRemove(BuildContext context) async {
    final bool res = await showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: Text('Deseja remover ${contact.name}?'),
        content: Text('Ao executar essa ação você NÃO poderá mais desfaze-la!'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancelar'),
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Sim', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (res != null && res)
      bloc.add(RemoveContact(contact: contact, context: context));
  }
}
