/* Home View 


  * Contains Subscriptions & Feed APIs. 
  
*/

import 'package:resonate/api/auth.dart';
import 'package:resonate/api/feed.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/subscription.dart';

class HomeViewResult {}

class HomeViewApi {
  HomeViewApi({
    required this.authUser,
    required this.subscriptionsApi,
    required this.feedApi,
  });

  final SubscriptionsApi subscriptionsApi;
  final GetFeedApi feedApi;
  final AuthUser authUser;

  Future<ApiResult<bool>> load() async {
    var user = authUser.user;
    if (user == null) return ApiResult.error(Exception('Not signed in'));

    var feedResult = await feedApi.get();
    var subscriptionResult = await subscriptionsApi.listForUser(user.id);

    return ApiResult.ok(true);
  }
}
