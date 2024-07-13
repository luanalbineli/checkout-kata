import 'package:checkout/modules/core/domain/use_case/result.dart';
import 'package:flutter/foundation.dart';

abstract class AsyncUseCase<TParams, TResult> {
  const AsyncUseCase();

  @nonVirtual
  Future<Result<TResult>> call(TParams params) async {
    try {
      final data = await execute(params);
      return Result.success(data);
    } catch (exception) {
      return Result.error(exception);
    }
  }

  Future<TResult> execute(TParams params);
}

abstract class UseCase<TParams, TResult> {
  const UseCase();

  @nonVirtual
  Result<TResult> call(TParams params) {
    try {
      final data = execute(params);
      return Result.success(data);
    } catch (exception) {
      debugPrint('ERROR: $exception');
      return Result.error(exception);
    }
  }

  TResult execute(TParams params);
}
