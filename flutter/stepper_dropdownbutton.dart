import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Radio Button'),
          ),
          body: MyApp(),
        );
      }
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentStep = 0;
  List<bool> _isActiveList = [true, false, false];
  String _value1 = 'Null';

  String _value2 = 'Null';
  String _value3 = 'Null';
  final List<String> _catagory = [
    'Null',
    'posts',
    'comments',
    'albums',
    'photos',
    'todos',
    'users'
  ];
  final List<String> _page = [
    'Null',
    ...List.generate(6, (v) => (v + 1).toString())
  ];
  final List<StepState> _stepState = [
    StepState.indexed,
    StepState.indexed,
    StepState.indexed
  ];

  Widget _dropdownbutton(List<String> _items) {
    return DropdownButton<String>(
      elevation: 85,
      icon: Icon(Icons.arrow_downward),
      underline: Container(
        height: 2,
        color: Colors.red,
      ),
      style: TextStyle(fontSize: 21, color: Colors.green),
      onChanged: (v) {
        setState(() {
          _items[1] == '1' ? _value1 = v : _value2 = v;
        });
      },
      value: _items[1] == '1' ? _value1 : _value2,
      items: [
        for (var x in _items)
          DropdownMenuItem(
            value: x,
            child: Text(x),
          ),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Flexible(
              flex: 8,
                child: Stepper(
                  currentStep: _currentStep,
                  onStepTapped: (x) {
                    setState(() {
                      _currentStep = x;
                      if (_currentStep < 2)
                        _currentStep == 0 ? _value2 = 'Null' : _value1 = 'Null';
                    });
                  },
                  onStepContinue: () {
                    setState(() {

                      if (_currentStep < 2)
                        switch (_currentStep) {
                          case 0:
                            {
                              _value2 == 'Null' ?  _stepState[0] = StepState.error : _stepState[0] = StepState.indexed;
                            }
                            break;
                          case 1:
                            {
                              _value1 == 'Null' ? _stepState[1] = StepState.error : _stepState[1] = StepState.indexed;
                            }
                            break;
                          default: {

                          }
                          break;
                        };
                      if (_currentStep == 2)
                        setState(() {
                          _value3 = ('Catagory - $_value2, Page - $_value1');
                        });

                      if (_currentStep < _isActiveList.length - 1) {
                        _currentStep++;
                        _isActiveList[_currentStep] = true;
                      }
                    });
                    print('Continue...');
                  },
                  onStepCancel: () {
                    print('Cancel...');
                  },
                  steps: [
                    Step(
                        state: _stepState[0],
                        title: Text('Web Address'),
                        subtitle: Text(_value2),
                        content: _dropdownbutton(_catagory),
                        isActive: _isActiveList[0]),
                    Step(
                        state: _stepState[1],
                        title: Text('Page Number'),
                        subtitle: Text(_value1),
                        content: _dropdownbutton(_page),
                        isActive: _isActiveList[1]),
                    Step(
                        state: _stepState[2],
                        title: Text('Go to Page'),
                        content: Text(''),
                        isActive: _isActiveList[2])
                  ],
                ),),
            Flexible(
              flex: 3,

                child: Stack(
                  children: <Widget>[
                    Container( color: Colors.red),
                    Center(child: Text(_value3, style: TextStyle(fontSize: 20),)),
                  ],

                ),

            )

          ],

        );
      },
    );
  }
}
