import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:re_empties/cores/components/loading_indicator.dart';
import 'package:re_empties/cores/template/notifer.dart';

class BaseView<T extends BaseNotifier> extends ConsumerWidget {
  final AutoDisposeChangeNotifierProvider<T> provider;
  final Widget Function(BuildContext, T) builder;
  final Widget Function(BuildContext, T)? overlayBuilder;
  final PreferredSizeWidget Function(T) appBar;
  final bool extendBodyBehindAppBar;
  final bool disableSafeArea;
  final Widget? floatingActionButton;

  const BaseView({
    super.key,
    required this.provider,
    required this.appBar,
    required this.builder,
    this.overlayBuilder,
    this.extendBodyBehindAppBar = false,
    this.disableSafeArea = false,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewModel = ref.watch(provider);
    return _buildScreenContent(context, viewModel);
  }

  Widget _buildScreenContent(BuildContext context, T viewModel) => Container(
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              SafeArea(
                top: !disableSafeArea,
                right: !disableSafeArea,
                bottom: !disableSafeArea,
                left: !disableSafeArea,
                child: Scaffold(
                  appBar: appBar(viewModel),
                  extendBodyBehindAppBar: extendBodyBehindAppBar,
                  body: builder(context, viewModel),
                  floatingActionButton: floatingActionButton,
                ),
              ),
              if (viewModel.isLoading)
                const LoadingIndicator(showBackdrop: true),
            ],
          ),
        ),
      );
}
