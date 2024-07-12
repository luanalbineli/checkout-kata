import 'package:checkout/modules/core/domain/use_case/result.dart';
import 'package:flutter/foundation.dart';

abstract class AsyncUseCase<TParams, TResult> {
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
