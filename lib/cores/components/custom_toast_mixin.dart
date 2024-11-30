import 'package:re_empties/cores/components/custom_toast.dart';
import 'package:oktoast/oktoast.dart';

mixin CustomToastMixin {
  showCustomToast(
    String message, {
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 4),
    bool isError = false,
  }) {
    showToastWidget(
      CustomToast(
        isError: isError,
        text: message,
      ),
      position: position,
      duration: duration,
      handleTouch: true,
    );
  }
}
