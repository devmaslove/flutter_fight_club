import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_club_colors.dart';
import 'package:flutter_fight_club/fight_club_icons.dart';
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

  BobyPart? defendingBodyPart;
  BobyPart? attackingBodyPart;

  BobyPart whatEnemyAttacks = BobyPart.random();
  BobyPart whatEnemyDefends = BobyPart.random();

  int yourLives = maxLives;
  int enemysLives = maxLives;

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
            Expanded(child: SizedBox()),
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
        whatEnemyDefends = BobyPart.random();
        whatEnemyAttacks = BobyPart.random();
        defendingBodyPart = null;
        attackingBodyPart = null;
      });
    }
  }

  void _selectDefendingBodyPart(BobyPart value) {
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

  void _selectAttackingBodyPart(BobyPart value) {
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          LivesWidget(
            overallLivesCount: maxLivesCount,
            currentLivesCount: yourLives,
          ),
          Column(
            children: [
              const SizedBox(height: 16),
              Text('You'),
              const SizedBox(height: 12),
              ColoredBox(
                color: Colors.red,
                child: SizedBox(
                  width: 92,
                  height: 92,
                ),
              ),
            ],
          ),
          ColoredBox(
            color: Colors.green,
            child: SizedBox(
              width: 44,
              height: 44,
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 16),
              Text('Enemy'),
              const SizedBox(height: 12),
              ColoredBox(
                color: Colors.blue,
                child: SizedBox(
                  width: 92,
                  height: 92,
                ),
              ),
            ],
          ),
          LivesWidget(
            overallLivesCount: maxLivesCount,
            currentLivesCount: enemysLives,
          ),
        ],
      ),
    );
  }
}

class BobyPart {
  final String name;

  const BobyPart._(this.name);

  static const head = BobyPart._('Head');
  static const torso = BobyPart._('Torso');
  static const legs = BobyPart._('Legs');

  @override
  String toString() {
    return 'BobyPart{name: $name}';
  }

  static const List<BobyPart> _values = [head, torso, legs];

  static BobyPart random() {
    return _values[Random().nextInt(_values.length)];
  }
}

class BodyPartButton extends StatelessWidget {
  final BobyPart bodyPart;
  final bool selected;
  final ValueSetter<BobyPart> bodyPartSetter;

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
          color: selected ? FightClubColors.blueButton : FightClubColors.greyButton,
          child: Center(
            child: Text(
              bodyPart.name.toUpperCase(),
              style: TextStyle(
                fontSize: 13,
                color: selected ? FightClubColors.whiteText : FightClubColors.darkGreyText,
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
          return Image.asset(
            FightClubIcons.heartFull,
            width: 18,
            height: 18,
          );
        } else {
          return Image.asset(
            FightClubIcons.heartEmpty,
            width: 18,
            height: 18,
          );
        }
      }),
    );
  }
}

class ControlsWidget extends StatelessWidget {
  final BobyPart? defendingBodyPart;
  final ValueSetter<BobyPart> selectDefendingBodyPart;

  final BobyPart? attackingBodyPart;
  final ValueSetter<BobyPart> selectAttackingBodyPart;

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
                style: TextStyle(color: FightClubColors.darkGreyText, fontSize: 16),
              ),
              SizedBox(height: 13),
              BodyPartButton(
                bodyPart: BobyPart.head,
                selected: defendingBodyPart == BobyPart.head,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BobyPart.torso,
                selected: defendingBodyPart == BobyPart.torso,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BobyPart.legs,
                selected: defendingBodyPart == BobyPart.legs,
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
                style: TextStyle(color: FightClubColors.darkGreyText, fontSize: 16),
              ),
              SizedBox(height: 13),
              BodyPartButton(
                bodyPart: BobyPart.head,
                selected: attackingBodyPart == BobyPart.head,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BobyPart.torso,
                selected: attackingBodyPart == BobyPart.torso,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BobyPart.legs,
                selected: attackingBodyPart == BobyPart.legs,
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
