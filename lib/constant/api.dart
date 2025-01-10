// ignore_for_file: non_constant_identifier_names

class API {
  static String DOMAIN_URL = "http://188.166.247.227:5000";

  static String LOGIN = "$DOMAIN_URL/login";

  //PATIENTS
  static String EXPORT_PATIENTS = "$DOMAIN_URL/export-patients";
  static String EXPORT_PATIENT_RECORDS = "$DOMAIN_URL/export-patient-simplify";

  //TREATMENT
  static String EXPORT_TREATMENT = "$DOMAIN_URL/export-patient-record-visit";
  static String SUBMIT_TREATMENT = "$DOMAIN_URL/submit-treatment";
  
  static String REGISTER_PATIENT = "$DOMAIN_URL/register-patient";
}
