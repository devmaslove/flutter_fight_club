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
      body: Column(
        children: [
          SizedBox(height: 40),
          Row(
            children: [
              SizedBox(width: 16),
              Expanded(child: Center(child: Text('You'))),
              SizedBox(width: 12),
              Expanded(child: Center(child: Text('Enemy'))),
              SizedBox(width: 16),
            ],
          ),
          Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Text('Defend'.toUpperCase()),
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
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    Text('Attack'.toUpperCase()),
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
                child: SizedBox(
                  height: 40,
                  child: ColoredBox(
                    color: Colors.black87,
                    child: Center(
                      child: Text(
                        'Go'.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: Colors.white,
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
}

class BobyPart {
  final String name;

  const BobyPart._(this.name);

  static const head = BobyPart._('Head');
  static const torso = BobyPart._('Torso');

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
          color:
              selected ? const Color.fromRGBO(28, 121, 206, 1) : Colors.black26,
          child: Center(
            child: Text(bodyPart.name.toUpperCase()),
          ),
        ),
      ),
    );
  }
}
