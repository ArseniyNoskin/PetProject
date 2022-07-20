# Introduction 
Приложение для просмотра основной информации о героях Dota2, а так же их характеристик и умений.
Данные обновляються с официального сайта www.dota2.com

Основная ветка develop
Так же реализовано логин\регистрацию с использованием базы данных. Для комфортного просмотра выключено на уровне навигации

### Preview
<summary>Some screenshots</summary>
    <p align="center">
      <img src="data/heroList.jpg" width="20%"/>
      <img src="data/searchHeroList.jpg" width="20%"/>
      <img src="data/heroInfo.jpg" width="20%"/>
      <img src="data/abilityInfo.jpg" width="20%"/>
      <img src="data/talentsTree.jpg" width="20%"/>
    </p>


### Architecture

* [Flutter](https://flutter.dev/) 100%,
* [Flutter_Bloc](https://pub.dev/packages/flutter_bloc) 100%,

* Presentation layer pattern - BLOCK

### Libraries
* DI
  * [BlocProvider](https://pub.dev/packages/flutter_bloc)

* DataBase
  * [Floor](https://pub.dev/packages/floor)

* Internet
  * [Http](https://pub.dev/packages/http)
  * [Dio](https://pub.dev/packages/dio)

* Other
  * [Cupertino icons](https://pub.dev/packages/cupertino_icons)
  * [Simple gradient text](https://pub.dev/packages/simple_gradient_text)
  * [Video Player](https://pub.dev/packages/video_player)
