class ApiHelper{
  static String baseurl="https://asatvindia.in/cab/Api/";
  static String authApi="${baseurl}Api_auth/fetch_api_auth";
  static String getVehicle=baseurl+'User/getvehicle';
  static String getTheme=baseurl+'User/get_theme';
  static String sendRequestDriver=baseurl+'User/sendReqForfindDriver';
  static String findDriver=baseurl+'User/findDriver';
  static String bookCab=baseurl+'User/Bookcab';
  static String cancelBookCab=baseurl+'User/CancleBookedCab';
  static String payNow=baseurl+'User/paynow';
  static String paymentVerify=baseurl+'User/payment_verify';
  static String afterPayNowOnline=baseurl+'User/afterpaynow_online';
  static String afterPayNowWallet=baseurl+'User/afterpaynow_wallet';
  static String afterOnlinePaymentVerify=baseurl+'User/after_onlinepayment_verify';
  static String dropLocationHistory=baseurl+'User/drop_location_history';
  static String triphistry = baseurl+'User/trip_history';
  static String triphistrydetails = baseurl+'User/trip_history_details/booking_id';
  static String submitfeedback = baseurl+'User/submit_feedback';


//// pree booking 
 static String confirmbooking =baseurl+'User/pre_booking_available';

 

}