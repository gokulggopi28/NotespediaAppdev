class LocalStaffMembersModel {
  final String image;
  final String name;
  final String specialization;
  final String info;

  LocalStaffMembersModel({
    required this.image,
    required this.name,
    required this.specialization,
    required this.info,
  });
}

final List<LocalStaffMembersModel> localStaffMembersList = [
  LocalStaffMembersModel(
    image:
        "https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=600",
    name: "Dr. Rajamahendran",
    specialization: "Surgery",
    info: "High-Yield",
  ),
  LocalStaffMembersModel(
    image:
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600",
    name: "Dr. Jane Smith",
    specialization: "Neurology",
    info: "Specialist in advanced procedures",
  ),
  LocalStaffMembersModel(
    image:
        "https://images.pexels.com/photos/697509/pexels-photo-697509.jpeg?auto=compress&cs=tinysrgb&w=600",
    name: "Dr. Michael Johnson",
    specialization: "Orthopedics",
    info: "Board-certified physician",
  ),
  LocalStaffMembersModel(
    image:
        "https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg?auto=compress&cs=tinysrgb&w=600",
    name: "Dr. Emily Davis",
    specialization: "Dermatology",
    info: "Expert in minimally invasive surgery",
  ),
  LocalStaffMembersModel(
    image:
        "https://images.pexels.com/photos/1559486/pexels-photo-1559486.jpeg?auto=compress&cs=tinysrgb&w=600",
    name: "Dr. Robert Wilson",
    specialization: "Gastroenterology",
    info: "Leaders in patient care",
  ),
];
