import 'package:flutter/material.dart';
import '../model/character.dart';
import '../services/main_service.dart';
import '../views/home_view.dart';

abstract class HomeViewModel extends State<Home> {
  final MainService service;
  HomeViewModel() : service = MainService();
  late List<Character>? characters;

  @override
  void initState() {
    super.initState();
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    characters = await service.fetchCharacters();
  }
}
