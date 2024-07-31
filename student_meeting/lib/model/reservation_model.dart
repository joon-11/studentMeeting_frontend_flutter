class ReservationModel {
  final int? r_no;
  final String? time;
  final String? confirm;
  final int? reserve_p;
  final String? lib;

  const ReservationModel({
    required this.r_no,
    required this.time,
    required this.confirm,
    required this.reserve_p,
    required this.lib,

  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      r_no: json['r_no'],
      time: json['time'],
      confirm: json['confirm'],
      reserve_p: json['reserve_p'],
      lib: json['lib'],
    );
  }
}
