class Endpoints {
  Endpoints._();
  static const int connectionTimeout = 50000;
  static const int receiveTimeout = 50000;
  static const String baseUrl = "https://asatvindia.in/cab/Api";
  static const String newBaseUrl = "https://asatvindia.in/cab/api/user";
  static const String authApi = "$baseUrl/Api_auth/fetch_api_auth";
  static const String places = "https://places.googleapis.com/v1/places:autocomplete";
  static String nearbyVehicles = "$baseUrl/User/getvehicle_on_location";
  static String dashboard = "$baseUrl/User/dashboard";

  /// Authentication
  static String registerUser = "https://www.bits.teamtest.co.in/Api/Login/GetUserDataForService";
  static String sendOtp = "$newBaseUrl/send-otp";
  static String verifyOtp = "$newBaseUrl/verify-otp";

  /// Profile
  static String getBookingType = "$newBaseUrl/get-booking-type";
  static String getProfile = "$newBaseUrl/my-profile";
  static String updateProfile = "$newBaseUrl/update-profile";
  static String getSavedAddress = "$newBaseUrl/list-address";
  static String addAddress = "$newBaseUrl/submit-address";
  static String deleteAddress = "$newBaseUrl/delete-address";
  static String getWalletHistory = "$newBaseUrl/wallet-history";
  static String getPaymentGateways = "$newBaseUrl/get-payment-gateways";
  static const String getVehicles = "$newBaseUrl/get-vehicle";
  static const String bookNow = "$newBaseUrl/book-cab";
  static const String addMoneyToWallet = "$newBaseUrl/add-wallet-balance";
  static const String verifyWalletPayment = "$newBaseUrl/verify-wallet-payment";
}

class AppImage {
  static const String assetPng = "assets/images/";
  static const String assetSvg = "assets/images/svg/";

  ///jpg
  static const String driver = '${assetPng}driver1.jpg';

  /// PNG
  static const String appLogo = '${assetPng}app_logo.png';
  static const String bookNow = '${assetPng}book_now.png';
  static const String bookNowIcon = '${assetPng}book_now_icon.png';
  static const String preBooking = '${assetPng}pre_booking.png';
  static const String preBookingIcon = '${assetPng}pre_booking_icon.png';
  static const String rental = '${assetPng}rental.png';
  static const String rentalIcon = '${assetPng}rental_icon.png';
  static const String offer = '${assetPng}offer.png';
  static const String office = '${assetPng}office.png';
  static const String home = '${assetPng}home.png';
  static const String rent = '${assetPng}rent.png';
  static const String miniCar = '${assetPng}mini_car.png';
  static const String microCar = '${assetPng}micro_car.png';
  static const String primeCar = '${assetPng}prime_car.png';
  static const String auto = '${assetPng}auto.png';
  static const String bicycle = '${assetPng}bicycle.png';
  static const String upi = '${assetPng}upi.png';
  static const String a24 = '${assetPng}a24.png';
  static const String razorPay = '${assetPng}razor_pay.png';
  static const String phonePay = '${assetPng}phone_pay.png';
  static const String visa = '${assetPng}visa.png';
  static const String ruPay = '${assetPng}rupay.png';
  static const String mastercard = '${assetPng}mastercard.png';
  static const String paypal = '${assetPng}paypal.png';
  static const String carMap = '${assetPng}car_map.png';
  static const String autoMap = '${assetPng}auto_map.png';
  static const String bikeMap = '${assetPng}bike_map.png';
  static const String source = '${assetPng}source_location.png';
  static const String destination = '${assetPng}destination_location.png';

  ///SVG
  static const String search = '${assetSvg}search.svg';
  static const String menu = '${assetSvg}menu.svg';
  static const String back = '${assetSvg}back.svg';
  static const String pluse = '${assetSvg}pluse.svg';
  static const String dot = '${assetSvg}dot.svg';
  static const String location = '${assetSvg}location.svg';
  static const String dottedLine = '${assetSvg}dotted_line.svg';
  static const String calender = '${assetSvg}calender.svg';
  static const String loc = '${assetSvg}loc.svg';
  static const String wallet = '${assetSvg}wallet.svg';
  static const String close = '${assetSvg}close.svg';
  static const String star = '${assetSvg}star.svg';
  static const String notification = '${assetSvg}notification.svg';
  static const String homeSvg = '${assetSvg}home.svg';
  static const String selectedHome = '${assetSvg}selected_home.svg';
  static const String profile = '${assetSvg}profile.svg';
  static const String cards = '${assetSvg}cards.svg';
  static const String netBanking = '${assetSvg}net_banking.svg';
  static const String selectedWallet = '${assetSvg}selected_wallet.svg';
  static const String selectedNotification = '${assetSvg}selected_notification.svg';
  static const String selectedProfile = '${assetSvg}selected_profile.svg';
  static const String box = '${assetSvg}box.svg';
  static const String remove = '${assetSvg}remove.svg';
  static const String editSvg = '${assetSvg}edit.svg';
  static const String call = '${assetSvg}call.svg';
  static const String email = '${assetSvg}email.svg';
  static const String officeSvg = '${assetSvg}office.svg';
  static const String setting = '${assetSvg}setting.svg';
  static const String logout = '${assetSvg}logout.svg';
  static const String delete = '${assetSvg}delete.svg';
  static const String sort = '${assetSvg}sort.svg';
  static const String filter = '${assetSvg}filter.svg';
  static const String sourceSvg = '${assetSvg}source.svg';
  static const String destinationSvg = '${assetSvg}destination.svg';
}
