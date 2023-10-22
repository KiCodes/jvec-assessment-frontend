import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionModel extends ChangeNotifier{

  final _connectionChecker = InternetConnectionChecker();
  late StreamSubscription<InternetConnectionStatus> _subscription;
  bool hasConnection = true;
  bool _disposed = false;

  ConnectionModel(){_init();}

  void _init() async {
    _subscription = _connectionChecker.onStatusChange.listen((event) async {
      hasConnection = await _connectionChecker.hasConnection;
      if(!_disposed){
        notifyListeners();
      }
    });
    hasConnection = await _connectionChecker.hasConnection;
    if (!_disposed){
      notifyListeners();
    }
  }

  @override
  void dispose(){
    _disposed = true;
    _subscription.cancel();
    super.dispose();
  }  
}