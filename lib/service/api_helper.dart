class ApiHelper {
  ApiHelper._();

  static const String baseUrl = "https://asatvindia.in/cab/Api/";
  static String authApi = "${baseUrl}Api_auth/fetch_api_auth";
  static String getVehicle = baseUrl + 'User/getvehicle';
  static String getTheme = baseUrl + 'User/get_theme';
  static String sendRequestDriver = baseUrl + 'User/sendReqForfindDriver';
  static String findDriver = baseUrl + 'User/findDriver';
  static String bookCab = baseUrl + 'User/Bookcab';
  static String cancelBookCab = baseUrl + 'User/CancleBookedCab';
  static String payNow = baseUrl + 'User/paynow';
  static String paymentVerify = baseUrl + 'User/payment_verify';
  static String afterPayNowOnline = baseUrl + 'User/afterpaynow_online';
  static String afterPayNowWallet = baseUrl + 'User/afterpaynow_wallet';
  static String afterOnlinePaymentVerify = baseUrl + 'User/after_onlinepayment_verify';
  static String dropLocationHistory = baseUrl + 'User/drop_location_history';
  static String triphistry = baseUrl + 'User/trip_history';
  static String triphistrydetails = baseUrl + 'User/trip_history_details';
  static String deleteDropLocation = baseUrl + 'User/delete_droploc_history';
  static String getOffers = baseUrl + 'User/get_offers';
  static String applyCoupon = baseUrl + 'User/apply_coupon';
  static String imageUrl = "https://asatvindia.in/cab/";
  static String submitfeedback = baseUrl + 'User/submit_feedback';
  static String convCharge = baseUrl + 'User/conv_charge';
  static String rejectUserRequest = baseUrl + 'User/RejectUserRequest';

//// pree booking
  static String confirmbooking = baseUrl + 'User/pre_booking_available';

  // Payment
  static String getWallet = 'https://www.bits.teamtest.co.in/Api/Wallet/getWallet';

  static String getnotes = baseUrl + 'User/getnotes';
  static String payment = baseUrl + 'User/conv_charge';

//===============Pree booking=========================================================
  static String getPreebookvehicle = baseUrl + 'User/getvehicle';
  static String sendRequestDriverpreebook = baseUrl + 'User/sendReqForfindDriver';
  static String finddriverpreebook = baseUrl + 'User/findDriver';
  static String preebookCab = baseUrl + 'User/Bookcab';
  static String cancelpreebooingvehicle = baseUrl + 'User/CancleBookedCab';
}
