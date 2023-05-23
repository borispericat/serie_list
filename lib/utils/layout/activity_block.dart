import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../graphql/request.dart';
import '../component/activities_list.dart';



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

   List? array = result.data?['Page']?['activities'];
   if (array != null) {
    return ListView.builder(
    itemCount: array.length,
    itemBuilder: (Context, index) {
     final resultRequest = array[index];
      if (resultRequest["text"] != null) {
        return Text(resultRequest["text"]);
      }
     return Activity(
      media: resultRequest["media"]?["coverImage"]?["large"],
      avatar: resultRequest["user"]?["avatar"]?["large"],
      userName: resultRequest["user"]?['name'],
      time: resultRequest["createdAt"],
      status: '${resultRequest["status"]} ${resultRequest["progress"]} of ${resultRequest["media"]?["title"]?["userPreferred"]}',);
}
);
}
return const Text('No data');

});
}

}