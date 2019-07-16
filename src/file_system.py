import terminal
import importlib
import camera
import random
import string
import subprocess
import time


def open_file_and_get_content(file_name):
    with open(file_name, 'r', encoding="utf-8") as f:
        return f.read().strip()
    return ""


class VirtualInstance:
    def __init__(self, name):
        self.name = name

    def ls(self):
        raise NotImplementedError()

    def read(self):
        raise NotImplementedError()

    def extract(self, parent):
        raise NotImplementedError()

    def print(self):
        raise NotImplementedError()

    def run(self):
        raise NotImplementedError()

    @staticmethod
    def list_command(current_directory):
        for f in current_directory.ls():
            if type(f) is VirtualFolder:
                s = "{:>15}\t\tfolder".format(f.name)
            else:
                s = "{:>15}\t\t{} file\t{} bytes".format(
                    f.name, f.name[-3:], f.size)
            print(terminal.cyan_text(s))

    @staticmethod
    def read_file_command(current_directory, arg):
        file = current_directory.get_file(arg)
        if file != None:
            print(terminal.dark_white_text(file.read()))
            print()
        else:
            print("file does not exist:", arg)

    @staticmethod
    def download_file_command(current_directory, zip_file, arg):
        print("verifying url...")
        terminal.show_progress(0.001, 100)
        if arg.strip() in ['178.345.235.23/tools.zip',
                           'http://178.345.235.23/tools.zip',
                           'https://178.345.235.23/tools.zip',
                           'ftp://178.345.235.23/tools.zip']:
            print("downloading file...")
            terminal.show_progress(0.08, 100)
            current_directory.files.append(zip_file)
            print(zip_file.name, "successfully downloaded from remote server")
        else:
            print("invalid url:", arg)

    @staticmethod
    def extract_file_command(current_directory, arg):
        file = current_directory.get_file(arg)
        if file != None:
            terminal.show_progress(0.02, 100)
            extracted = file.extract(current_directory)
            current_directory.files.append(extracted)
            print(file.name, "successfully extracted")
        else:
            print("file does not exist:", arg)

    @staticmethod
    def print_file_command(current_directory, arg):
        file = current_directory.get_file(arg)
        if file != None:
            print(file.name, "printing...")
            file.print()
        else:
            print("file does not exist:", arg)

    @staticmethod
    def run_file_command(current_directory, arg):
        importlib.reload(camera)
        file = current_directory.get_file(arg)
        if file != None:
            file.run()
        else:
            print("file does not exist:", arg)

    @staticmethod
    def help_command():
        print(terminal.white_text(open_file_and_get_content('assets/help.txt')))


class VirtualFolder(VirtualInstance):
    def __init__(self, name, files, parent):
        super().__init__(name)
        self.parent = parent if parent != None else self
        self.files = files

    def ls(self):
        self.files.sort(key=lambda a: ("0" if type(
            a) is VirtualFolder else "1") + a.name)
        return self.files

    def path(self):
        if self.parent == None or self.parent == self:
            return ""
        return self.parent.path() + "/" + self.name

    def get_file(self, dir):
        if dir == '.':
            return self
        if dir == '..':
            return self.parent
        for f in self.files:
            if dir == f.name:
                return f
        else:
            return None

    def cd(self, dir):
        f = self.get_file(dir)
        if f is None:
            return self
        else:
            if type(f) == VirtualFolder:
                return f
            else:
                return self


class VirtualFile(VirtualInstance):
    def __init__(self, name, size, content):
        super().__init__(name)
        self.size = size
        self.content = content

    def read(self):
        raise "not a valid executable python file: {}".format(self.name)

    def read(self):
        return self.generateRandomString(len(self.name) + self.size)

    def extract(self, parent):
        raise Exception(
            "CRC Exception - File is not a valid archieve or the file is corrupted.")

    def generateRandomString(self, seed):

        def take_choices(l, n):
            if type(l) is str:
                l = list(l)
            r = []
            for i in range(n):
                r.append(random.choice(l))
            return r

        return ''.join(
            take_choices(
                (string.ascii_uppercase + string.digits +
                 string.ascii_lowercase + string.punctuation),
                self.size
            )
        )


class TextFile(VirtualFile):
    def __init__(self, name, content):
        super().__init__(name, len(content), content)

    def read(self):
        return self.content

    def print(self):
        print("text file is not a valid prinatable file")
        return True


class ZipFile(VirtualFile):
    def __init__(self, name, ratio, content):
        full_size = sum(map(lambda x: x.size, content), 0)*ratio + 10
        super().__init__(name, int(full_size), content)

    def extract(self, parent):
        return VirtualFolder(self.name[:-4], self.content, parent)


class PrintableFile(VirtualFile):
    def __init__(self, name, clue_file):
        super().__init__(name, 12241, '')
        self.clue_file = clue_file

    def print(self):
        subprocess.call(['lp', clue_file])
        return True


class ExecutableFile(VirtualFile):
    def __init__(self, name, file, encryption_key, solution_file):
        super().__init__(name, 256, '')
        self.encryption_key = encryption_key
        self.solution_file = solution_file

    def run(self):
        camera.exit_pressed = False
        print("File is encrypted with a key.")
        x = input("encryption key: ")
        if x == self.encryption_key:
            camera.run_image_processor(self.solution_file)
            time.sleep(1)
            terminal.clear_terminal()
        else:
            print("Wrong password")
