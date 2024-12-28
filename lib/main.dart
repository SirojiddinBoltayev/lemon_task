import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lemon_task/presantation/pages/bloc/global_bloc.dart';

import 'app.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => GlobalBloc(),
    child: App(),
  ));
}
