library demo_package;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import 'App_loading_indicator.dart';
class AppScaffold extends StatefulWidget {
  final Widget body;
  final Widget? bottomNavigation;
  final AppBar? appbar;
  final bool? isLoading;
  final bool? isShowDrawer;
  final Color? bottomSafeAreaColor;
  final Color? backgroundColor;
  final Color? systemNavigationBarColor;
  final double? bottomShitPadding;
  final Function? onPop;
  final Widget? topOfBottomShit;
  final Function()? onTapBottomShit;
  final double? opacityValue;
  final Color? bgColor;
  final Color? loaderColor;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final List<KeyboardActionsItem>? keyboardActions;

  const AppScaffold({
    Key? key,
    required this.body,
    this.appbar,
    this.isLoading,
    this.isShowDrawer,
    this.floatingActionButtonLocation,
    this.bottomNavigation,
    this.bottomSafeAreaColor,
    this.systemNavigationBarColor,
    this.backgroundColor,
    this.onPop,
    this.bottomShitPadding,
    this.topOfBottomShit,
    this.onTapBottomShit,
    this.floatingActionButton,
    this.opacityValue,
    this.bgColor,
    this.loaderColor,
    this.keyboardActions,
  }) : super(key: key);

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.bottomSafeAreaColor ?? Colors.amber,
      child: SafeArea(
        top: false,
        bottom: true,
        child: AppLoadingIndicator(
          isLoading: widget.isLoading ?? false,
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light,
                systemNavigationBarColor:
                widget.systemNavigationBarColor ?? Colors.white),
            child: Scaffold(
              floatingActionButtonLocation:widget.floatingActionButtonLocation?? FloatingActionButtonLocation.centerDocked,
              floatingActionButton: widget.floatingActionButton,
              key: _scaffoldKey,
              appBar: widget.appbar?? AppBar(title: const Text("Demo Packages is inherited"),),
              // resizeToAvoidBottomInset: false,
              onDrawerChanged: (isChanged) {
                setState(() {});
              },
              primary: true,
              backgroundColor: widget.backgroundColor ?? Colors.transparent,
              drawer: widget.isShowDrawer ?? false
                  ? const Drawer()
                  : null,
              drawerScrimColor: Colors.white,
              bottomNavigationBar: widget.bottomNavigation,
              // primary: true,
              body: widget.keyboardActions != null
                  ? KeyboardActions(
                config: _buildConfig(),
                autoScroll: false,
                overscroll: 0,
                child: SafeArea(
                  top: false,
                  child: widget.body,
                ),
              )
                  : widget.body,
            ),
          ),
        ),
      ),
    );
  }

  KeyboardActionsConfig _buildConfig() {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: widget.keyboardActions,
    );
  }
}
