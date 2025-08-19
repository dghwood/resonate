import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/result.dart';

final Logger _log = Logger('components/common/infinite_scroll');

/* InfiniteScrollComponent 
  
  This is way too nested, but it works for now.

  TODO(duncan): Simplify this component.
*/

class InfiniteScrollComponent<T> extends StatefulWidget {
  const InfiniteScrollComponent({
    super.key,
    required this.next,
    required this.itemBuilder,
  });

  final Future<ApiResult<Iterable<T>>> Function(int currentPage) next;
  final Widget Function(BuildContext context, int index, List<T> results)
  itemBuilder;

  @override
  State<InfiniteScrollComponent<T>> createState() =>
      _InfiniteScrollComponentState<T>();
}

class _InfiniteScrollComponentState<T>
    extends State<InfiniteScrollComponent<T>> {
  late Future<ApiResult<Iterable<T>>> _initialFuture;

  @override
  void initState() {
    super.initState();
    _initialFuture = widget.next(0);
    _log.info('initState');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: 100,
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        var result = snapshot.data!;
        switch (result) {
          case ApiOk():
            return InfiniteScrollComponentInner<T>(
              itemBuilder: widget.itemBuilder,
              next: widget.next,
              results: result.value.toList(),
            );
          case ApiError():
            return Text('error');
        }
      },
    );
  }
}

class InfiniteScrollComponentInner<T> extends StatefulWidget {
  const InfiniteScrollComponentInner({
    super.key,
    required this.next,
    required this.itemBuilder,
    required this.results,
  });

  final List<T> results;
  final Future<ApiResult<Iterable<T>>> Function(int currentPage) next;
  final Widget Function(BuildContext context, int index, List<T> results)
  itemBuilder;

  @override
  State<InfiniteScrollComponentInner> createState() =>
      _InfiniteScrollComponentInnerState<T>();
}

enum InfinitScrollComponentState { loading, ready, finished }

class _InfiniteScrollComponentInnerState<T>
    extends State<InfiniteScrollComponentInner<T>> {
  _InfiniteScrollComponentInnerState();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _log.info('dispose');
    super.dispose();
  }

  void _scollListener() {
    _log.info('_scrollListener::$_state');
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        _state == InfinitScrollComponentState.ready) {
      setState(() => _state = InfinitScrollComponentState.loading);
      _fetchPage().then(
        (newItems) => setState(() {
          widget.results.addAll(newItems);
        }),
      );
    }
  }

  final _scrollController = ScrollController();
  InfinitScrollComponentState _state = InfinitScrollComponentState.ready;
  int _currentPage = 0;

  Future<List<T>> _fetchPage() async {
    _log.info('_fetchPage');

    _currentPage += 1;
    var result = await widget.next(_currentPage);

    switch (result) {
      case ApiOk():
        if (result.value.isEmpty) {
          // If we get empty results then we are done
          _state = InfinitScrollComponentState.finished;
          _log.info('finished');
          return [];
        }
        _state = InfinitScrollComponentState.ready;
        return result.value.toList();
      case ApiError():
        // Replace this?
        _log.info('error::${result.error}');
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    _log.info('results: ${widget.results.length}, $_state');
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: widget.results.length,
            itemBuilder: (context, index) {
              return widget.itemBuilder(context, index, widget.results);
            },
          ),
        ),
        if (_state == InfinitScrollComponentState.loading)
          SizedBox(
            height: 100,
            width: 100,
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
