import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/components/common/loading.dart';

final Logger _log = Logger('components/common/infinite_scroll');

enum InfiniteScrollComponentState { loading, ready, finished, error }

class InfiniteScrollComponent<T> extends StatefulWidget {
  const InfiniteScrollComponent({
    super.key,
    required this.next,
    required this.builder,
  });

  final Future<ApiResult<Iterable<T>>> Function(int currentPage) next;
  final Widget Function(BuildContext context, int index, List<T> results)
  builder;

  @override
  State<InfiniteScrollComponent<T>> createState() =>
      _InfiniteScrollComponentState<T>();
}

class InfiniteScrollState extends ChangeNotifier {
  InfiniteScrollComponentState _state = InfiniteScrollComponentState.ready;

  InfiniteScrollComponentState get state => _state;

  set state(InfiniteScrollComponentState newState) {
    if (_state != newState) {
      _state = newState;
      notifyListeners();
    }
  }
}

class _InfiniteScrollComponentState<T>
    extends State<InfiniteScrollComponent<T>> {
  final List<T> _results = [];
  final _scrollController = ScrollController();
  final InfiniteScrollState _state = InfiniteScrollState();

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetch();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    _log.info('_scrollListener::$_state');
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        _state.state == InfiniteScrollComponentState.ready) {
      _log.info('Fetching next page');
      _fetch();
    }
  }

  // This needs to return an error if it fails
  Future<void> _fetch() async {
    _log.info('_fetch');
    _state.state = InfiniteScrollComponentState.loading;
    var result = await widget.next(_currentPage + 1);

    switch (result) {
      case ApiOk():
        var value = result.value;
        _log.info('results: ${value.length}');
        if (value.isEmpty) {
          // If we get empty results then we are done
          _currentPage += 1;
          _state.state = InfiniteScrollComponentState.finished;
          _log.info('finished');
          return;
        }
        _results.addAll(result.value);
        _state.state = InfiniteScrollComponentState.ready;
        return;
      case ApiError():
        // Replace this?
        _log.info('error::${result.error}');
        _state.state = InfiniteScrollComponentState.error;
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _state,
      builder: (context, child) {
        _log.info('build');
        if (_results.isEmpty &&
            _state.state == InfiniteScrollComponentState.loading) {
          return LoadingSpinnerComponent();
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _results.length,
                itemBuilder: (context, index) {
                  return widget.builder(context, index, _results);
                },
              ),
            ),
            if (_state.state == InfiniteScrollComponentState.loading)
              LoadingSpinnerComponent(),
            if (_state.state == InfiniteScrollComponentState.error)
              TextButton(
                // TODO(duncan): Pass the error message
                child: Text('error'),
                onPressed: () {
                  _fetch();
                },
              ),
          ],
        );
      },
    );
  }
}
