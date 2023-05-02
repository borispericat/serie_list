import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:graphql_flutter/graphql_flutter.dart';

void main(List<String> arguments) async {
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink(
    'https://graphql.anilist.co'
    );

  final Link link = httpLink;

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore()))

  )

  runApp(const MainApp());
}



class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
