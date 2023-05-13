import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../graphql/request.dart';



class ListActivity extends StatefulWidget {
  const ListActivity({super.key});

  @override
  State<ListActivity> createState() => _ListActivity();
}

class _ListActivity extends State<ListActivity> {
  
@override
Widget build(BuildContext context) {
  return Query(
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
              
            });
}

}