import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/components/common/loading.dart';

final Logger _log = Logger('components/common/infinite_scroll');

enum InfiniteScrollComponentState { ready, loading, error }

abstract class AbstractInfiniteScrollComponent<T> extends StatefulWidget {
  const AbstractInfiniteScrollComponent({
    super.key,
    required this.iterableApiResult,
    required this.scrollController,
    required this.itemBuilder,
  });

  final ScrollController scrollController;
  final ApiOkIterable<Iterable<T>> iterableApiResult;
  final Widget Function(BuildContext context, T item) itemBuilder;

  @override
  State<AbstractInfiniteScrollComponent<T>> createState() =>
      _AbstractInfiniteScrollComponentState<T>();
}

class _AbstractInfiniteScrollComponentState<T>
    extends State<AbstractInfiniteScrollComponent<T>> {
  Iterable<T> _items = [];
  Future<IterableApiResult<Iterable<T>>> Function()? _next;
  InfiniteScrollComponentState _state = InfiniteScrollComponentState.ready;

  @override
  void initState() {
    super.initState();
    _items = _items.followedBy(widget.iterableApiResult.result);
    _next = widget.iterableApiResult.next;
    widget.scrollController.addListener(_onScrollEvent);
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
    _log.info('load::${_next != null}::$_state');
    if (_next == null || _state == InfiniteScrollComponentState.loading) {
      return;
    }
    setState(() => _state = InfiniteScrollComponentState.loading);
    var apiResult = await _next!();
    switch (apiResult) {
      case ApiOkIterable():
        setState(() {
          _items = _items.followedBy(apiResult.result);
          _next = apiResult.next;
          _state = InfiniteScrollComponentState.ready;
        });
      case ApiErrorIterable():
        setState(() {
          // Next remains the same here...
          // So setState will refire the call
          _state = InfiniteScrollComponentState.error;
        });
        break;
    }
  }

  Widget _wrappedItemBuilder(BuildContext context, int index) {
    if (index == _items.length) {
      // Last item
      switch (_state) {
        case InfiniteScrollComponentState.loading:
          return LoadingSpinnerComponent();
        case InfiniteScrollComponentState.error:
          return IconButton(
            onPressed: () {
              setState(() {
                // This call will just refire the next function
              });
            },
            icon: Icon(Icons.error_outline),
          );
        case InfiniteScrollComponentState.ready:
          return SizedBox();
      }
    }
    return widget.itemBuilder(context, _items.elementAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: _items.length + 1,
      itemBuilder: _wrappedItemBuilder,
    );
    //
  }
}

class SliverInfiniteScrollComponent<T>
    extends AbstractInfiniteScrollComponent<T> {
  const SliverInfiniteScrollComponent({
    super.key,
    required super.iterableApiResult,
    required super.scrollController,
    required super.itemBuilder,
  });

  @override
  State<AbstractInfiniteScrollComponent<T>> createState() =>
      _SliverInfiniteScrollComponentState<T>();
}

class _SliverInfiniteScrollComponentState<T>
    extends _AbstractInfiniteScrollComponentState<T> {
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: _items.length + 1,
      itemBuilder: _wrappedItemBuilder,
    );
    //
  }
}

class InfiniteScrollComponent<T> extends AbstractInfiniteScrollComponent<T> {
  const InfiniteScrollComponent({
    super.key,
    required super.iterableApiResult,
    required super.scrollController,
    required super.itemBuilder,
  });

  @override
  State<AbstractInfiniteScrollComponent<T>> createState() =>
      _InfiniteScrollComponentState<T>();
}

class _InfiniteScrollComponentState<T>
    extends _AbstractInfiniteScrollComponentState<T> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _items.length + 1,
      itemBuilder: _wrappedItemBuilder,
    );
  }
}

class InfiniteScrollGridComponent<T>
    extends AbstractInfiniteScrollComponent<T> {
  const InfiniteScrollGridComponent({
    super.key,
    required super.iterableApiResult,
    required super.scrollController,
    required super.itemBuilder,
    required this.gridDelegate,
  });

  final SliverGridDelegate gridDelegate;

  @override
  State<AbstractInfiniteScrollComponent<T>> createState() =>
      _InfiniteScrollGridComponentState<T>();
}

class _InfiniteScrollGridComponentState<T>
    extends _AbstractInfiniteScrollComponentState<T> {
  _InfiniteScrollGridComponentState();

  @override
  Widget build(BuildContext context) {
    var w = widget as InfiniteScrollGridComponent<T>;
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      gridDelegate: w.gridDelegate,
      itemCount: _items.length + 1,
      itemBuilder: _wrappedItemBuilder,
    );
  }
}

// class SliverInfiniteScrollComponent<T> extends StatefulWidget {
//   const SliverInfiniteScrollComponent({
//     super.key,
//     required this.iterableApiResult,
//     required this.scrollController,
//     required this.itemBuilder,
//   });

//   final ScrollController scrollController;
//   final ApiOkIterable<Iterable<T>> iterableApiResult;
//   final Widget Function(BuildContext context, T item) itemBuilder;

//   @override
//   State<SliverInfiniteScrollComponent<T>> createState() =>
//       _SliverInfiniteScrollComponentState<T>();
// }

// class _SliverInfiniteScrollComponentState<T>
//     extends State<SliverInfiniteScrollComponent<T>> {
//   Iterable<T> _items = [];
//   Future<IterableApiResult<Iterable<T>>> Function()? _next;
//   InfiniteScrollComponentState _state = InfiniteScrollComponentState.ready;

//   @override
//   void initState() {
//     super.initState();
//     // Load up the items
//     _log.info('initState::${widget.iterableApiResult.result.length}');
//     _items = _items.followedBy(widget.iterableApiResult.result);
//     _next = widget.iterableApiResult.next;
//     widget.scrollController.addListener(_onScrollEvent);
//   }

//   @override
//   void dispose() {
//     widget.scrollController.removeListener(_onScrollEvent);
//     super.dispose();
//   }

//   void _onScrollEvent() {
//     if (widget.scrollController.position.atEdge &&
//         widget.scrollController.position.pixels !=
//             widget.scrollController.position.minScrollExtent) {
//       _load();
//     }
//   }

//   void _load() async {
//     _log.info('load::${_next != null}::$_state');
//     if (_next == null || _state == InfiniteScrollComponentState.loading) {
//       return;
//     }
//     setState(() => _state = InfiniteScrollComponentState.loading);
//     var apiResult = await _next!();
//     switch (apiResult) {
//       case ApiOkIterable():
//         setState(() {
//           _items = _items.followedBy(apiResult.result);
//           _next = apiResult.next;
//           _state = InfiniteScrollComponentState.ready;
//         });
//       case ApiErrorIterable():
//         setState(() {
//           // Next remains the same here...
//           // So setState will refire the call
//           _state = InfiniteScrollComponentState.error;
//         });
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     _log.info('build::${_items.length}::$_state');
//     return SliverList.builder(
//       itemCount: _items.length + 1,
//       itemBuilder: (context, index) {
//         if (index == _items.length) {
//           // Last item
//           switch (_state) {
//             case InfiniteScrollComponentState.loading:
//               return LoadingSpinnerComponent();
//             case InfiniteScrollComponentState.error:
//               return IconButton(
//                 onPressed: () {
//                   setState(() {
//                     // This call will just refire the next function
//                   });
//                 },
//                 icon: Icon(Icons.error_outline),
//               );
//             case InfiniteScrollComponentState.ready:
//               return SizedBox();
//           }
//         }
//         return widget.itemBuilder(context, _items.elementAt(index));
//       },
//     );
//     //
//   }
// }

// class InfiniteScrollComponent<T> extends StatefulWidget {
//   const InfiniteScrollComponent({
//     super.key,
//     required this.iterableApiResult,
//     required this.scrollController,
//     required this.itemBuilder,
//   });

//   final ScrollController scrollController;
//   final ApiOkIterable<Iterable<T>> iterableApiResult;
//   final Widget Function(BuildContext context, T item) itemBuilder;

//   @override
//   State<InfiniteScrollComponent<T>> createState() =>
//       _InfiniteScrollComponentState<T>();
// }

// class _InfiniteScrollComponentState<T>
//     extends State<InfiniteScrollComponent<T>> {
//   Iterable<T> _items = [];
//   Future<IterableApiResult<Iterable<T>>> Function()? _next;
//   InfiniteScrollComponentState _state = InfiniteScrollComponentState.ready;

//   @override
//   void initState() {
//     super.initState();
//     // Load up the items
//     _log.info('initState::${widget.iterableApiResult.result.length}');
//     _items = _items.followedBy(widget.iterableApiResult.result);
//     _next = widget.iterableApiResult.next;
//     widget.scrollController.addListener(_onScrollEvent);
//   }

//   @override
//   void dispose() {
//     widget.scrollController.removeListener(_onScrollEvent);
//     super.dispose();
//   }

//   void _onScrollEvent() {
//     if (widget.scrollController.position.atEdge &&
//         widget.scrollController.position.pixels !=
//             widget.scrollController.position.minScrollExtent) {
//       _load();
//     }
//   }

//   void _load() async {
//     _log.info('load::${_next != null}::$_state');
//     if (_next == null || _state == InfiniteScrollComponentState.loading) {
//       return;
//     }
//     setState(() => _state = InfiniteScrollComponentState.loading);
//     var apiResult = await _next!();
//     switch (apiResult) {
//       case ApiOkIterable():
//         setState(() {
//           _items = _items.followedBy(apiResult.result);
//           _next = apiResult.next;
//           _state = InfiniteScrollComponentState.ready;
//         });
//       case ApiErrorIterable():
//         setState(() {
//           // Next remains the same here...
//           // So setState will refire the call
//           _state = InfiniteScrollComponentState.error;
//         });
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     _log.info('build::${_items.length}::$_state');
//     return ListView.builder(
//       itemCount: _items.length + 1,
//       itemBuilder: (context, index) {
//         if (index == _items.length) {
//           // Last item
//           switch (_state) {
//             case InfiniteScrollComponentState.loading:
//               return LoadingSpinnerComponent();
//             case InfiniteScrollComponentState.error:
//               return IconButton(
//                 onPressed: () {
//                   setState(() {
//                     // This call will just refire the next function
//                   });
//                 },
//                 icon: Icon(Icons.error_outline),
//               );
//             case InfiniteScrollComponentState.ready:
//               return SizedBox();
//           }
//         }
//         return widget.itemBuilder(context, _items.elementAt(index));
//       },
//     );
//     //
//   }
// }

// class InfiniteScrollGridComponent<T> extends StatefulWidget {
//   const InfiniteScrollGridComponent({
//     super.key,
//     required this.iterableApiResult,
//     required this.scrollController,
//     required this.itemBuilder,
//     required this.gridDelegate,
//   });

//   final ScrollController scrollController;
//   final SliverGridDelegate gridDelegate;
//   final ApiOkIterable<Iterable<T>> iterableApiResult;
//   final Widget Function(BuildContext context, T item) itemBuilder;

//   @override
//   State<InfiniteScrollGridComponent<T>> createState() =>
//       _InfiniteScrollGridComponentState<T>();
// }

// class _InfiniteScrollGridComponentState<T>
//     extends State<InfiniteScrollGridComponent<T>> {
//   Iterable<T> _items = [];
//   Future<IterableApiResult<Iterable<T>>> Function()? _next;
//   InfiniteScrollComponentState _state = InfiniteScrollComponentState.ready;

//   @override
//   void initState() {
//     super.initState();
//     // Load up the items
//     _log.info('initState::${widget.iterableApiResult.result.length}');
//     _items = _items.followedBy(widget.iterableApiResult.result);
//     _next = widget.iterableApiResult.next;
//     widget.scrollController.addListener(_onScrollEvent);
//   }

//   @override
//   void dispose() {
//     widget.scrollController.removeListener(_onScrollEvent);
//     super.dispose();
//   }

//   void _onScrollEvent() {
//     if (widget.scrollController.position.atEdge &&
//         widget.scrollController.position.pixels !=
//             widget.scrollController.position.minScrollExtent) {
//       _load();
//     }
//   }

//   void _load() async {
//     _log.info('load::${_next != null}::$_state');
//     if (_next == null || _state == InfiniteScrollComponentState.loading) {
//       return;
//     }
//     setState(() => _state = InfiniteScrollComponentState.loading);
//     var apiResult = await _next!();
//     switch (apiResult) {
//       case ApiOkIterable():
//         setState(() {
//           _items = _items.followedBy(apiResult.result);
//           _next = apiResult.next;
//           _state = InfiniteScrollComponentState.ready;
//         });
//       case ApiErrorIterable():
//         setState(() {
//           // Next remains the same here...
//           // So setState will refire the call
//           _state = InfiniteScrollComponentState.error;
//         });
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     _log.info('build::${_items.length}::$_state');
//     return GridView.builder(
//       scrollDirection: Axis.horizontal,
//       gridDelegate: widget.gridDelegate,
//       itemCount: _items.length + 1,
//       itemBuilder: (context, index) {
//         if (index == _items.length) {
//           // Last item
//           switch (_state) {
//             case InfiniteScrollComponentState.loading:
//               return LoadingSpinnerComponent();
//             case InfiniteScrollComponentState.error:
//               return IconButton(
//                 onPressed: () {
//                   setState(() {
//                     // This call will just refire the next function
//                   });
//                 },
//                 icon: Icon(Icons.error_outline),
//               );
//             case InfiniteScrollComponentState.ready:
//               return SizedBox();
//           }
//         }
//         return widget.itemBuilder(context, _items.elementAt(index));
//       },
//     );
//     //
//   }
// }
