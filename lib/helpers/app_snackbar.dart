import 'package:flutter/material.dart';
import 'package:resmpk/helpers/app_style.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void successSnackBar(BuildContext context, {required String message}) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.success(
      iconPositionTop: -2,
      textStyle: AppStyles.snackbar,
      borderRadius: const BorderRadius.all(Radius.circular(24)),
      boxShadow: const [
        BoxShadow(
          color: AppColors.transparent,
          offset: Offset(0, 8),
          spreadRadius: 1,
          blurRadius: 30,
        ),
      ],
      messagePadding: const EdgeInsets.only(left: 75, right: 20),
      backgroundColor: AppColors.green300,
      message: message,
    ),
  );
}

void infoSnackBar(BuildContext context, {required String message}) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.success(
      iconPositionTop: 3,
      textStyle: AppStyles.snackbar,
      borderRadius: const BorderRadius.all(Radius.circular(24)),
      boxShadow: const [
        BoxShadow(
          color: AppColors.transparent,
          offset: Offset(0, 8),
          spreadRadius: 1,
          blurRadius: 30,
        ),
      ],
      messagePadding: const EdgeInsets.only(left: 75, right: 20),
      backgroundColor: AppColors.yellow200,
      message: message,
    ),
  );
}

void errorSnackBar(BuildContext context, {required String message}) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.success(
      iconPositionTop: 3,
      textStyle: AppStyles.snackbar,
      borderRadius: const BorderRadius.all(Radius.circular(24)),
      boxShadow: const [
        BoxShadow(
          color: AppColors.transparent,
          offset: Offset(0, 8),
          spreadRadius: 1,
          blurRadius: 30,
        ),
      ],
      messagePadding: const EdgeInsets.only(left: 75, right: 20),
      backgroundColor: AppColors.red100,
      message: message,
    ),
  );
}
