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
                'perPage': 25
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

                  return Container(
                    color: const Color.fromRGBO(241,250,250,1),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    height: 125,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                            flex: 2,
                            child: Container(
                              decoration:BoxDecoration(
                                image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage('${userName["media"]?["coverImage"]?["large"]}'),
                                
                                )
                              ) 
                              
                                ),
                          ),                       
                        Expanded(
                          flex: 6,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                            Container(
                              width: 100,
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    
                                    child: Text(
                                      userName["user"]?['name'] ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: false,
                                    ),
                                    ),
                                  Expanded(
                                    flex: 1,
                                    child: Image(
                                      image: NetworkImage('${userName["user"]?["avatar"]?["large"]}'),
                                      width: 40,
                                      height: 40,
                              )
                                                    ),
                                ],
                              ),
                            ),
                                                  userName["text"] != null? Text(userName["text"])
                                                  : Text(
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            softWrap: false,
                            '${userName["status"]} ${userName["progress"]} of ${userName["media"]?["title"]?["userPreferred"]}') 
                                                  
                                                  
                            ]
                                                  ),
                          )),
                  
                      ],
                    ),
                  );
                }
                );
              }
              return const Text('No data');
              
            });
}

}