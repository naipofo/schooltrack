import 'package:ferry/ferry.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:flutter/material.dart';
import 'package:school_track/gql/conf.dart';

typedef GqlFetchBuilder<TData> = Widget Function(
  BuildContext context,
  TData data,
);

class GqlFetch<TData, TVars> extends StatelessWidget {
  const GqlFetch({
    super.key,
    required this.operationRequest,
    required this.builder,
  });

  final OperationRequest<TData, TVars> operationRequest;
  final GqlFetchBuilder<TData> builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initClient(),
      builder: (context, snapshot) => snapshot.hasData
          ? Operation(
              operationRequest: operationRequest,
              builder: (context, response, error) {
                if (response!.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (response.data != null) {
                  return this.builder(context, response.data as TData);
                } else {
                  return ErrorWidget(FlutterError('Data is null'));
                }
              },
              client: snapshot.data!,
            )
          : const Placeholder(),
    );
  }
}
