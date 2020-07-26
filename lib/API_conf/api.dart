import 'package:shared_preferences/shared_preferences.dart';

const API = "http://kodi.cosmicnerds.com/api";
const API_NO = "http://kodi.cosmicnerds.com/";
const API_STORAGE = API_NO+"storage/";
const LOGIN_API = API + "/login";
const REGISTER_API = API + "/register";
const USERS_INDEX_API = API + "/users_index";
const ABOUT_INFO_INDEX = API + "/about_info_index";
const CONTACT_INFO_INDEX = API + "/contact_info_index";
const INCOME_TAX_INDEX = API + "/income_tax_index";
const NEWS_POST_INDEX_API = API + "/news_post_index";
const NOTIFICATION_CENTER_INDEX_API = API + "/notification_center_index";
const PACKAGES_INDEX_API = API + "/packages_index";
const REG_NEW_BUSINESS_INDEX = API + "/reg_new_business_index";
const SUBSCRIBER_INDEX_API = API + "/subscriber_index";
const TAX_CALCULATOR_INDEX_API = API + "/tax_calculator_index";
const TAX_CALENDER_INDEX_API = API + "/tax_calender_index";
const PAYMENT_API = API + "/payment";

class AccesTokenG {
  accessTokenStorageF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token') ?? '0';
  }
}
