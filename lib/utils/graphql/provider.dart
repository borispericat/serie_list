 import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';
 
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