import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BobyPart? defendingBodyPart;
  BobyPart? attackingBodyPart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD5DEF0),
      body: Column(
        children: [
          SizedBox(height: 40),
          RowResults(leftText: 'You', rightText: 'Enemy'),
          RowResults(leftText: '1', rightText: '1'),
          RowResults(leftText: '1', rightText: '1'),
          RowResults(leftText: '1', rightText: '1'),
          RowResults(leftText: '1', rightText: '1'),
          RowResults(leftText: '1', rightText: '1'),
          Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Defend'.toUpperCase(),
                      style: TextStyle(color: Color(0xFF151616), fontSize: 16),
                    ),
                    SizedBox(height: 13),
                    BodyPartButton(
                      bodyPart: BobyPart.head,
                      selected: defendingBodyPart == BobyPart.head,
                      bodyPartSetter: _selectDefendingBodyPart,
                    ),
                    SizedBox(height: 14),
                    BodyPartButton(
                      bodyPart: BobyPart.torso,
                      selected: defendingBodyPart == BobyPart.torso,
                      bodyPartSetter: _selectDefendingBodyPart,
                    ),
                    SizedBox(height: 14),
                    BodyPartButton(
                      bodyPart: BobyPart.legs,
                      selected: defendingBodyPart == BobyPart.legs,
                      bodyPartSetter: _selectDefendingBodyPart,
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
                      style: TextStyle(color: Color(0xFF151616), fontSize: 16),
                    ),
                    SizedBox(height: 13),
                    BodyPartButton(
                      bodyPart: BobyPart.head,
                      selected: attackingBodyPart == BobyPart.head,
                      bodyPartSetter: _selectAttackingBodyPart,
                    ),
                    SizedBox(height: 14),
                    BodyPartButton(
                      bodyPart: BobyPart.torso,
                      selected: attackingBodyPart == BobyPart.torso,
                      bodyPartSetter: _selectAttackingBodyPart,
                    ),
                    SizedBox(height: 14),
                    BodyPartButton(
                      bodyPart: BobyPart.legs,
                      selected: attackingBodyPart == BobyPart.legs,
                      bodyPartSetter: _selectAttackingBodyPart,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
          SizedBox(height: 14),
          Row(
            children: [
              SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () => _pushGoButton(),
                  child: SizedBox(
                    height: 40,
                    child: ColoredBox(
                      color: _getGoColor(),
                      child: Center(
                        child: Text(
                          'Go'.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color(0xFFFFFFDE),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  void _selectDefendingBodyPart(BobyPart value) {
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectAttackingBodyPart(BobyPart value) {
    setState(() {
      attackingBodyPart = value;
    });
  }

  void _pushGoButton() {
    if (defendingBodyPart != null && attackingBodyPart != null) {
      setState(() {
        defendingBodyPart = null;
        attackingBodyPart = null;
      });
    }
  }

  Color _getGoColor() {
    if (defendingBodyPart != null && attackingBodyPart != null) {
      return Colors.black87;
    } else {
      return Colors.black38;
    }
  }
}

class RowResults extends StatelessWidget {
  final String leftText;
  final String rightText;

  const RowResults({
    Key? key,
    required this.leftText,
    required this.rightText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 16),
        Expanded(
          child: Center(
            child: Text(
              leftText,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF151616),
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Center(
            child: Text(
              rightText,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF151616),
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
      ],
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
          color: selected ? const Color(0xFF1C79CE) : Colors.black38,
          child: Center(
            child: Text(
              bodyPart.name.toUpperCase(),
              style: TextStyle(
                fontSize: 13,
                color: selected ? Colors.white : Color(0xFF060D14),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
