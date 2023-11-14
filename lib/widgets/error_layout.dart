

import 'package:appgain/core/extensions/num_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../generated/locale_keys.g.dart';
import '../data_layer/datasource/remote/exception/error_widget.dart';

class ErrorLayout extends StatelessWidget {
  final ErrorModel? _errorModel;
  final VoidCallback? _onRetry;

  const ErrorLayout({Key? key, ErrorModel? errorModel, VoidCallback? onRetry})
      : _errorModel = errorModel,
        _onRetry = onRetry,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ErrorView(message: _errorModel?.errorMessage ?? 'Error', onRetry: _onRetry);
  }
}

class ErrorView extends StatelessWidget {
  final String? _message;
  final VoidCallback? _onRetry;

  ErrorView({Key? key, String? message, VoidCallback? onRetry})
      : _message = message,
        _onRetry = onRetry,
        super(key: key);

  final retryShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: const BorderSide(color: Colors.grey));

  @override
  Widget build(BuildContext context) {
    String message = _message ?? '';
    if (message.toLowerCase().contains("unauthorized")) message = "Login/Register to continue";
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          SizedBox(
            height: 20.h,
          ),
          if (_onRetry != null)
            TextButton(
              onPressed: _onRetry,
              style: TextButton.styleFrom(
                shape: retryShape,
              ),
              child: Text(
                tr(LocaleKeys.retry),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
        ],
      ),
    ));
  }
}