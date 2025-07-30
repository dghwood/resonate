import 'package:flutter/material.dart';
import 'package:resonate/components/tabs/pages/base.dart';

class PodcastPage extends PageComponent {
  const PodcastPage({super.key}) : super(title: 'Podcast');

  @override
  Widget buildChild(BuildContext context) {
    return Text('podcast');
  }
}
