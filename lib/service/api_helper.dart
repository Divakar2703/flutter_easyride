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
  static String triphistrydetails = baseurl+'User/trip_history_details';
  static String deleteDropLocation=baseurl+'User/delete_droploc_history';
  static String getOffers=baseurl+'User/get_offers';
  static String applyCoupon=baseurl+'User/apply_coupon';
  static String imageUrl="https://asatvindia.in/cab/";
  static String submitfeedback = baseurl+'User/submit_feedback';
  static String convCharge = baseurl+'User/conv_charge';
  static String rejectUserRequest = baseurl+'User/RejectUserRequest';

//// pree booking
  static String confirmbooking =baseurl+'User/pre_booking_available';


  // Payment
  static String getWallet ='https://www.bits.teamtest.co.in/Api/Wallet/getWallet';




  static String  getnotes = baseurl + 'User/getnotes';
  static String  payment = baseurl + 'User/conv_charge';



//===============Pree booking=========================================================
  static String getPreebookvehicle = baseurl + 'User/getvehicle';
  static String sendRequestDriverpreebook =
      baseurl + 'User/sendReqForfindDriver';
  static String finddriverpreebook = baseurl + 'User/findDriver';
  static String preebookCab = baseurl + 'User/Bookcab';
  static String cancelpreebooingvehicle = baseurl + 'User/CancleBookedCab';


  // rental
 static String getRentalBooking = baseurl + "User/rental_booking";
 static String getRecurringBooking = baseurl + "User/rental_booking";


  static String getRentalVehicle = baseurl + "User/get_rental_vehicle";


  static String dashboard = baseurl + "User/dashboard";
  static String cab_request_on_user_id = baseurl + "User/cab_request_on_user_id";


}