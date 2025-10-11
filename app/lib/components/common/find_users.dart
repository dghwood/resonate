import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/contacts.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/components/common/infinite_scroll.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/common/utils.dart';

final Logger _log = Logger('/components/common/find_users');

class FindUsersComponent extends StatelessWidget {
  const FindUsersComponent({super.key, required this.findUsersApi});

  final FindUsersApi findUsersApi;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        FutureBuilder(
          future: findUsersApi.requestAndFind(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SliverFillRemaining(child: LoadingSpinnerComponent());
            }
            var result = snapshot.requireData;
            switch (result) {
              case ApiOkIterable():
                break;
              case ApiErrorIterable():
                return SliverFillRemaining(
                  child: Text('Error: ${result.error}'),
                );
            }
            return SliverInfiniteScrollComponent(
              // Needed to put this here, since
              // the stream would cache this component
              key: Key(result.hashCode.toString()),
              iterableApiResult: result,
              scrollController: scrollController,
              itemBuilder: (context, user) {
                return ListTile(
                  leading: ImageComponent(user.imageUrl),
                  title: Text(user.name),
                  trailing: IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: () {
                      _log.info('follow');
                    },
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
