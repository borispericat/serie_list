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
query (\$perPage: Int) { 
  Page (perPage: \$perPage) {
     activities(isFollowing: true, sort: ID_DESC) {
      ... on TextActivity {
        id
        userId
        type
        replyCount
        text
        createdAt
        user {
          id
          name
          avatar {
            large
          }
        }
        likes {
          id
          name
          avatar {
            large
          }
        }
        replies {
          id
          text
          createdAt
          user {
            id
            name
            avatar {
              large
            }
          }
          likes {
            id
            name
            avatar {
              large
            }
          }
        }
      }
      ... on ListActivity {
        id
        userId
        type
        status
        progress
        replyCount
        createdAt
        user {
          id
          name
          avatar {
            large
          }
        }
        media {
          id
          title {
            userPreferred
          }
        }
        likes {
          id
          name
          avatar {
            large
          }
        }
        replies {
          id
          text
          createdAt
          user {
            id
            name
            avatar {
              large
            }
          }
          likes {
            id
            name
            avatar {
              large
            }
          }
        }
      }
      ... on MessageActivity {
        id
        type
        replyCount
        createdAt
        messenger {
          id
          name
          avatar {
            large
          }
        }
        likes {
          id
          name
          avatar {
            large
          }
        }
        replies {
          id
          text
          createdAt
          user {
            id
            name
            avatar {
              large
            }
          }
          likes {
            id
            name
            avatar {
              large
            }
          }
        }
      }
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
    return Scaffold(
        body: Center(
          child: Query(
            options: QueryOptions(
              document: gql(requestApi),
              variables: const {
                'perPage': 50
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
