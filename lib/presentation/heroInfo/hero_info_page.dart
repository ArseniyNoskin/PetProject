import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/data/models/heroesResponseDTO.dart';
import 'package:new_project/data/repository/dota_repository.dart';
import 'package:new_project/presentation/form_submission_status.dart';
import 'package:new_project/presentation/heroInfo/bloc/hero_info_bloc.dart';
import 'package:new_project/presentation/heroInfo/bloc/hero_info_event.dart';
import 'package:new_project/presentation/heroInfo/bloc/hero_info_state.dart';

class HeroView extends StatelessWidget {
  final id = 2;
  //Heroes? myHero;

  const HeroView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HeroInfoBloc>().add(LoadingScreen(id));
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: IconButton(
          alignment: Alignment.centerLeft,
          icon: const Icon
            (Icons.arrow_back),
          onPressed: (){Navigator.pop(context);},
        ),
        title: Align(
          alignment: Alignment.center,
          child: Text(
            '${myHero!.nameLoc}',
            style: const TextStyle(color: Colors.black54, fontSize: 20),
          ),
        ),
      ),*/
      body: BlocProvider(
        create: (context) => HeroInfoBloc(dotaRepository: context.read<DotaRepository>()),
        child: _heroInfoForm(context),
      ),
    );
  }

  Widget _heroInfoForm(BuildContext context){
    return BlocListener<HeroInfoBloc, HeroInfoState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionSuccess){
          myHero = state.hero;
        }
      },
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/background_dota.png'))),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Text('${myHero!.name}'),
            const SizedBox(height: 20,),
            Text('Primary attribute ${myHero!.nameLoc} its ${myHero!.primaryAttr}', style: const TextStyle(fontSize: 30),),
          ],
        ),
      ),
    );
  }
}

