// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';

abstract class UseCaseHelper<T, Params> {
  const UseCaseHelper();
  Future<ApiResult<T>> call(Params params);
}
