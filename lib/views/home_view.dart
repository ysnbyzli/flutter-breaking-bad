import 'package:flutter/material.dart';
import 'package:project/model/character.dart';
import 'package:project/view_model/home_view_model.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends HomeViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Breaking Bad"),
          actions: [
            _LoadingView(
              isVisible: isLoading,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              itemCount: characters?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 5,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
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
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}

enum Status { Deceased, Alive }

Color? getStatusColor(String status) {
  if (status == Status.Alive.name) {
    return Colors.green;
  } else if (status == Status.Deceased.name) {
    return Colors.red;
  } else {
    return Colors.amber;
  }
}
