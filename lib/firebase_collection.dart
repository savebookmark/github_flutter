import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

// final dummySnapshot = [
//   {"name": "Filip", "votes": 15},
//   {"name": "Abraham", "votes": 14},
//   {"name": "Richard", "votes": 11},
//   {"name": "Ike", "votes": 10},
//   {"name": "Justin", "votes": 1},
// ];
//
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Firebase', theme: ThemeData(primarySwatch: Colors.blue), home: MyHomePage(title: 'BABY NAME'));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('babyvote').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              print('$snapshot 하하하');
              if (snapshot.hasError) {
                Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading');
              }
              return ListView(
                  padding: const EdgeInsets.only(top: 20.0),
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot document) => _buildListItem(context, document))
                      .toList());
            }));
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    print('buildListItem $data');
    //하나의도큐멘트를 모델에 담고
    final record = Record.fromSnapshot(data);
    //리스트 로우에 들어갈 각각의 위젯 생성
    return Padding(
        key: ValueKey(record.name),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(5.0)),
            child: ListTile(
                subtitle: Text(record.reference.toString()),
                title: Text(record.name),
                trailing: Text(record.votes.toString()),
                onTap: () => FirebaseFirestore.instance.runTransaction((transaction) async {
                      final freshSnapshot = await transaction.get(record.reference);
                      final fresh = Record.fromSnapshot(freshSnapshot);
                      transaction.update(record.reference, {'votes': fresh.votes + 1});
                    }))));
  }
}

class Record {
  final String name;
  final int votes;
  final DocumentReference reference; //컬렉션의 도큐멘트 위치 -도큐멘트 아이디

// ':' 수퍼 클래스 생성자를 호출하는 것 외에도 생성자 본문이 실행되기 전에 인스턴스 변수를 초기화 할 수 있습니다.
//쉼표로 이니셜 라이저를 구분하십시오.
////reference 는 파이어스토어의 패스 즉 도큐멘트의 위치 어느도큐멘트인지
  Record.fromMap(Map<String, dynamic> map, {required this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];
  //한개의 도큐멘트를 받아서 각각 매핑
  // ':'클래스내 다른 생성자 호출
  Record.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data()!, reference: snapshot.reference);

  @override
  String toString() => 'Record<$name:$votes>';
}
