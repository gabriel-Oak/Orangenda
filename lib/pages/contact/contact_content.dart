import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_agenda/helpers/validators.dart';
import 'package:flutter_agenda/pages/contact/contact_bloc.dart';
import 'package:flutter_agenda/pages/contact/contact_event.dart';
import 'package:flutter_agenda/pages/contact/contact_fab.dart';
import 'package:flutter_agenda/pages/contact/contact_image_picker.dart';
import 'package:flutter_agenda/pages/contact/contact_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ContactContent extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final FocusNode phoneFocus = FocusNode();
  final TextEditingController emailController;
  final FocusNode emailFocus = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final MaskTextInputFormatter phoneFormatter = MaskTextInputFormatter(
    mask: '(##) ####-#####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  ContactContent({
    @required this.nameController,
    @required this.phoneController,
    @required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactBloc, ContactState>(
      builder: (context, state) => WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(state.contact.name),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ContactImagePicker(state: state),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      labelStyle: TextStyle(fontSize: 24),
                    ),
                    style: TextStyle(fontSize: 24),
                    controller: nameController,
                    onChanged: (value) {
                      context.bloc<ContactBloc>().add(ChangeNameContact(value));
                    },
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => _changeFocus(context, phoneFocus),
                    validator: isName,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Telefone',
                      labelStyle: TextStyle(fontSize: 24),
                    ),
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    inputFormatters: [phoneFormatter],
                    validator: isPhone,
                    controller: phoneController,
                    focusNode: phoneFocus,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => _changeFocus(context, emailFocus),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(fontSize: 24),
                    ),
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.emailAddress,
                    validator: isEmail,
                    controller: emailController,
                    focusNode: emailFocus,
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: ContactFab(
            formKey: _formKey,
            nameController: nameController,
            phoneController: phoneController,
            emailController: emailController,
          ),
        ),
        onWillPop: () => _onWllPop(context),
      ),
    );
  }

  void _changeFocus(BuildContext context, FocusNode focus) {
    FocusScope.of(context).requestFocus(focus);
  }

  Future<bool> _onWllPop(BuildContext context) async {
    final bool res = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tem certesa?'),
        content: Text(
            'Ao executar essa ação você perderá todos os dados não salvos!'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancelar'),
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Sim'),
          ),
        ],
      ),
    );
    return res ?? false;
  }
}
