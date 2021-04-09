class HomeScreenModel {
  int workingDays;
  int workingHours;
  int availableBalance;
  int numberOfLeaves;
  int balancePercentage;
  int presentPercentage;
  int absentPercentage;

  HomeScreenModel(
      {this.workingDays,
      this.workingHours,
      this.availableBalance,
      this.numberOfLeaves,
      this.balancePercentage,
      this.presentPercentage,
      this.absentPercentage});

  HomeScreenModel.fromJson(Map<String, dynamic> json) {
    workingDays = json['working_days'];
    workingHours = json['working_hours'];
    availableBalance = json['available_balance'];
    numberOfLeaves = json['number_of_leaves'];
    balancePercentage = json['balance_percentage'];
    presentPercentage = json['present_percentage'];
    absentPercentage = json['absent_percentage'];
  }
}
