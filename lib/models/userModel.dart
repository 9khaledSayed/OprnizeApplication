class UserModel {
  int id;
  String companyId;
  String providerId;
  String departmentId;
  String sectionId;
  String supervisorId;
  String workShiftId;
  String nationalityId;
  String jobTitleId;
  String roleId;
  String nameAr;
  String nameEn;
  String cityId;
  String fnameAr;
  String snameAr;
  String tnameAr;
  String lnameAr;
  String fnameEn;
  String snameEn;
  String tnameEn;
  String lnameEn;
  String photo;
  String cityNameAr;
  String cityNameEn;
  String jobNumber;
  String birthdate;
  String maritalStatus;
  String gender;
  String testPeriod;
  String idNum;
  String idIssueDate;
  String idExpireDate;
  String passportNum;
  String passportIssueDate;
  String passportExpireDate;
  String issuePlace;
  String contractType;
  String contractStartDate;
  String contractEndDate;
  String contractPeriod;
  String allowance;
  String phone;
  String leaveBalance;
  String availableBalance;
  String barcode;
  String serviceStatus;
  String email;
  String emailVerifiedAt;
  String salary;
  String isCompleted;
  String createdAt;
  String updatedAt;
  String compensation;
  String compensationType;
  String notificationPeriod;
  String endService;
  String typeEndService;
  String dateEndService;
  String availabelBalance;
  String usedBalance;

  UserModel(
      {this.id,
      this.companyId,
      this.providerId,
      this.departmentId,
      this.sectionId,
      this.supervisorId,
      this.workShiftId,
      this.nationalityId,
      this.jobTitleId,
      this.roleId,
      this.nameAr,
      this.nameEn,
      this.cityId,
      this.fnameAr,
      this.snameAr,
      this.tnameAr,
      this.lnameAr,
      this.fnameEn,
      this.snameEn,
      this.tnameEn,
      this.lnameEn,
      this.photo,
      this.cityNameAr,
      this.cityNameEn,
      this.jobNumber,
      this.birthdate,
      this.maritalStatus,
      this.gender,
      this.testPeriod,
      this.idNum,
      this.idIssueDate,
      this.idExpireDate,
      this.passportNum,
      this.passportIssueDate,
      this.passportExpireDate,
      this.issuePlace,
      this.contractType,
      this.contractStartDate,
      this.contractEndDate,
      this.contractPeriod,
      this.allowance,
      this.phone,
      this.leaveBalance,
      this.availableBalance,
      this.barcode,
      this.serviceStatus,
      this.email,
      this.emailVerifiedAt,
      this.salary,
      this.isCompleted,
      this.createdAt,
      this.updatedAt,
      this.compensation,
      this.compensationType,
      this.notificationPeriod,
      this.endService,
      this.typeEndService,
      this.dateEndService,
      this.availabelBalance,
      this.usedBalance});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    providerId = json['provider_id'];
    departmentId = json['department_id'];
    sectionId = json['section_id'];
    supervisorId = json['supervisor_id'];
    workShiftId = json['work_shift_id'];
    nationalityId = json['nationality_id'];
    jobTitleId = json['job_title_id'];
    roleId = json['role_id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    cityId = json['city_id'];
    fnameAr = json['fname_ar'];
    snameAr = json['sname_ar'];
    tnameAr = json['tname_ar'];
    lnameAr = json['lname_ar'];
    fnameEn = json['fname_en'];
    snameEn = json['sname_en'];
    tnameEn = json['tname_en'];
    lnameEn = json['lname_en'];
    photo = json['photo'];
    cityNameAr = json['city_name_ar'];
    cityNameEn = json['city_name_en'];
    jobNumber = json['job_number'];
    birthdate = json['birthdate'];
    maritalStatus = json['marital_status'];
    gender = json['gender'];
    testPeriod = json['test_period'];
    idNum = json['id_num'];
    idIssueDate = json['id_issue_date'];
    idExpireDate = json['id_expire_date'];
    passportNum = json['passport_num'];
    passportIssueDate = json['passport_issue_date'];
    passportExpireDate = json['passport_expire_date'];
    issuePlace = json['issue_place'];
    contractType = json['contract_type'];
    contractStartDate = json['contract_start_date'];
    contractEndDate = json['contract_end_date'];
    contractPeriod = json['contract_period'];
    allowance = json['allowance'];
    phone = json['phone'];
    leaveBalance = json['leave_balance'];
    availableBalance = json['available_balance'];
    barcode = json['barcode'];
    serviceStatus = json['service_status'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    salary = json['salary'];
    isCompleted = json['is_completed'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    compensation = json['compensation'];
    compensationType = json['compensation_type'];
    notificationPeriod = json['notification_period'];
    endService = json['end_service'];
    typeEndService = json['type_end_service'];
    dateEndService = json['date_end_service'];
    availabelBalance = json['availabel_balance'];
    usedBalance = json['used_balance'];
  }
}
