import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:convert';

void main() async {
  await initHiveForFlutter();

  runApp(const MainApp());
}

 final HttpLink httpLink = HttpLink(
    'https://graphql.anilist.co'
    );

  final Link link = httpLink;

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

String requestApi = """
 query (\$id: Int) { 
  Media (id: \$id, type: ANIME) { 
    id
    title {
      romaji
      english
      native
    }
  }
}
""";

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GraphQLProvider(
      client: client,
      child: MaterialApp(
      home: myHomePage()
    )
    ) ;
  }
}


class myHomePage extends StatefulWidget {
  const myHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
   
  
}

class _MyHomePageState extends State<myHomePage> {
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Query(
            options: QueryOptions(
              document: gql(requestApi),
              variables: {
                'id': 15125
              },
              pollInterval: const Duration(seconds: 10)
          ), 
            builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }
              if (result.isLoading) {
                return const Text('Loading');
              }

              if (result == null) {
                return const Text('No data');
              }

              var resultApi = json.encode(result.data);

              return Text(resultApi);
            }),
        ),
      );
  }

}
