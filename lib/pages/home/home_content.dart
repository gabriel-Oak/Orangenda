import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_agenda/helpers/contact_helper.dart';
import 'package:flutter_agenda/pages/contact/contact_page.dart';
import 'package:flutter_agenda/pages/home/bloc.dart';
import 'package:flutter_agenda/pages/home/home_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeContent extends StatelessWidget {
  final ContactHelper repository;
  HomeContent({@required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (order) =>
                context.bloc<HomeBloc>().add(OrderList(order)),
            tooltip: 'Ordenar contatos',
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: OrderOptions.asc,
                  child: Text('A - Z'),
                ),
                PopupMenuItem(
                  value: OrderOptions.desc,
                  child: Text('Z - A'),
                ),
              ];
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.loading) return Center(child: CircularProgressIndicator());

          return state.contactList.length == 0
              ? Center(
                  child: Text('Não há nada para exibir aqui :)'),
                )
              : ListView.builder(
                  itemCount: state.contactList.length,
                  itemBuilder: (context, index) => HomeTile(
                    contact: state.contactList[index],
                    bloc: context.bloc<HomeBloc>(),
                    onEditContact: _navigateToContact,
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _navigateToContact(context, Contact()),
      ),
    );
  }

  Future _navigateToContact(BuildContext context, Contact contact) async {
    final bool contactSaved = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactPage(
          repository: repository,
          contact: contact,
        ),
      ),
    );

    if (contactSaved == null) return;
    if (contactSaved) context.bloc<HomeBloc>().add(GetContacts());
  }
}
