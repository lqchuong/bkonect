class CollectionFirebase {
  static final users = "users";
  static final notification = "notification";
  static final token_noti_user = "token_noti_user";
  static final company = "company";
  static final serial_numbers = "serial_numbers";
  static final company_staff = "company_staff";
  // static final waranty_config = "waranty_config";
}

enum subcol_company {
  product_type,
  product,
  waranty_config,
  repair_config,
  waranty_type,
  repair_type
}
enum subcol_serial {
  waranty,
  waranty_progress,
  waranty_progress_delivery,
  repair,
  repair_progress,
  repair_progress_delivery
}
