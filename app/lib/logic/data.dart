class Data {
  static Map<String, UserSolution> data = {
    "E1": UserSolution(solution: "246", time: "11:00"),
    "E2": UserSolution(solution: "328", time: "11:05"),
    "E3": UserSolution(solution: "179", time: "11:10"),
    "E4": UserSolution(solution: "457", time: "11:15"),
    "E5": UserSolution(solution: "961", time: "11:20"),
    "E6": UserSolution(solution: "742", time: "11:25"),
    "E7": UserSolution(solution: "313", time: "11:30"),
    "E8": UserSolution(solution: "462", time: "11:35"),
    "E9": UserSolution(solution: "397", time: "11:40"),
  };
}

class UserSolution {
  final String solution;
  final String time;

  UserSolution({this.time = "12:25", this.solution = ""});
}
