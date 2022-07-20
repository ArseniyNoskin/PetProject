import 'package:flutter/material.dart';
import 'package:new_project/presentation/routes/appRoutes.dart';

class LeadingAppBar extends StatelessWidget {
  const LeadingAppBar(this.primaryAttr, this.nameLoc, {Key? key}) : super(key: key);

  final int primaryAttr;
  final String nameLoc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.red,
            Colors.black12
          ]
        ),
      ),
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _backButton(context),
          Row(
            children: [_iconAttr(), _nameHero()],
          ),
        ],
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.listHeroes);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  Widget _iconAttr() {
    if(primaryAttr == 0){
      return Image.network('https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/icons/hero_strength.png');
    }else if (primaryAttr == 1){
      return Image.network('https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/icons/hero_agility.png');
    }else{
      return Image.network('https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/icons/hero_intelligence.png');
    }
  }

  Widget _nameHero() {
    return Text(
      nameLoc,
      style: const TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}
