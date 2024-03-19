import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/features/user_preferences/data/data_sources/user_preferences_remote_data_source.dart';

void main() {
  late UserPreferencesRemoteDataSourceImpl remotrDataSourceImpl;

  setUp(() => remotrDataSourceImpl = UserPreferencesRemoteDataSourceImpl());
}
