import 'package:flutter/material.dart';
import 'package:flutter_agenda/helpers/contact_helper.dart';
import 'package:flutter_agenda/pages/home/bloc.dart';
import 'package:flutter_agenda/pages/home/home_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  final ContactHelper repository;

  HomePage({@required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(repository: repository)..add(GetContacts()),
      child: HomeContent(repository: repository),
    );
  }
}
