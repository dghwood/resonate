import 'package:flutter/material.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/components/common/loading.dart';

enum InfiniteScrollComponentState { ready, loading, error }

class SliverInfinitScrollComponent<T> extends StatefulWidget {
  const SliverInfinitScrollComponent({
    super.key,
    required this.iterableApiResult,
    required this.scrollController,
    required this.itemBuilder,
  });

  final ScrollController scrollController;
  final IterableApiResult<Iterable<T>> iterableApiResult;
  final Widget Function(BuildContext context, int index) itemBuilder;

  @override
  State<SliverInfinitScrollComponent<T>> createState() =>
      _SliverInfinitScrollComponentState<T>();
}

class _SliverInfinitScrollComponentState<T>
    extends State<SliverInfinitScrollComponent<T>> {
  Iterable<T> _items = [];
  Future<IterableApiResult<Iterable<T>>> Function()? _next;
  InfiniteScrollComponentState _state = InfiniteScrollComponentState.ready;

  @override
  void initState() {
    super.initState();
    var result = widget.iterableApiResult.result;
    switch (result) {
      case ApiOk():
        _items = _items.followedBy(result.value);
        _next = widget.iterableApiResult.next;
        widget.scrollController.addListener(_onScrollEvent);
      case ApiError():
        _state = InfiniteScrollComponentState.error;
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScrollEvent);
    super.dispose();
  }

  void _onScrollEvent() {
    if (widget.scrollController.position.atEdge &&
        widget.scrollController.position.pixels !=
            widget.scrollController.position.minScrollExtent) {
      _load();
    }
  }

  void _load() async {
    if (_next == null || _state == InfiniteScrollComponentState.loading) {
      return;
    }
    setState(() => _state = InfiniteScrollComponentState.loading);
    var apiResult = await _next!();
    var result = apiResult.result;
    switch (result) {
      case ApiOk():
        setState(() {
          _items = _items.followedBy(result.value);
          _state = InfiniteScrollComponentState.ready;
        });
      case ApiError():
        setState(() {
          _state = InfiniteScrollComponentState.error;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: _items.length + 1,
      itemBuilder: (context, index) {
        if (index == _items.length) {
          // Last item
          switch (_state) {
            case InfiniteScrollComponentState.loading:
              return LoadingSpinnerComponent();
            case InfiniteScrollComponentState.error:
              return IconButton(
                onPressed: () {
                  // Retry?
                },
                icon: Icon(Icons.error_outline),
              );
            case InfiniteScrollComponentState.ready:
              return SizedBox();
          }
        }
        return widget.itemBuilder(context, index);
      },
    );
    //
  }
}
