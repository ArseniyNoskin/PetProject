import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  bool flag = false;

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => HeroBloc(dotaRepository: context.read<DotaRepository>()),
          child: _heroesForm(context),
        ),
      )
    );
  }

  Widget _heroesForm(BuildContext context) {
    return BlocListener<HeroBloc, HeroState>(
        listener: (context, state) {
        final formStatus = state.formStatus;

        if (formStatus is FormSubmitting) {
          const CircularProgressIndicator();
        }

        if (formStatus is SubmissionSuccess) {
          setState(() {
            listHeroes = state.heroList;
          });
        }
      },
      child: BlocBuilder<HeroBloc, HeroState>(builder: (context, state) {
        if (listHeroes.isEmpty) {
          context.read<HeroBloc>().add(LoadAllHeroes());
          flag = true;
        }

        listHeroes.sort((a, b) => a.nameLoc!.toLowerCase().compareTo(b.nameLoc!.toLowerCase()));
        context.read<HeroBloc>().add(GetSearchListHeroes(name: nameController.text));
        return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/background_dota.png'))),
            child: Form(
                child: Center(
                    child: Column(
              children: [
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextField(
                    controller: nameController,
                  ),
                ),
                _heroesDotaList(listHeroes),

              ],
            ))));
      }),
    );
  }

  Widget _heroesDotaList(List<Heroes> listHeroes2) {
    return Container(
        height: MediaQuery.of(context).size.height - 100,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          itemCount: listHeroes2.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black54),
                    gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                      Colors.grey,
                      Colors.white60,
                      Colors.white10,
                    ])),
                margin: const EdgeInsets.symmetric(vertical: 3),
                child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.heroInfo, arguments: listHeroes2[index].id);
                    },
                    title: Row(
                      children: [
                        Image.network(
                          'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/${listHeroes2[index].name!.replaceAll('npc_dota_hero_', '')}.png',
                          height: 30,
                          width: 50,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          listHeroes2[index].nameLoc!,
                          style:
                              const TextStyle(fontSize: 18, fontFamily: 'Times New Roman', fontWeight: FontWeight.w600),
                        ),
                      ],
                    )));
          },
        ));
  }
}
