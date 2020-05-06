import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.blue,
      disabledColor: Colors.grey,
    ),
    title: 'Flutter App',
    initialRoute: '/',
    routes: {
      '/': (context) {
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
        return DefaultTabController(
          length: jobTab.length,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Job List'),
              centerTitle: true,
              bottom: TabBar(
                isScrollable: true,
                tabs: jobTab.map((v) {
                  return Tab(
                    text: v,
                  );
                }).toList(),
              ),
            ),
            body: JobList(),
          ),
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
          body: Notifications(),
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
          body: Commissions(),
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
          body: AccountSettings(),
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
                          onPressed: () {
                            if (v != 'Logout')
                              Navigator.pushNamed(
                                  context, '/${v.replaceAll(' ', '')}');
                          },
                          color: v == 'Logout'
                              ? Colors.red
                              : Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          disabledColor: Theme.of(context).disabledColor,
                          disabledTextColor: Colors.black,
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

const List<String> jobTab = ['Ongoing', 'Pending', 'Completed', 'Declined'];
//List<TabController> jobTabController = List.generate(jobTab.length, (i)=> new TabController());

class JobList extends StatefulWidget {
  @override
  _JobListState createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: jobTab.map((v) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(v),
        );
      }).toList(),
    );
  }
}

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Not');
  }
}

class Commissions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Com');
  }
}

class AccountSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Acct');
  }
}

//***********************************
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