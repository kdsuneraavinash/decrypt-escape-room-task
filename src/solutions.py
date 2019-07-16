from file_system import open_file_and_get_content


class Solutions:
    def __init__(self, e_group):
        self.server_login_password = open_file_and_get_content(
            'solution/login_password.txt')
        self.group_dir = f"solution/groups/{e_group}"

        self.encryption_key = open_file_and_get_content(
            f'{self.group_dir}/encryption_key.txt')
        self.first_clue_pdf = f'{self.group_dir}/first_clue.pdf'
        self.image_recognition_pdf = f'{self.group_dir}/camera.pdf'
