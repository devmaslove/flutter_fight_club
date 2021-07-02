import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/resources/fight_club_images.dart';

class FightResultWidget extends StatelessWidget {
  final FightResult fightResult;
  const FightResultWidget({Key? key, required this.fightResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        FightClubColors.darkPurple,
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: FightClubColors.darkPurple,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const SizedBox(height: 12),
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
              Container(
                height: 44,
                padding: EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: _getResultColor(fightResult),
                ),
                child: Text(
                  fightResult.result.toLowerCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 12),
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
            ],
          ),
        ],
      ),
    );
  }
  
  static Color _getResultColor( FightResult fightResult ) {
    if ( fightResult == FightResult.won ) {
      return Color.fromRGBO(3, 136, 0, 1);
    } else if ( fightResult == FightResult.lost ) {
      return Color.fromRGBO(234, 44, 44, 1);
    } else if ( fightResult == FightResult.draw ) {
      return Color.fromRGBO(28, 121, 206, 1);
    }
    return Colors.transparent;
  }
}
