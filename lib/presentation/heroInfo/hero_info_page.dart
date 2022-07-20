import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/data/models/heroAbilities.dart';
import 'package:new_project/data/models/heroInfoDTO.dart';
import 'package:new_project/data/repository/dota_repository.dart';
import 'package:new_project/presentation/appBars/leading_appbar.dart';
import 'package:new_project/presentation/form_submission_status.dart';
import 'package:new_project/presentation/heroInfo/bloc/hero_info_bloc.dart';
import 'package:new_project/presentation/heroInfo/bloc/hero_info_event.dart';
import 'package:new_project/presentation/heroInfo/bloc/hero_info_state.dart';
import 'package:new_project/presentation/utils/UrlUtils.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HeroView extends StatefulWidget {
  const HeroView({Key? key}) : super(key: key);

  @override
  State<HeroView> createState() => _HeroViewState();
}

class _HeroViewState extends State<HeroView> {
  var id;

  DotaHero? myHero;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final args = ModalRoute.of(context)!.settings.arguments as int;
    id = args;
    return Scaffold(
        body: SafeArea(
      child: BlocProvider(
        create: (context) => HeroInfoBloc(dotaRepository: RepositoryProvider.of<DotaRepository>(context)),
        //HeroInfoBloc(dotaRepository: context.read<DotaRepository>()),
        child: _heroInfoForm(context),
      ),
    ));
  }

  Widget _heroInfoForm(BuildContext context) {
    return BlocListener<HeroInfoBloc, HeroInfoState>(listener: (context, state) {
      final formStatus = state.formStatus;

      if (formStatus is FormSubmitting) {
        const CircularProgressIndicator();
      }

      if (formStatus is SubmissionSuccess) {
        setState(() {
          myHero = state.hero;
        });
      }
    }, child: BlocBuilder<HeroInfoBloc, HeroInfoState>(builder: (context, state) {
      context.read<HeroInfoBloc>().add(LoadingScreen(id));
      if (myHero == null) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/background_dota.png'),
            ),
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
              Colors.black87,
              Colors.black54,
            ])),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  LeadingAppBar(myHero!.primaryAttr, myHero!.nameLoc),
                  _attributesHero(),
                  _statsHero(),
                  _abilitiesHero(),
                  _talentsAndAghanimHero(),
                ],
              ),
            ));
      }
    }));
  }

  Widget _attributesHero() {
    return Container(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                _imageAndHealth(),
                const SizedBox(
                  width: 20,
                ),
                _attributes()
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }

  Widget _imageAndHealth() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            UrlUtils().getHeroUrl(myHero!.name),
            height: 100,
            width: 150,
          ),
          Container(
            height: 30,
            width: 150,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.green, Colors.lightGreen])),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    child: Text(
                      '+${myHero!.healthRegen.toStringAsFixed(1)}',
                      style: const TextStyle(fontSize: 13, color: Colors.white),
                    ),
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: false,
                  ),
                  Text(
                    '${myHero!.maxHealth}',
                    style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '+${myHero!.healthRegen.toStringAsFixed(1)}',
                    style: const TextStyle(fontSize: 13, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 30,
            width: 150,
            decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
              Colors.blueAccent,
              Colors.lightBlueAccent,
            ])),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    child: Text(
                      '+${myHero!.manaRegen.toStringAsFixed(1)}',
                      style: const TextStyle(fontSize: 13, color: Colors.white),
                    ),
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: false,
                  ),
                  Text(
                    '${myHero!.maxMana}',
                    style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '+${myHero!.manaRegen.toStringAsFixed(1)}',
                    style: const TextStyle(fontSize: 13, color: Colors.white),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _attributes() {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.network(
                'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/icons/hero_strength.png',
                width: 25,
                height: 25,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                '${myHero?.strBase} + ${myHero?.strGain.toStringAsFixed(1)} for each level',
                style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.network(
                'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/icons/hero_agility.png',
                width: 25,
                height: 25,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                '${myHero?.agiBase} + ${myHero?.agiGain.toStringAsFixed(1)} for each level',
                style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.network(
                'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/icons/hero_intelligence.png',
                height: 25,
                width: 25,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                '${myHero?.intBase} + ${myHero?.intGain.toStringAsFixed(1)} for each level',
                style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              'ATTACK TYPE',
              style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10,
            ),
            _attackType()
          ],
        ),
        Row(
          children: [
            const Text(
              'COMPLEXITY',
              style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10,
            ),
            _complexity()
          ],
        )
      ],
    ));
  }

  Widget _attackType() {
    if (myHero!.attackCapability == 1) {
      return const Image(
        image: AssetImage('assets/melee.png'),
        height: 20,
        width: 20,
        fit: BoxFit.fill,
      );
    } else {
      return const Image(
        image: AssetImage('assets/ranged.png'),
        height: 20,
        width: 20,
        fit: BoxFit.fill,
      );
    }
  }

  Widget _complexity() {
    if (myHero!.complexity == 1) {
      return const Text(
        'EASY',
        style: TextStyle(fontSize: 16, color: Colors.white),
      );
    } else if (myHero!.complexity == 2) {
      return const Text(
        'MEDIUM',
        style: TextStyle(fontSize: 16, color: Colors.white),
      );
    } else {
      return const Text(
        'HARD',
        style: TextStyle(fontSize: 16, color: Colors.white),
      );
    }
  }

  Widget _statsHero() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const Text(
              'STATS',
              style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            IntrinsicHeight(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [_attackHero(), _defenseHero(), _mobilityHero()],
            )),
          ],
        ));
  }

  Widget _attackHero() {
    return Container(
        child: IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            '   ATTACK   ',
            style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Image.network(
                'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react//heroes/stats/icon_damage.png',
                height: 20,
                width: 20,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                '${myHero!.damageMin}-${myHero!.damageMax}',
                style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            children: [
              Image.network(
                'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react//heroes/stats/icon_attack_time.png',
                height: 20,
                width: 20,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                myHero!.attackRate.toStringAsFixed(1),
                style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            children: [
              Image.network(
                'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react//heroes/stats/icon_attack_range.png',
                height: 20,
                width: 20,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                '${myHero!.attackRange}',
                style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            children: [
              Image.network(
                'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react//heroes/stats/icon_projectile_speed.png',
                height: 20,
                width: 20,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                '${myHero!.projectileSpeed}',
                style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    ));
  }

  Widget _defenseHero() {
    return Container(
        alignment: Alignment.topCenter,
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                '   DEFENSE   ',
                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Image.network(
                    'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react//heroes/stats/icon_armor.png',
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    myHero!.armor.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Row(
                children: [
                  Image.network(
                    'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react//heroes/stats/icon_magic_resist.png',
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    '${myHero!.magicResistance}%',
                    style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Widget _mobilityHero() {
    return Container(
        child: IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            '   MOBILITY   ',
            style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Image.network(
                'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react//heroes/stats/icon_movement_speed.png',
                height: 20,
                width: 20,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                '${myHero!.movementSpeed}',
                style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            children: [
              Image.network(
                'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react//heroes/stats/icon_turn_rate.png',
                height: 20,
                width: 20,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                myHero!.turnRate.toStringAsFixed(1),
                style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            children: [
              Image.network(
                'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react//heroes/stats/icon_vision.png',
                height: 20,
                width: 20,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                '${myHero!.sightRangeDay}/${myHero!.sightRangeNight}',
                style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    ));
  }

  Widget _abilitiesHero() {
    return Container(
      child: Column(
        children: [
          const Text(
            'ABILITIES',
            style: const TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          _iconsAbilities(),
        ],
      ),
    );
  }

  Widget _iconsAbilities() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: myHero!.abilities.length,
        itemBuilder: (BuildContext context, int index) {
          return IconButton(
            onPressed: () {
              //Need generate videoname
              var urlAbilityVideo = UrlUtils()
                  .getHeroAbilityVideoUrl(myHero!.name.replaceAll('npc_dota_hero_', ''), myHero!.abilities[index]);
              // add as parameter to _ability info
              _abilityInfo(myHero!.abilities[index], urlAbilityVideo);
            },
            icon: Image.network(
                'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/abilities/${myHero!.abilities[index].name}.png'),
            iconSize: 80,
          );
        },
      ),
    );
  }

  _abilityInfo(Ability ability, String urlAbilityVideo) {
    double widthPhone = MediaQuery.of(context).size.width;
    double heightPhone = MediaQuery.of(context).size.height;
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              content: Container(
                width: widthPhone,
                color: Colors.black,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          _abilityName(ability),
                          _abilityVideo(ability, urlAbilityVideo),
                          Container(
                            padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                            child: Text(
                              ability.descLoc,
                              style: const TextStyle(fontSize: 16, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: _abilityStats(ability),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Column(
                        children: [
                          _abilityCooldowns(ability),
                          _abilityManacost(ability),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        }).then((val) {
      _videoPlayerController.pause();
    });
  }

  Widget _abilityName(Ability ability) {
    return Container(
        width: 500,
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
          Colors.black87,
          Colors.grey,
          Colors.black87,
        ])),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Text(
            ability.nameLoc,
            style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ));
  }

  late VideoPlayerController _videoPlayerController;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Widget _abilityVideo(Ability ability, String urlAbilityVideo) {
    _videoPlayerController = VideoPlayerController.network(urlAbilityVideo)
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });

    return Container(
      padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
      height: 180,
      width: 320,
      child: VideoPlayer(_videoPlayerController),
    );
  }

  Widget _abilityMechanic(Ability ability) {
    return Container(
      color: Colors.red,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
            child: Text(
              ability.descLoc,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          _abilityStats(ability),
          _abilityCooldowns(ability),
          _abilityManacost(ability),
        ],
      ),
    );
  }

  Widget _abilityStats(Ability ability) {
    List<String> statsList = [];

    for (var item in ability.specialValues) {
      if (item.headingLoc.isEmpty) {
        continue;
      }
      var isBigZero = item.valuesFloat.every((element) => element > 0);
      if (isBigZero) {
        var values = item.valuesFloat.map((e) => e.toStringAsFixed(1));
        var valuesAsString = '${item.headingLoc} ${values.join(' / ')}';
        statsList.add(valuesAsString);
      }
    }

    return Container(
        padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
        child: Column(
          children: [
            for (var value in statsList)
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              )
          ],
        ));
  }

  Widget _abilityCooldowns(Ability ability) {
    String cd = '';
    double sum = 0;
    for (var value in ability.cooldowns) {
      cd += value.toString();
      cd += ' / ';
      sum += value;
    }
    cd = cd.substring(0, cd.length - 3);
    if (sum > 0) {
      return Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
        child: Row(
          children: [
            Image.network(
              'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/icons/cooldown.png',
              height: 20,
              width: 20,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              cd,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _abilityManacost(Ability ability) {
    String mc = '';
    double sum = 0;
    for (var value in ability.manaCosts) {
      mc += value.toString();
      mc += ' / ';
      sum += value;
    }
    mc = mc.substring(0, mc.length - 3);
    if (sum > 0) {
      return Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
        child: Row(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.lightBlue, Colors.blue])),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              mc,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _talentsAndAghanimHero() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _talentsTree(),
          _aghanimScepter(),
          _aghanimShard(),
        ],
      ),
    );
  }

  Widget _talentsTree() {
    return Container(
      child: IconButton(
        onPressed: () {
          _talentsInfo();
        },
        iconSize: 100,
        icon: const Image(
          image: AssetImage('assets/talents.png'),
        ),
      ),
    );
  }

  _talentsInfo() {
    double widthPhone = MediaQuery.of(context).size.width;
    double heightPhone = MediaQuery.of(context).size.height;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
            contentPadding: const EdgeInsets.all(0),
            content: Container(
              width: widthPhone,
              height: heightPhone,
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                  Colors.grey.shade800,
                  Colors.grey.shade900,
                ]),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                      width: widthPhone,
                      child: const Text(
                        'TALENT TREE',
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      width: widthPhone,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            width: widthPhone / 2 + 60,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.yellow.shade700),
                                gradient:
                                    LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                                  Colors.grey.shade700,
                                  Colors.grey.shade800,
                                ])),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                myHero!.talents[7].nameLoc
                                    .replaceAll('{s:value}', myHero!.talents[7].specialValues[7].valuesFloat.toString())
                                    .replaceAll('[', '')
                                    .replaceAll(']', ''),
                                style: const TextStyle(fontSize: 18, color: Colors.white70),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                                Colors.black87,
                                Colors.grey.shade700,
                              ]),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[600],
                              ),
                              child: GradientText(
                                '25',
                                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                                colors: [
                                  Colors.yellow.shade900,
                                  Colors.yellow.shade700,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      width: widthPhone,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                                Colors.black87,
                                Colors.grey.shade700,
                              ]),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[600],
                              ),
                              child: GradientText(
                                '25',
                                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                                colors: [
                                  Colors.yellow.shade900,
                                  Colors.yellow.shade700,
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            width: widthPhone / 2 + 60,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.yellow.shade700),
                                gradient:
                                    LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                                  Colors.grey.shade700,
                                  Colors.grey.shade800,
                                ])),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                myHero!.talents[6].nameLoc
                                    .replaceAll('{s:value}', myHero!.talents[6].specialValues[6].valuesFloat.toString())
                                    .replaceAll('[', '')
                                    .replaceAll(']', ''),
                                style: const TextStyle(fontSize: 18, color: Colors.white70),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      width: widthPhone,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            width: widthPhone / 2 + 60,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.yellow.shade700),
                                gradient:
                                    LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                                  Colors.grey.shade700,
                                  Colors.grey.shade800,
                                ])),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                myHero!.talents[5].nameLoc
                                    .replaceAll('{s:value}', myHero!.talents[5].specialValues[5].valuesFloat.toString())
                                    .replaceAll('[', '')
                                    .replaceAll(']', ''),
                                style: const TextStyle(fontSize: 18, color: Colors.white70),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                                Colors.black87,
                                Colors.grey.shade700,
                              ]),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[600],
                              ),
                              child: GradientText(
                                '20',
                                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                                colors: [
                                  Colors.yellow.shade900,
                                  Colors.yellow.shade700,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      width: widthPhone,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                                Colors.black87,
                                Colors.grey.shade700,
                              ]),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[600],
                              ),
                              child: GradientText(
                                '20',
                                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                                colors: [
                                  Colors.yellow.shade900,
                                  Colors.yellow.shade700,
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            width: widthPhone / 2 + 60,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.yellow.shade700),
                                gradient:
                                    LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                                  Colors.grey.shade700,
                                  Colors.grey.shade800,
                                ])),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                myHero!.talents[4].nameLoc
                                    .replaceAll('{s:value}', myHero!.talents[4].specialValues[4].valuesFloat.toString())
                                    .replaceAll('[', '')
                                    .replaceAll(']', ''),
                                style: const TextStyle(fontSize: 18, color: Colors.white70),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      width: widthPhone,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            width: widthPhone / 2 + 60,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.yellow.shade700),
                                gradient:
                                    LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                                  Colors.grey.shade700,
                                  Colors.grey.shade800,
                                ])),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                myHero!.talents[3].nameLoc
                                    .replaceAll('{s:value}', myHero!.talents[3].specialValues[3].valuesFloat.toString())
                                    .replaceAll('[', '')
                                    .replaceAll(']', ''),
                                style: const TextStyle(fontSize: 18, color: Colors.white70),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                                Colors.black87,
                                Colors.grey.shade700,
                              ]),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[600],
                              ),
                              child: GradientText(
                                '15',
                                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                                colors: [
                                  Colors.yellow.shade900,
                                  Colors.yellow.shade700,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      width: widthPhone,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                                Colors.black87,
                                Colors.grey.shade700,
                              ]),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[600],
                              ),
                              child: GradientText(
                                '15',
                                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                                colors: [
                                  Colors.yellow.shade900,
                                  Colors.yellow.shade700,
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            width: widthPhone / 2 + 60,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.yellow.shade700),
                                gradient:
                                    LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                                  Colors.grey.shade700,
                                  Colors.grey.shade800,
                                ])),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                myHero!.talents[2].nameLoc
                                    .replaceAll('{s:value}', myHero!.talents[2].specialValues[2].valuesFloat.toString())
                                    .replaceAll('[', '')
                                    .replaceAll(']', ''),
                                style: const TextStyle(fontSize: 18, color: Colors.white70),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      width: widthPhone,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            width: widthPhone / 2 + 60,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.yellow.shade700),
                                gradient:
                                    LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                                  Colors.grey.shade700,
                                  Colors.grey.shade800,
                                ])),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                myHero!.talents[1].nameLoc
                                    .replaceAll('{s:value}', myHero!.talents[1].specialValues[1].valuesFloat.toString())
                                    .replaceAll('[', '')
                                    .replaceAll(']', ''),
                                style: const TextStyle(fontSize: 18, color: Colors.white70),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                                Colors.black87,
                                Colors.grey.shade700,
                              ]),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[600],
                              ),
                              child: GradientText(
                                '10',
                                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                                colors: [
                                  Colors.yellow.shade900,
                                  Colors.yellow.shade700,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      width: widthPhone,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                                Colors.black87,
                                Colors.grey.shade700,
                              ]),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[600],
                              ),
                              child: GradientText(
                                '10',
                                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                                colors: [
                                  Colors.yellow.shade900,
                                  Colors.yellow.shade700,
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            width: widthPhone / 2 + 60,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.yellow.shade700),
                                gradient:
                                    LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                                  Colors.grey.shade700,
                                  Colors.grey.shade800,
                                ])),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                myHero!.talents[0].nameLoc
                                    .replaceAll('{s:value}', myHero!.talents[0].specialValues[0].valuesFloat.toString())
                                    .replaceAll('[', '')
                                    .replaceAll(']', ''),
                                style: const TextStyle(fontSize: 18, color: Colors.white70),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _aghanimScepter() {
    return Container(
      child: IconButton(
        onPressed: () {
          print('scepter');
        },
        iconSize: 100,
        icon: const Image(
          image: AssetImage('assets/scepter.png'),
        ),
      ),
    );
  }

  Widget _aghanimShard() {
    return Container(
      child: IconButton(
        onPressed: () {
          print('shard');
        },
        iconSize: 100,
        icon: const Image(
          image: AssetImage('assets/aghanim2.png'),
        ),
      ),
    );
  }
}
