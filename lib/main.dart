import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'graphql_request/activities.dart';

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
    return Scaffold(
        body: Center(
          child: Query(
            options: QueryOptions(
              document: gql(requestApi),
              variables: const {
                'perPage': 3
              },
              pollInterval: const Duration(minutes: 1)
          ), 
            builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }
              if (result.isLoading) {
                return const Text('Loading');
              }

              List? beta = result.data?['Page']?['activities'];
              if (beta != null) {
                return ListView.builder(
                itemCount: beta.length,
                itemBuilder: (Context, index) {
                  final userName = beta[index];

                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: 
                        Image(
                          image: NetworkImage('${userName["media"]?["coverImage"]?["large"]}'),
                          width: 75,
                          height: 120,
                          )
                          ),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                userName["user"]?['name'] ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                              ),
                            Expanded(
                              child: Image(
                                image: NetworkImage('${userName["user"]?["avatar"]?["large"]}'),
                                width: 40,
                                height: 40,
                        )
                      ),
                          ],
                        ),
                      userName["text"] != null? Text(userName["text"])
                      : Text(userName["status"]) 
                      
                      
                        ]
                      )),

                    ],
                  );
                }
                );
              }
              return const Text('No data');
              
            }),
        ),
      );
  }

}
