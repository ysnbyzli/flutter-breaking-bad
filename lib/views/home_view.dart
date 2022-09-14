import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:project/model/character.dart';
import 'package:project/theme/color_theme.dart';
import 'package:project/view_model/home_view_model.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends HomeViewModel {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            floating: true,
            snap: true,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text("Breaking Bad"),
              centerTitle: false,
              titlePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
            actions: [
              _LoadingView(
                isVisible: isLoading,
              ),
              IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: CharacterSearch(characters),
                  );
                },
                icon: const Icon(Icons.search),
              )
            ],
          )
        ];
      },
      body: Scaffold(
        body: GridView.builder(
            itemCount: characters?.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Stack(fit: StackFit.expand, children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      characters?[index].img ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                  _StatusWidget(character: characters?[index]),
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          characters?[index].name ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.white),
                        ),
                        Text(
                          characters?[index].nickname ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ]),
              );
            }),
      ),
    ));
  }
}

class _StatusWidget extends StatelessWidget {
  const _StatusWidget({
    Key? key,
    required this.character,
  }) : super(key: key);

  final Character? character;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      right: 10,
      child: Center(
        child: Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: getStatusColor(character?.status ?? ""),
          ),
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView({
    Key? key,
    required this.isVisible,
  }) : super(key: key);

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : const SizedBox.shrink();
  }
}

enum Status { Deceased, Alive }

Color? getStatusColor(String status) {
  if (status == Status.Alive.name) {
    return ThemeColor.darkGreen400;
  } else if (status == Status.Deceased.name) {
    return ThemeColor.red;
  } else {
    return ThemeColor.rise;
  }
}

class CharacterSearch extends SearchDelegate<Character> {
  final List<Character>? characters;

  CharacterSearch(this.characters);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {}

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }
    final results = characters?.where((element) =>
        element.name?.toLowerCase().contains(query.toLowerCase()) ?? false);

    if (results?.length == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Center(child: Text("No Results Found."))],
      );
    } else {
      return ListView(
        children: results
                ?.map((e) => ListTile(
                    title: Text(e.name ?? ""),
                    subtitle: Text(e.nickname ?? ""),
                    trailing: IconButton(
                      icon: const Icon(Icons.chevron_right_outlined),
                      onPressed: () {},
                    )))
                .toList() ??
            [],
      );
    }
  }
}
