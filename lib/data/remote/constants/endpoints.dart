//const baseUrl = 'http://api.adoodlz.com';
//const baseUrl = 'http://api.adoodlz.com/v1';

const baseUrlSaudi = 'http://api.adoodlz.com/v1';
const baseUrlEgypt = 'https://adoodlz.herokuapp.com';
//const baseUrlEgypt = 'https://adoodlz-eg-dev.herokuapp.com';

String baseUrl = 'http://api.adoodlz.com/v1';

const int receiveTimeout = 5000;

const int connectionTimeout = 3000;

final String _otpEndpoint = '$baseUrl/otp';

final String generateOtp = '$_otpEndpoint/generate';

final String verifyOtp = '$_otpEndpoint/verify';

final String getUsers = '$baseUrl/users';

final String createAndUpdateUser = getUsers;

final String signIn = '$getUsers/login';

final String getUserData = getUsers;

final String useGift = '$getUsers/points/use';

final String getAffiliateUrl = '$getUsers/affiliate/get';

final String createPassword = '$getUsers/createPassword';

final String recordLog = '$baseUrl/logs';

final String recordHits = '$baseUrl/hits';

final String getPosts = '$baseUrl/posts';

final String getPostsFiltered = '$baseUrl/posts/get';

final String getGifts = '$baseUrl/gifts';

final String createPin = '$baseUrl/pins';

final String addPonts = '$baseUrl/corps/points/add';

final String getTasks = '$baseUrl/task';
const String getAppConfig = 'https://adoodlz.herokuapp.com/config';

final String taskSubmit = '$baseUrl/taskSubmit';
final String forgetPassword = '$_otpEndpoint/forget/password';

final String verifyResetPassword = '$_otpEndpoint/change/password';

const ipUrl = 'http://ip-api.com/json';
