import 'package:checkout/logger/logger.dart';
import 'package:checkout/modules/core/domain/use_case/result.dart';
import 'package:flutter/foundation.dart';

abstract class AsyncUseCase<TParams, TResult> {
  const AsyncUseCase();

  @nonVirtual
  Future<Result<TResult>> call(TParams params) async {
    try {
      final data = await execute(params);
      return Result.success(data);
    } catch (exception, stacktrace) {
      Logger.error(exception, stacktrace);
      return Result.error(exception);
    }
  }

  @visibleForTesting
  Future<TResult> execute(TParams params);
}

abstract class UseCase<TParams, TResult> {
  const UseCase();

  @nonVirtual
  Result<TResult> call(TParams params) {
    try {
      final data = execute(params);
      return Result.success(data);
    } catch (exception, stacktrace) {
      Logger.error(exception, stacktrace);
      return Result.error(exception);
    }
  }

  @visibleForTesting
  TResult execute(TParams params);
}
