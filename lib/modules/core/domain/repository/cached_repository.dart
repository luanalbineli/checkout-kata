mixin CachedRepository {
  static final Map<String, CacheData> _cache = {};

  Future<TData> getFromCache<TData>(
    String key,
    Duration duration,
    Future<TData> Function() dataIfNotCached,
  ) async {
    if (_cache.containsKey(key)) {
      final cachedData = _cache[key]! as CacheData<TData>;
      if (cachedData.expiration.isAfter(DateTime.now())) {
        return cachedData.data;
      }
    }

    final data = await dataIfNotCached();
    final expiration = DateTime.now().add(duration);
    _cache[key] = CacheData<TData>(expiration, data);
    return data;
  }

  static const Duration durationDefault = Duration(minutes: 30);
}

class CacheData<TData> {
  final DateTime expiration;
  final TData data;

  CacheData(this.expiration, this.data);
}
