import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../graphql/request.dart';
import '../component/activities_list.dart';



class ListActivity extends StatefulWidget {
  const ListActivity({super.key});

  @override
  State<ListActivity> createState() => _ListActivity();
}
class _ListActivity extends State<ListActivity> with AutomaticKeepAliveClientMixin {
  int page = 1;
  final int perPage = 25;




@override
Widget build(BuildContext context) {
 return Query(
  options: QueryOptions(
   document: gql(requestApi),
   variables:  {
   'page': page,
   'perPage': perPage
   },
  pollInterval: const Duration(hours: 1)
  ), 
  builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
   if (result.hasException) {
    return Text(result.exception.toString());
    }
   if (result.isLoading) {
    return const Text('Loading');
    }

   List? array = result.data?['Page']?['activities'];
   
   FetchMoreOptions opts = FetchMoreOptions(
    variables: {
      'page': page,
      'perpage': 25
    },
    updateQuery: (previousResultData, fetchMoreResultData) {
      final List array = [
        ...previousResultData?['Page']?['activities'] as List,
        ...fetchMoreResultData?['Page']?['activities'] as List

      ];
        fetchMoreResultData?['Page']?['activities'] = array;
      return fetchMoreResultData;
    });

   if (array != null) {
    return ListView.builder(
        key: const PageStorageKey(0),
    itemCount: array.length + 1,
    itemBuilder: (context, index) {
    if (index < array.length) {
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
    } else {
      return Center(
        child: ElevatedButton(
          onPressed: () {
            page++;
            if (fetchMore != null)
            {fetchMore(opts);}
            
            },
          child: const Text('see more'),
        ),
      );
    }
}
);
}
return const Text('No data');

});
}
@override
bool get wantKeepAlive => true;

}