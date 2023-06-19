import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

const double _kDefaultDiameterRatio = 1.07;
const double _kDefaultPerspective = 0.003;
const double _kSqueeze = 1.45;
const double _kOverAndUnderCenterOpacity = 0.447;

class Custom24Picker extends StatefulWidget {
  Custom24Picker({
    super.key,
    this.diameterRatio = _kDefaultDiameterRatio,
    this.backgroundColor,
    this.offAxisFraction = 0.0,
    this.useMagnifier = false,
    this.magnification = 1.0,
    this.scrollControllers,
    this.squeeze = _kSqueeze,
    required this.itemExtent,
    required this.onSelectedItemChanged,
    required this.children,
    this.selectionOverlay = const CupertinoPickerDefaultSelectionOverlay(),
    bool looping = false,
    required this.childDelegate,
  }) {
    for (var i = 0; i < (scrollControllers?.length ?? 0); i++) {
      childDelegate[i] = looping
          ? ListWheelChildLoopingListDelegate(children: children[i])
          : ListWheelChildListDelegate(children: children[i]);
    }
  }

  Custom24Picker.builder({
    super.key,
    this.diameterRatio = _kDefaultDiameterRatio,
    this.backgroundColor,
    this.offAxisFraction = 0.0,
    this.useMagnifier = false,
    this.magnification = 1.0,
    this.scrollControllers,
    this.squeeze = _kSqueeze,
    int? childCount,
    required this.itemExtent,
    required this.children,
    required this.onSelectedItemChanged,
    required NullableIndexedWidgetBuilder itemBuilder,
    this.selectionOverlay = const CupertinoPickerDefaultSelectionOverlay(),
  }) : childDelegate = [
          ListWheelChildBuilderDelegate(
            builder: itemBuilder,
            childCount: childCount,
          ),
        ];
  final double diameterRatio;
  final Color? backgroundColor;
  final double offAxisFraction;
  final bool useMagnifier;
  final double magnification;
  final double itemExtent;
  final double squeeze;
  final Widget? selectionOverlay;
  final List<List<Widget>> children;
  final ValueChanged<List<int>>? onSelectedItemChanged;
  final List<FixedExtentScrollController>? scrollControllers;
  final List<ListWheelChildDelegate> childDelegate;

  @override
  State<StatefulWidget> createState() => _CupertinoPickerState();
}

class _CupertinoPickerState extends State<Custom24Picker> {
  int? _lastHapticIndex;

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < (widget.scrollControllers?.length ?? 0); i++) {
      if (widget.scrollControllers?[i] == null) {
        widget.scrollControllers?[i] = FixedExtentScrollController();
      }
    }
  }

  void _handleSelectedItemChanged(int value, int index) {
    // Only the haptic engine hardware on iOS devices would produce the
    // intended effects.
    final bool hasSuitableHapticHardware;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        hasSuitableHapticHardware = true;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        hasSuitableHapticHardware = false;
        break;
    }
    if (hasSuitableHapticHardware && value != _lastHapticIndex) {
      _lastHapticIndex = value;
      HapticFeedback.selectionClick();
    }
    widget.onSelectedItemChanged?.call([value, index]);
  }

  /// Draws the selectionOverlay.
  Widget _buildSelectionOverlay(Widget selectionOverlay) {
    final height = widget.itemExtent * widget.magnification;

    return IgnorePointer(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(
            width: MediaQuery.of(context).size.width,
            height: height,
          ),
          child: selectionOverlay,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = CupertinoTheme.of(context).textTheme.pickerTextStyle;
    final resolvedBackgroundColor =
        CupertinoDynamicColor.maybeResolve(widget.backgroundColor, context);

    assert(RenderListWheelViewport.defaultPerspective == _kDefaultPerspective);
    final Widget result = DefaultTextStyle(
      style: textStyle.copyWith(
        color: CupertinoDynamicColor.maybeResolve(textStyle.color, context),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: CupertinoPickerSemantics(
                scrollController: widget.scrollControllers?.first ??
                    FixedExtentScrollController(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (var i = 0;
                        i < (widget.scrollControllers?.length ?? 0);
                        i++) ...[
                      Expanded(
                        child: ListWheelScrollView.useDelegate(
                          controller: widget.scrollControllers?[i],
                          physics: const FixedExtentScrollPhysics(),
                          diameterRatio: widget.diameterRatio,
                          offAxisFraction: widget.offAxisFraction,
                          useMagnifier: widget.useMagnifier,
                          magnification: widget.magnification,
                          overAndUnderCenterOpacity:
                              _kOverAndUnderCenterOpacity,
                          itemExtent: widget.itemExtent,
                          squeeze: widget.squeeze,
                          onSelectedItemChanged: (value) {
                            _handleSelectedItemChanged(value, i);
                          },
                          childDelegate: widget.childDelegate[i],
                        ),
                      ),
                    ],
                  ],
                )),
          ),
          if (widget.selectionOverlay != null)
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: _buildSelectionOverlay(widget.selectionOverlay!),
            )
        ],
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(color: resolvedBackgroundColor),
      child: result,
    );
  }
}

class CupertinoPickerDefaultSelectionOverlay extends StatelessWidget {
  const CupertinoPickerDefaultSelectionOverlay({
    super.key,
    this.background = CupertinoColors.tertiarySystemFill,
    this.capStartEdge = true,
    this.capEndEdge = true,
  });
  final bool capStartEdge;
  final bool capEndEdge;
  final Color background;
  static const double _defaultSelectionOverlayHorizontalMargin = 9;
  static const double _defaultSelectionOverlayRadius = 8;

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(_defaultSelectionOverlayRadius);

    return Container(
      margin: EdgeInsetsDirectional.only(
        start: capStartEdge ? _defaultSelectionOverlayHorizontalMargin : 0,
        end: capEndEdge ? _defaultSelectionOverlayHorizontalMargin : 0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.horizontal(
          start: capStartEdge ? radius : Radius.zero,
          end: capEndEdge ? radius : Radius.zero,
        ),
        color: CupertinoDynamicColor.resolve(background, context),
      ),
    );
  }
}

class CupertinoPickerSemantics extends SingleChildRenderObjectWidget {
  const CupertinoPickerSemantics({
    super.key,
    super.child,
    required this.scrollController,
  });

  final FixedExtentScrollController scrollController;

  @override
  RenderObject createRenderObject(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    return RenderCupertinoPickerSemantics(
      scrollController,
      Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderCupertinoPickerSemantics renderObject,
  ) {
    assert(debugCheckHasDirectionality(context));
    renderObject
      ..textDirection = Directionality.of(context)
      ..controller = scrollController;
  }
}

class RenderCupertinoPickerSemantics extends RenderProxyBox {
  RenderCupertinoPickerSemantics(
    FixedExtentScrollController controller,
    this._textDirection,
  ) {
    _updateController(null, controller);
  }

  FixedExtentScrollController get controller => _controller;
  late FixedExtentScrollController _controller;
  set controller(FixedExtentScrollController value) =>
      _updateController(_controller, value);

  void _updateController(
    FixedExtentScrollController? oldValue,
    FixedExtentScrollController value,
  ) {
    if (value == oldValue) {
      return;
    }
    if (oldValue != null) {
      oldValue.removeListener(_handleScrollUpdate);
    } else {
      _currentIndex = value.initialItem;
    }
    value.addListener(_handleScrollUpdate);
    _controller = value;
  }

  TextDirection get textDirection => _textDirection;
  TextDirection _textDirection;
  set textDirection(TextDirection value) {
    if (textDirection == value) {
      return;
    }
    _textDirection = value;
    markNeedsSemanticsUpdate();
  }

  int _currentIndex = 0;

  void _handleIncrease() {
    controller.jumpToItem(_currentIndex + 1);
  }

  void _handleDecrease() {
    controller.jumpToItem(_currentIndex - 1);
  }

  void _handleScrollUpdate() {
    if (controller.selectedItem == _currentIndex) {
      return;
    }
    _currentIndex = controller.selectedItem;
    markNeedsSemanticsUpdate();
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config
      ..isSemanticBoundary = true
      ..textDirection = textDirection;
  }

  @override
  void assembleSemanticsNode(
    SemanticsNode node,
    SemanticsConfiguration config,
    Iterable<SemanticsNode> children,
  ) {
    if (children.isEmpty) {
      return super.assembleSemanticsNode(node, config, children);
    }
    final scrollable = children.first;
    final indexedChildren = <int, SemanticsNode>{};
    scrollable.visitChildren((SemanticsNode child) {
      assert(child.indexInParent != null);
      indexedChildren[child.indexInParent!] = child;
      return true;
    });
    if (indexedChildren[_currentIndex] == null) {
      return node.updateWith(config: config);
    }
    config.value = indexedChildren[_currentIndex]!.label;
    final previousChild = indexedChildren[_currentIndex - 1];
    final nextChild = indexedChildren[_currentIndex + 1];
    if (nextChild != null) {
      config
        ..increasedValue = nextChild.label
        ..onIncrease = _handleIncrease;
    }
    if (previousChild != null) {
      config
        ..decreasedValue = previousChild.label
        ..onDecrease = _handleDecrease;
    }
    node.updateWith(config: config);
  }
}
