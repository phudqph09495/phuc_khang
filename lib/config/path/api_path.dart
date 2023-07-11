class ApiPath {
  static const login="/customer/login";
  static const getOTP="/user/submitphone?phone=";
  static const vertifyOTP="/user/verifyotp";
  static const profile="/customer/profile-user";
  static const lichSu='/customer/order/list';
  static const tinh="/customer/order/region/list";
  static const huyen="/customer/order/district/list?regionId=";
  static const updatePro="/customer/profile/update";
  static const deleteAcc="/customer/delete";
  static const dangky="/customer/register";
static const firebase="/notification/fcmToken";
  static const detailOrder='/customer/order/detail/';

  /// product
static const flash='/product/flashsale?flash_sale_id=';
static const config='/config';
static const productAll='/product/category/';
static const infoPro='/product/info/';
static const relatePrd='/product/related?id=';
static const category='/category';
static const phiVanCHuyen='/order/shipFee';
static const order="/customer/order/create";
static const search="/search?search=";
  static const like='/product/like?product_id=';
  static const likeList="/product/favorite";
  static const rate="/product/rate";
  static const coupon="/coupon/run";
  static const testCounpon="/order/promotionCode?code=";


/// noti
static const notifi='/notification?per_page=10&page=';


/// news
  static const detailNews='/news/detail?news_id=';
static const cateNews="/news/category";
static const newsList='/news/index?category_id=';
  }