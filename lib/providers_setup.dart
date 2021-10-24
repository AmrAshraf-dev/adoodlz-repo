import 'package:adoodlz/blocs/providers/auth_provider.dart';
import 'package:adoodlz/blocs/providers/change_ip_country_provider.dart';
import 'package:adoodlz/blocs/providers/gifts_provider.dart';
import 'package:adoodlz/blocs/providers/posts_provider.dart';
import 'package:adoodlz/data/remote/apis/auth_api.dart';
import 'package:adoodlz/data/remote/apis/gifts_api.dart';
import 'package:adoodlz/data/remote/apis/hits_api.dart';
import 'package:adoodlz/data/remote/apis/posts_api.dart';
import 'package:adoodlz/data/remote/dio_client.dart';
import 'package:adoodlz/feature/change_passwrod/data/repo/change_password_api.dart';
import 'package:adoodlz/feature/change_passwrod/providers/change_password_provider.dart';
import 'package:adoodlz/feature/tasks/data/repo/task_api.dart';
import 'package:adoodlz/feature/tasks/providers/task_provider.dart';
import 'package:adoodlz/helpers/ui/navigation_provider.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildWidget> independentServices = [
  Provider<Dio>(
    create: (ctx) => Dio(),
  )
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<Dio, DioClient>(
    update: (context, dio, client) => DioClient(dio),
  ),
  ProxyProvider<DioClient, PostsApi>(
    update: (context, dioclient, postsApi) => PostsApi(dioclient),
  ),
  ProxyProvider<DioClient, AuthApi>(
    update: (context, dioclient, authApi) => AuthApi(dioclient),
  ),
  ProxyProvider<DioClient, GiftsApi>(
    update: (context, dioclient, giftsApi) => GiftsApi(dioclient),
  ),
  ProxyProvider<DioClient, HitsApi>(
    update: (context, dioclient, hitsApi) => HitsApi(dioclient),
  ),

  /// //////////////
  ProxyProvider<DioClient, ChangePasswordApi>(
    update: (context, dioclient, changePasswordApi) =>
        ChangePasswordApi(dioclient),
  ),
  ProxyProvider<DioClient, TaskApi>(
    update: (context, dioclient, taskApi) => TaskApi(dioclient),
  ),
];

List<SingleChildWidget> uiConsumableProviders = [
  ChangeNotifierProvider<AppNavigationProvider>(
    create: (_) => AppNavigationProvider(),
  ),
  ChangeNotifierProxyProvider<PostsApi, PostsProvider>(
      create: (context) => PostsProvider(context.read<PostsApi>()),
      update: (_, postsApi, provider) => provider),
  ChangeNotifierProxyProvider<AuthApi, AuthProvider>(
      create: (context) => AuthProvider(context.read<AuthApi>()),
      update: (_, authApi, provider) => provider),
  ChangeNotifierProxyProvider<GiftsApi, GiftsProvider>(
      create: (context) => GiftsProvider(context.read<GiftsApi>()),
      update: (_, giftsApi, provider) => provider),

  /// ////////////////////////////////////////////////
  ChangeNotifierProxyProvider<ChangePasswordApi, ChangePasswordProvider>(
      create: (context) =>
          ChangePasswordProvider(context.read<ChangePasswordApi>()),
      update: (_, changePasswordApi, provider) => provider),

  ChangeNotifierProxyProvider<TaskApi, TaskProvider>(
      create: (context) => TaskProvider(context.read<TaskApi>()),
      update: (_, taskApi, provider) => provider),

  ChangeNotifierProvider<ChangeCountryIpProvider>(
    create: (context) => ChangeCountryIpProvider(),
  ),
];
