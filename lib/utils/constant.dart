class Endpoints {
  Endpoints._();
  static const int connectionTimeout = 15000;
  static const int receiveTimeout = 15000;
  static const String baseUrl = "https://asatvindia.in/cab/Api/";
  static String authApi = "${baseUrl}Api_auth/fetch_api_aut";
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
}
