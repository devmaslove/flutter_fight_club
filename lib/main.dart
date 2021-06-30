import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_club_colors.dart';
import 'package:flutter_fight_club/fight_club_icons.dart';
import 'package:flutter_fight_club/fight_club_images.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        textTheme: GoogleFonts.pressStart2pTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static const maxLives = 5;

  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;

  BodyPart whatEnemyAttacks = BodyPart.random();
  BodyPart whatEnemyDefends = BodyPart.random();

  int yourLives = maxLives;
  int enemysLives = maxLives;

  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            FightersInfo(
              yourLives: yourLives,
              enemysLives: enemysLives,
              maxLivesCount: maxLives,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 30,
                ),
                child: ColoredBox(
                  color: Color.fromRGBO(197, 209, 234, 1),
                  child: SizedBox(
                    width: double.infinity,
                    height: 146,
                    child: Center(
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: FightClubColors.darkGreyText,
                          fontSize: 10,
                          height: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ControlsWidget(
              defendingBodyPart: defendingBodyPart,
              selectDefendingBodyPart: _selectDefendingBodyPart,
              attackingBodyPart: attackingBodyPart,
              selectAttackingBodyPart: _selectAttackingBodyPart,
            ),
            SizedBox(height: 14),
            GoButton(
              onTap: _pushGoButton,
              color: _getGoColor(),
              text:
                  yourLives == 0 || enemysLives == 0 ? 'Start new game' : 'Go',
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _pushGoButton() {
    if (yourLives == 0 || enemysLives == 0) {
      setState(() {
        yourLives = maxLives;
        enemysLives = maxLives;
        text = '';
      });
    } else if (defendingBodyPart != null && attackingBodyPart != null) {
      setState(() {
        final bool enemyLooseFife = attackingBodyPart != whatEnemyDefends;
        final bool youLooseFife = defendingBodyPart != whatEnemyAttacks;
        if (enemyLooseFife) {
          enemysLives--;
        }
        if (youLooseFife) {
          yourLives--;
        }
        if ( yourLives == 0 && enemysLives == 0 ) {
          text = 'Draw';
        } else if ( yourLives == 0 ) {
          text = 'You lost';
        } else if ( enemysLives == 0 ) {
          text = 'You won';
        } else {
          text = '';
          if (enemyLooseFife) {
            text += 'You hit enemy’s ${attackingBodyPart?.name.toLowerCase()}.';
          } else {
            text += 'Your attack was blocked.';
          }
          text += '\n';
          if (youLooseFife) {
            text += 'Enemy hit your ${whatEnemyAttacks.name.toLowerCase()}.';
          } else {
            text += 'Enemy’s attack was blocked.';
          }
        }
        whatEnemyDefends = BodyPart.random();
        whatEnemyAttacks = BodyPart.random();
        defendingBodyPart = null;
        attackingBodyPart = null;
      });
    }
  }

  void _selectDefendingBodyPart(BodyPart value) {
    if (yourLives > 0 && enemysLives > 0) {
      setState(() {
        defendingBodyPart = value;
      });
    }
  }

  Color _getGoColor() {
    if (yourLives == 0 || enemysLives == 0) {
      return FightClubColors.blackButton;
    }
    if (defendingBodyPart != null && attackingBodyPart != null) {
      return FightClubColors.blackButton;
    }
    return FightClubColors.greyButton;
  }

  void _selectAttackingBodyPart(BodyPart value) {
    if (yourLives > 0 && enemysLives > 0) {
      setState(() {
        attackingBodyPart = value;
      });
    }
  }
}

class GoButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final String text;

  const GoButton({
    Key? key,
    required this.onTap,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () => onTap(),
        child: SizedBox(
          height: 40,
          child: ColoredBox(
            color: color,
            child: Center(
              child: Text(
                text.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: FightClubColors.whiteText,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FightersInfo extends StatelessWidget {
  final int maxLivesCount;
  final int yourLives;
  final int enemysLives;

  const FightersInfo({
    Key? key,
    required this.maxLivesCount,
    required this.yourLives,
    required this.enemysLives,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ColoredBox(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LivesWidget(
                    overallLivesCount: maxLivesCount,
                    currentLivesCount: yourLives,
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        'You',
                        style: TextStyle(
                          fontSize: 14,
                          color: FightClubColors.darkGreyText,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Image.asset(
                        FightClubImages.youAvatar,
                        width: 92,
                        height: 92,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ColoredBox(
              color: Color.fromRGBO(197, 209, 234, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        'Enemy',
                        style: TextStyle(
                          fontSize: 14,
                          color: FightClubColors.darkGreyText,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Image.asset(
                        FightClubImages.enemyAvatar,
                        width: 92,
                        height: 92,
                      ),
                    ],
                  ),
//                  const SizedBox(width: 16),
                  LivesWidget(
                    overallLivesCount: maxLivesCount,
                    currentLivesCount: enemysLives,
                  ),
//                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._('Head');
  static const torso = BodyPart._('Torso');
  static const legs = BodyPart._('Legs');

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }

  static const List<BodyPart> _values = [head, torso, legs];

  static BodyPart random() {
    return _values[Random().nextInt(_values.length)];
  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButton({
    Key? key,
    required this.bodyPart,
    required this.selected,
    required this.bodyPartSetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        child: ColoredBox(
          color: selected
              ? FightClubColors.blueButton
              : FightClubColors.greyButton,
          child: Center(
            child: Text(
              bodyPart.name.toUpperCase(),
              style: TextStyle(
                fontSize: 13,
                color: selected
                    ? FightClubColors.whiteText
                    : FightClubColors.darkGreyText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LivesWidget extends StatelessWidget {
  final int overallLivesCount;
  final int currentLivesCount;

  const LivesWidget({
    Key? key,
    required this.overallLivesCount,
    required this.currentLivesCount,
  })  : assert(overallLivesCount >= 1),
        assert(currentLivesCount >= 0),
        assert(currentLivesCount <= overallLivesCount),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(overallLivesCount, (index) {
        if (index < currentLivesCount) {
          return Padding(
            padding: index < overallLivesCount - 1
                ? const EdgeInsets.only(bottom: 4)
                : const EdgeInsets.only(),
            child: Image.asset(
              FightClubIcons.heartFull,
              width: 18,
              height: 18,
            ),
          );
        } else {
          return Padding(
            padding: index < overallLivesCount - 1
                ? const EdgeInsets.only(bottom: 4)
                : const EdgeInsets.only(),
            child: Image.asset(
              FightClubIcons.heartEmpty,
              width: 18,
              height: 18,
            ),
          );
        }
      }),
    );
  }
}

class ControlsWidget extends StatelessWidget {
  final BodyPart? defendingBodyPart;
  final ValueSetter<BodyPart> selectDefendingBodyPart;

  final BodyPart? attackingBodyPart;
  final ValueSetter<BodyPart> selectAttackingBodyPart;

  const ControlsWidget({
    Key? key,
    required this.defendingBodyPart,
    required this.selectDefendingBodyPart,
    required this.attackingBodyPart,
    required this.selectAttackingBodyPart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              Text(
                'Defend'.toUpperCase(),
                style: TextStyle(
                    color: FightClubColors.darkGreyText, fontSize: 16),
              ),
              SizedBox(height: 13),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: defendingBodyPart == BodyPart.head,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: defendingBodyPart == BodyPart.torso,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: defendingBodyPart == BodyPart.legs,
                bodyPartSetter: selectDefendingBodyPart,
              ),
            ],
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              Text(
                'Attack'.toUpperCase(),
                style: TextStyle(
                    color: FightClubColors.darkGreyText, fontSize: 16),
              ),
              SizedBox(height: 13),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: attackingBodyPart == BodyPart.head,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: attackingBodyPart == BodyPart.torso,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: attackingBodyPart == BodyPart.legs,
                bodyPartSetter: selectAttackingBodyPart,
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}
