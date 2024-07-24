class ProfileModel {
  final int? t_no;
  final String? t_name;
  final String? t_lib;
  final String? t_gender;
  final String? t_exp;
  final String? t_image;
  const ProfileModel ({
    required this.t_no,
    required this.t_name,
    required this.t_lib,
    required this.t_gender,
    required this.t_exp,
    required this.t_image,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        t_no: json['t_no'],
        t_name: json['t_name'],
        t_lib: json['t_lib'],
        t_gender: json['t_gender'],
        t_exp: json['t_exp'],
        t_image: json['t_image'],
    );

  }

  Map<String, dynamic> toJson() {
    return {
      't_no': t_no,
      't_name': t_name,
      't_lib': t_lib,
      't_gender': t_gender,
      't_exp': t_exp,
      't_image': t_image,
    };
  }
}

