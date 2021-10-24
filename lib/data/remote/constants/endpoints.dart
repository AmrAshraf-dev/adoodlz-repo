//const baseUrl = 'http://api.adoodlz.com';
//const baseUrl = 'http://api.adoodlz.com/v1';

const baseUrlSaudi = 'http://api.adoodlz.com/v1';
const baseUrlEgypt = 'https://adoodlz.herokuapp.com';
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

final String taskSubmit = '$baseUrl/taskSubmit';

const ipUrl = 'http://ip-api.com/json';
