import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.blue,
      disabledColor: Colors.grey,
    ),
    title: 'Flutter App',
    initialRoute: '/Home',
    routes: {
      '/Home': (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Home'),
            centerTitle: true,
          ),
          body: Home(),
        );
      },
      '/JobList': (
        context,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Job List'),
            centerTitle: true,
          ),
          body: JobList(),
        );
      },
      '/Notifications': (
        context,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Notifications'),
            centerTitle: true,
          ),
          body: JobList(),
        );
      },
      '/Commissions': (
        context,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Commissions'),
            centerTitle: true,
          ),
          body: JobList(),
        );
      },
      '/AccountSettings': (
        context,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Account Settings'),
            centerTitle: true,
          ),
          body: JobList(),
        );
      },
    },
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> _buttonText = [
    'Job List',
    'Notifications',
    'Commissions',
    'Account Settings',
    'Logout'
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        print(constraints.biggest);
        return Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _buttonText
              .map((v) => Center(
                    child: SafeArea(
                      child: FractionallySizedBox(
                        widthFactor: 0.5,
                        alignment: Alignment.centerLeft,
                        child: FlatButton(
                          child: Text(v == 'Commissions' ? v + ' Earned' : v),
                          onPressed: () {},
                          color: v == 'Logout'
                              ? Colors.red
                              : Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          disabledColor: Theme.of(context).disabledColor,
                          disabledTextColor: Colors.black,
                          //padding: EdgeInsets.all(8.0),
                          splashColor: v == 'Logout'
                              ? Colors.redAccent
                              : Colors.blueAccent,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        );
      },
    );
  }
}

class JobList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Commissions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AccountSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
