import 'package:redux/redux.dart';
import 'package:ww_2/data/services/subscription_service.dart';
import 'package:ww_2/ui/state_manager/paywall/action.dart';
import 'package:ww_2/ui/state_manager/store.dart';

class PaywallMiddleware implements MiddlewareClass<AppState> {
  final SubscriptionService subscriptionService;

  PaywallMiddleware({required this.subscriptionService});

  @override
  call(store, action, next) {
    if (action is LoadPaywallListAction) {
      Future(() async {
        final answer = await subscriptionService.getPaywalls();
        if (answer.data != null) {
          store.dispatch(ShowPaywallListAction(paywalls: answer.data!));
        } else {
          store.dispatch(ErrorPaywallListAction(message: answer.error!));
        }
      });
    }
    next(action);
  }
}
