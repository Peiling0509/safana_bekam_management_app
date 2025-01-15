// ignore_for_file: camel_case_types

class userRolesModel {
  static const String therapists = 'therapists';
  static const String admin = 'admin';

  static const Map<String, List<String>> rolePermissions = {
    userRolesModel.admin: [
      userAction.addNewPatient,
      userAction.editInfoPatient,
      userAction.printReport
    ],
    userRolesModel.therapists: [
      userAction.addTreatment,
      userAction.editTreatment
    ],
  };
}

class userAction {
  //Admin
  static const String addNewPatient = 'addNewPatient';
  static const String editInfoPatient = 'editInfoPatient';
  static const String printReport = 'printReport';

  //therapists
  static const String addTreatment = 'addTreatment';
  static const String editTreatment = 'editTreatment';
}
