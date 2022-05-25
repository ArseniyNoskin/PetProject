import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/data/models/heroesResponseDTO.dart';
import 'package:new_project/presentation/allHeroesPage/bloc/heroes_bloc.dart';
import 'package:new_project/presentation/allHeroesPage/bloc/heroes_event.dart';
import 'package:new_project/presentation/allHeroesPage/bloc/heroes_state.dart';
import 'package:new_project/presentation/form_submission_status.dart';

import '../../data/repository/dota_repository.dart';
import '../routes/appRoutes.dart';

class ListHeroesView extends StatefulWidget {
  const ListHeroesView({Key? key}) : super(key: key);

  @override
  State<ListHeroesView> createState() => _ListHeroesViewState();
}

class _ListHeroesViewState extends State<ListHeroesView> {
  List<Heroes> listHeroes = [];

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
        }
      },
      child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/background_dota.png'))),
          child: Form(
              child: Center(
                  child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              _heroesDotaList(listHeroes),
              const SizedBox(
                height: 10,
              ),
              _loadAllHeroesButton(),
            ],
          )))),
    );
  }

  Widget _heroesDotaList(List<Heroes> listHeroes2) {
    if (listHeroes2.isNotEmpty) {
      print ('wtf');
      return Container(
          height: 700,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            itemCount: listHeroes2.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blueAccent,
                ),
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  child: ListTile(
                    onTap: (){
                      Navigator.pushNamed(context, AppRoutes.heroInfo, arguments: listHeroes2[index].id);
                    },
                    title: Row(
                      children: [
                        Text(
                          listHeroes2[index].nameLoc!,
                          style: const TextStyle(fontSize: 18, fontFamily: 'Times New Roman'),
                        ),
                        const SizedBox(width: 10,),
                        Text(
                          listHeroes2[index].nameEnglishLoc!,
                          style: const TextStyle(fontSize: 18, fontFamily: 'Times New Roman'),
                        ),
                      ],
                    )
                  ));
            },
          ));
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 150),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Text(
              'CLEAR',
              style: TextStyle(fontSize: 40, color: Colors.greenAccent),
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
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
        child: TextButton(
          onPressed: () {
            setState(() {});
            context.read<HeroBloc>().add(LoadAllHeroes());
          },
          child: const Text(
            'Load all heroes',
            style: TextStyle(color: Colors.black54, fontSize: 25),
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
