import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Text(
                'Statistics',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: FightClubColors.darkGreyText,
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Column(
              children: [
                FutureBuilder<int?>(
                  future: SharedPreferences.getInstance().then(
                      (sharedPreferences) =>
                          sharedPreferences.getInt('stats_won')),
                  builder: (context, snapshot) {
                    int count = 0;
                    if (snapshot.hasData && snapshot.data != null) {
                      count = snapshot.data!;
                    }
                    return Text(
                      'Won: $count',
                      style: TextStyle(
                        fontSize: 16,
                        color: FightClubColors.darkGreyText,
                        height: 2.5,
                      ),
                    );
                  },
                ),
                SizedBox(height: 6),
                FutureBuilder<int?>(
                  future: SharedPreferences.getInstance().then(
                          (sharedPreferences) =>
                          sharedPreferences.getInt('stats_draw')),
                  builder: (context, snapshot) {
                    int count = 0;
                    if (snapshot.hasData && snapshot.data != null) {
                      count = snapshot.data!;
                    }
                    return Text(
                      'Draw: $count',
                      style: TextStyle(
                        fontSize: 16,
                        color: FightClubColors.darkGreyText,
                        height: 2.5,
                      ),
                    );
                  },
                ),
                SizedBox(height: 6),
                FutureBuilder<int?>(
                  future: SharedPreferences.getInstance().then(
                          (sharedPreferences) =>
                          sharedPreferences.getInt('stats_lost')),
                  builder: (context, snapshot) {
                    int count = 0;
                    if (snapshot.hasData && snapshot.data != null) {
                      count = snapshot.data!;
                    }
                    return Text(
                      'Lost: $count',
                      style: TextStyle(
                        fontSize: 16,
                        color: FightClubColors.darkGreyText,
                        height: 2.5,
                      ),
                    );
                  },
                ),
              ],
            ),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SecondaryActionButton(
                onTap: () {
                  Navigator.of(context).pop();
                },
                text: 'Back',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
