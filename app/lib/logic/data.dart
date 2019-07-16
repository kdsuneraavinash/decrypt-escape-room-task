class Data {
  static Map<String, UserSolution> data = {
    "TeamMAP": UserSolution(),
    "TeamMB": UserSolution(),
    "TeamMCP": UserSolution(),
    "TeamMC": UserSolution(),
    "Teamwe": UserSolution(),
    "TeamMeP": UserSolution(),
  };
}

class UserSolution {
  final String imageUrl;
  final String time;

  UserSolution({this.time = "12:23", this.imageUrl = ""});
}
