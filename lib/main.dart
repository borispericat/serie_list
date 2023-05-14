import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:serie_list/utils/component/activity_block.dart';
import 'utils/graphql/provider.dart';

void main() async {
  await initHiveForFlutter();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GraphQLProvider(
      client: client,
      child: const MaterialApp(
      home: MyHomePage()
    )
    ) ;
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
   
  
}

class MyHomePageState extends State<MyHomePage> {

  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Container(
          color: const Color.fromRGBO(237,241,245,1),
          child: const ListActivity(),
        ),
      );
  }

}
