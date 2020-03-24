  Future<List<UserTask>> getUserTaskList() async {

    QuerySnapshot qShot = 
      await Firestore.instance.collection('userTasks').getDocuments();

    return qShot.documents.map(
      (doc) => UserTask(
            doc.data['id'],
            doc.data['Description'],
            etc...)
    ).toList();
  }

  main() async {
    List<UserTask> tasks = await getUserTaskList();
    useTasklist(tasks); // yay, the list is here
  }
  
  // *********************************************************
  
  Stream<List<UserTask>> getUserTaskLists() async {

    Stream<QuerySnapshot> stream = 
      Firestore.instance.collection('userTasks').snapshots();

    return stream.map(
      (qShot) => qShot.documents.map(
        (doc) => UserTask(
            doc.data['id'],
            doc.data['Description'],
            etc...)
      ).toList()
    );
  }

  main() async {
    await for (List<UserTask> tasks in getUserTaskLists()) {
      useTasklist(tasks); // yay, the NEXT list is here
    }
  }
  
  // ***********************************************************
  
    void f1() {
    var snapShots = _colt.snapshots();

    snapShots.listen((v)=>
     v.documents.forEach((vvv)=> print('${vvv.documentID}  ${vvv.data["email"]} ${vvv.data["name"]}'))
    );
  }
  
  //*****************************************************************
  
  void f() async{
    //var docs =await _colt.where('email', isEqualTo : 'abc123@gmail.com').getDocuments();
    var docs =await _colt.getDocuments();
    var l =  docs.documents.map((v)=>int.parse(v.documentID.split('_')[1])).cast<int>().toList();
    //var ll = l.cast<int>().toList();
    l.sort();
    print(l.last+1);
    //print(ll.reduce((curr, next) => curr > next? curr: next));
    //print([1,2,3].reduce(min));
//    if(docs.documents.isEmpty)
//        Firestore.instance.collection('f_store').document('user_5').setData({'email':'ppp@yahoo.com', 'name': 'ppp'});
//    docs.documents.forEach((v){
//      print('${v.documentID} -- ${v['name']} --- ${v['email']}');
//
//    });
  }
  
  
