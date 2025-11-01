import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/components/common/models/subscribe.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/router/navigation.dart';

class PodcastTile extends StatelessWidget {
  const PodcastTile({super.key, required this.podcast});

  final Podcast podcast;

  static Widget loading() {
    return SkeletonLoadingComponent(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(width: 100, height: 100, color: Colors.red),
          ),
          title: Text(
            'This is a long title, but a really long title',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () => Navigate(context).toPodcast(podcast.id),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ImageComponent(podcast.imageUrl),
        ),
        title: Text(
          podcast.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        // trailing: SubscribeButtonComponent(
        //   podcast: podcast,
        //   subscriptionApi: context.read<AuthUser>().subscriptionApi,
        //   icon: true,
        // ),
      ),
    );
  }
}
