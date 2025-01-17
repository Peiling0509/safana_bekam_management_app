// ignore_for_file: non_constant_identifier_names

class API {
  static String DOMAIN_URL = "http://188.166.247.227:5000";

  static String LOGIN = "$DOMAIN_URL/login";

  //USER
  static String UPDATE_USER = "$DOMAIN_URL/update-user";

  //DASHBOARD
  static String EXPORT_PATIENTS_DAILY = "$DOMAIN_URL/check-patients-daily";
  static String EXPORT_PATIENTS_MONTHLY = "$DOMAIN_URL/check-patients-monthly";
  static String EXPORT_TOTAL_PATIENTS = "$DOMAIN_URL/total-patients";
  static String EXPORT_TREATMENT_DAILY = "$DOMAIN_URL/treatment-records-daily";

  //PATIENTS
  static String EXPORT_PATIENTS = "$DOMAIN_URL/export-patients";
  static String REGISTER_PATIENT = "$DOMAIN_URL/register-patient";
  static String DELETE_PATIENT = "$DOMAIN_URL/delete-patient";
  static String UPDATE_PATIENT = "$DOMAIN_URL/update-patient";

  //TREATMENT
  static String EXPORT_TREATMENTS= "$DOMAIN_URL/export-patient-simplify";
  static String EXPORT_TREATMENT_DETAILS = "$DOMAIN_URL/export-patient-record-visit";
  static String SUBMIT_TREATMENT = "$DOMAIN_URL/submit-treatment";
  static String UPDATE_TREATMENT = "$DOMAIN_URL/update-treatment-record";
  static String DELETE_TREATMENT = "$DOMAIN_URL/delete-record";

  //NOTIFICATIONS
  static String EXPORT_NOTIFICATIONS = "$DOMAIN_URL/notifications";
  
}
