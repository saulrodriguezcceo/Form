import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:form_app/src/pages/bloc/validators.dart';

class LoginBloc with Validators{
  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();


//  Recuperar los datos del Stream

  Stream<String> get emailStream => _emailController.stream.transform( validateEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform( validatePassword);

  Stream<bool> get formValidStream => CombineLatestStream.combine2(emailStream, passwordStream, (e,p)=>true);

//  Insertar valores al stream

  Function (String) get changeEmail     => _emailController.sink.add;
  Function (String) get changePassword => _passwordController.sink.add;
//Get last value
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }
}

