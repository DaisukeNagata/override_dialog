import 'override_dialog_platform_interface.dart';
import 'package:flutter/cupertino.dart';

class OverrideDialog {
  late OverlayEntry _overlayEntry;
  late AnimationController _animationController;
  bool isOpen = true;

  Future<String?> getPlatformVersion() {
    return OverrideDialogPlatform.instance.getPlatformVersion();
  }

  Future<void> show(
    BuildContext context,
    Offset offset,
    Widget child,
    int speed,
  ) async {
    if (!isOpen) {
      hide(context);
      return;
    }
    final overlayState = Overlay.of(context);
    _animationController = AnimationController(
      vsync: overlayState,
      duration: Duration(milliseconds: speed),
    );
    _overlayEntry = OverlayEntry(builder: (context) {
      return AbsorbPointer(
        absorbing: false,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            OverRayWidget(
              animationController: _animationController,
              offset: offset,
              child: child,
            ),
          ],
        ),
      );
    });

    overlayState.insert(_overlayEntry);

    await _animationController.forward();
    isOpen = false;
  }

  Future<void> hide(BuildContext context) async {
    if (!isOpen) {
      await _animationController.reverse();
      _overlayEntry.remove();
      isOpen = true;
    }
  }

  Future<void> reset(BuildContext context) async {
    final overlayState = Overlay.of(context);
    _animationController = AnimationController(
      vsync: overlayState,
      duration: const Duration(milliseconds: 10),
    );
    _overlayEntry.remove();
    isOpen = true;
  }

  Future<void> upDate(BuildContext context, Widget child, Offset offset) async {
    final overlayState = Overlay.of(context);
    _overlayEntry.remove();
    _overlayEntry = OverlayEntry(builder: (context) {
      return AbsorbPointer(
        absorbing: false,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            OverRayWidget(
              animationController: _animationController,
              offset: offset,
              child: child,
            ),
          ],
        ),
      );
    });
    overlayState.insert(_overlayEntry);
    isOpen = false;
  }
}

class OverRayWidget extends StatelessWidget {
  final AnimationController animationController;
  final Offset offset;
  final Widget child;

  const OverRayWidget({
    Key? key,
    required this.animationController,
    required this.offset,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: offset,
        end: Offset.zero,
      ).animate(animationController),
      child: child,
    );
  }
}
