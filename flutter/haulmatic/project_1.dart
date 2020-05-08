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
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('HaulMatic Technology', style: TextStyle(color: Colors.white, fontSize: 19.0) ),
                Container(height: 8,),
                Text('Driver Mobile Application', style: TextStyle(color: Colors.white, fontSize: 16.0))
              ],
            ),
            centerTitle: true,
          ),
          body: Login(),
        );
      },
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
        return DefaultTabController(
          length: jobTab.length,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Job List'),
              centerTitle: true,
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: Colors.orange,
                indicatorWeight: 5,
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
        return DefaultTabController(
          length: commissionTab.length,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Commissions'),
              centerTitle: true,
              bottom: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.orange,
                  indicatorWeight: 5,
                  tabs: commissionTab.map((v) {
                    return Text(v);
                  }).toList()),
            ),
            body: Commissions(),
          ),
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

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          child: Image.asset('./assets/google_login.png'),
          onTap: (){
            Navigator.pushNamed(
                context, '/Home');
          },
      ),
    );
  }
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
const List<String> commissionTab = ['Today', 'This Week', 'This Month'];
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
          padding: EdgeInsets.only(top: 25),
          child: ListView(
            children: <Widget>[
              for (var x = 0; x < 5; x++)
                Ink(
                  color: x % 2 == 0 ? Colors.grey : null,
                  child: ListTile(
                    title: Text('$v   Job-${x + 1}'),
                    subtitle: Text(
                        '${DateTime.now().toLocal().toString().split(' ')[0]}   Detail   $v   Job-${x + 1}'),
                  ),
                )
            ],
          ),
        );
      }).toList(),
    );
  }
}

class Notifications extends StatelessWidget {
  final List<List<String>> _nRecord = [
    ['MAS Export job', 'Starts at 2:30 PM'],
    ['MAS Export job', 'Cargo Cut-Off at 5:30 PM'],
    ['MAS Export job', 'Starts at 8:30 PM'],
    ['MAS Export job', 'Cargo Cut-Off at 7:30 PM'],
    ['MAS Export job', 'Starts at 3:00 AM'],
    ['MAS Export job', 'Cargo Cut-Off at 1:00 AM '],
  ];
  final String _titlePre = 'Reminder  :- ';
  final int l = 5;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemBuilder: (_, i) {
            return ListTile(
              // contentPadding: EdgeInsets.only(top: 8),
              title: Text(
                '$_titlePre ${_nRecord[i][0]}',
                style: Theme.of(context).textTheme.subhead,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(left: 85),
                child: Row(
                  children: <Widget>[
                    Icon(IconData(58133, fontFamily: 'MaterialIcons')),
                    Text(
                      '${_nRecord[i][1]}',
                      style: Theme.of(context).textTheme.subtitle,
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (_, i) => Divider(
            color: Colors.grey,
            thickness: 3,
          ),
          itemCount: _nRecord.length,
        ));
  }
}

class Commissions extends StatelessWidget {
  final List<Map<String, double>> _commissionRecord = [
    {'MAS Import': 3000},
    {'MAS Export': 2000},
    {'MAERS Export': 6000},
    {'Brandix Import': 1000}
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 3,
            child: Center(child: Text('12000.00', style: Theme.of(context).textTheme.display1,))
        ),
        Flexible(
          flex: 5,
          child: TabBarView(
            children: commissionTab
                .map((v) => DataTable(

                columns: [
                  DataColumn(label: Text('Type')),
                  DataColumn(label: Text('Amount')),
                ],
                rows: _commissionRecord
                    .map(
                      (v) => DataRow(cells: [
                    DataCell(Text('${v.keys.toList()[0]}')),
                    DataCell(Text(
                        '${v.values.toList()[0].toStringAsFixed(2)}')),
                  ]),
                )
                    .toList()))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class AccountSettings extends StatefulWidget {
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

enum Languages { English, Sinhala }

class _AccountSettingsState extends State<AccountSettings> {
  final Map _userInfo = {
    'name': 'Soreth Poora',
    'phone': '0777 554 135',
    'pic': './assets/logo.png'
  };

  @override
  Widget build(BuildContext context) {
    Languages _selectedLanguage = Languages.English;

    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Theme.of(context).primaryColor,
                child: Text('HaulMatic'),
              ),
            ),
            flex: 3,
          ),
          Flexible(
            flex: 3,
            child: Column(
              children: <Widget>[
                Text(_userInfo['name'],
                    style: Theme.of(context).textTheme.headline),
                Text(_userInfo['phone'],
                    style: Theme.of(context).textTheme.subhead),
              ],
            ),
          ),
          Flexible(
            child: ListView(
                children: Languages.values.map((v) {
              return ListTile(
                title: Text('${v.toString().split('.')[1]}'),
                leading: Radio(
                    value: v,
                    groupValue: _selectedLanguage,
                    onChanged: (v) {
                      setState(() {
                        _selectedLanguage = v;
                      });
                    }),
              );
            }).toList()),
            flex: 3,
          ),
        ]);
  }
}
