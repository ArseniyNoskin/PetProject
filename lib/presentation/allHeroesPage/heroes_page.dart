import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/data/models/heroesDTO.dart';
import 'package:new_project/presentation/allHeroesPage/bloc/heroes_bloc.dart';
import 'package:new_project/presentation/allHeroesPage/bloc/heroes_event.dart';
import 'package:new_project/presentation/allHeroesPage/bloc/heroes_state.dart';
import 'package:new_project/presentation/form_submission_status.dart';

import '../../data/repository/dota_repository.dart';

class ListHeroesView extends StatefulWidget {
  const ListHeroesView({Key? key}) : super(key: key);

  @override
  State<ListHeroesView> createState() => _ListHeroesViewState();
}

class _ListHeroesViewState extends State<ListHeroesView> {
  List<DotaHero> listHeroes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HeroBloc(dotaRepository: context.read<DotaRepository>()),
        child: _heroesForm(context),
      ),
    );
  }

  Widget _heroesForm(BuildContext context) {
    return BlocListener<HeroBloc, HeroState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          }
          if (formStatus is SubmissionSuccess) {
            setState(() {
              listHeroes = state.heroList;
            });
            print('size here = ${listHeroes.length}  from ${state.heroList.length}');
          }
        },
        child: Form(
            child: Center(
                child: Column(
          children: [
            Container(child: _heroesDotaList(listHeroes)),
            Container(child: _loadAllHeroesButton()),
          ],
        ))));
  }

  Widget _heroesDotaList(List<DotaHero> listHeroes2) {
    print('_____________  Repain');
    if (listHeroes2.isNotEmpty) {
      print('is not empty');
      return Container(
        color: Colors.blue,
        child: ListView.builder(
          //scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          //itemCount: listHeroes2.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.greenAccent,
              child: ListTile(
                title: Text(
                  listHeroes2[index].localizedName,
                  style: const TextStyle(fontSize: 18, fontFamily: 'Times New Roman'),
                ),
              )
            );
          },
        )
      );
    } else {
      print('empty');
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 150),
          Container(
            color: Colors.redAccent,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Text(
              'NIHERA',
              style: TextStyle(fontSize: 40),
            ),
          ),
          const SizedBox(
            height: 150,
          )
        ],
      );
    }
  }

  Widget _loadAllHeroesButton() {
    /*return BlocBuilder<HeroBloc, HeroState>(builder: (context, state) {
      return ElevatedButton(
        onPressed: () {
          context.read<HeroBloc>().add(LoadAllHeroes());
        },
        child: const Text('Load all heroes'),
      );
    });*/
    return BlocBuilder<HeroBloc, HeroState>(builder: (context, state) {
      return Container(
        height: 50,
        width: 250,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton(
          onPressed: () {
            setState(() {});
            context.read<HeroBloc>().add(LoadAllHeroes());

          },
          child: const Text(
            'asdasd',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
