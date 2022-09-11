import 'package:flutter/material.dart';
import '../model/character.dart';
import '../services/main_service.dart';
import '../views/home_view.dart';

abstract class HomeViewModel extends State<Home> {
  final MainService service;
  late List<Character>? characters = [];
  HomeViewModel() : service = MainService();

  bool isLoading = false;

  @override
  void initState() {
    fetchCharacters();
    super.initState();
  }

  Future<void> fetchCharacters() async {
    changeLoading();
    characters = await service.fetchCharacters();
    changeLoading();
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
