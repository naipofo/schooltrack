import 'package:ferry/ferry.dart';
import 'package:gql_http_link/gql_http_link.dart';

/// Student with user_id = 2
const testJwt =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJwb3N0Z3JhcGhpbGUiLCJyb2xlIjoic3R1ZGVudCIsInVzZXJfaWQiOjJ9.U6xmIgzAl_tYOeEwaAckJbBRNTmvYHU_69e910f4LR8';

Future<Client> initClient() async {
  final link = HttpLink('http://[::]:42239/graphql',
      defaultHeaders: {'Authorization': 'Bearer $testJwt'});

  final client = Client(
    link: link,
  );

  return client;
}
