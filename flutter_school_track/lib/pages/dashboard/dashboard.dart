import 'package:flutter/material.dart';
import 'package:school_track/gql/fetch_helper.dart';
import 'package:school_track/gql/requests/__generated__/grades.req.gql.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: GqlFetch(
        operationRequest: GAllGradesReq(),
        builder: (context, data) => Column(
          children: [
            for (var g in data.grades!.nodes)
              Row(
                children: [
                  Text(g!.value.toString()),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
