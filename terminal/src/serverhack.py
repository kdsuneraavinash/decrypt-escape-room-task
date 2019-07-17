import random
import os
import time
import readline
import terminal
from file_system import *
from solutions import Solutions
import signal

IP = '158.24.64.6'
SOLUTIONS = None


def server_hack_task():
    terminal.clear_terminal()

    head_gda = terminal.bold_green_text(
        open_file_and_get_content('assets/head2.txt'))
    print(f"{head_gda}\n")

    # Server log file
    server_log_text = open_file_and_get_content('assets/server_log.txt')
    # Inline coloring of server log text
    server_log_text = '\033[1m'.join(server_log_text.split("$%B%$"))
    server_log_text = '\033[0m\033[37m\033[2m'.join(
        server_log_text.split("$%E%$"))
    server_log = TextFile('server.log', server_log_text)

    # Fake files
    fake_file_1 = TextFile('g.txt', open_file_and_get_content(
        'assets/files/camera_tip.txt'))
    fake_file_2 = TextFile('dconf.txt', open_file_and_get_content(
        'assets/files/log_tip.txt'))
    fake_file_3 = TextFile('yuri.txt', open_file_and_get_content(
        'assets/files/empty_file.txt'))
    fake_file_4 = TextFile('iporf.txt',  open_file_and_get_content(
        'assets/files/exe_read.txt'))
    fake_file_5 = TextFile('abcd.txt', open_file_and_get_content(
        'assets/files/empty_file.txt'))

    # Zip file
    printable_file = PrintableFile('cr.pdf', SOLUTIONS.first_clue_pdf)
    cam_file = ExecutableFile(
        'camera.exe', 'camera.py', SOLUTIONS.encryption_key, SOLUTIONS.image_recognition_pdf)
    zip_file = ZipFile('tools.zip', 0.91, [
                       printable_file, fake_file_1, cam_file])

    # Folders
    folder1 = VirtualFolder('log', [server_log], None)
    folder2 = VirtualFolder('usr', [fake_file_2, fake_file_3], None)
    folder3 = VirtualFolder('lib', [fake_file_5], None)
    root = VirtualFolder(
        '', [printable_file, cam_file, folder1, folder2, folder3, fake_file_4], None)
    folder1.parent = root
    folder2.parent = root
    folder3.parent = root

    # Handle commands
    current_directory = root
    while True:
        try:
            x = input(terminal.bold_green_text(
                f'CE:{IP}-BASE:$~{current_directory.path()}/ '.strip()))
            if x == '':
                continue
            x = x.split()
            command = x.pop(0)
            arg = '.' if len(x) == 0 else x.pop(0)

            if command in ['list', 'ls']:
                VirtualInstance.list_command(current_directory)
            elif command in ['cd']:
                current_directory = current_directory.cd(arg)
            elif command in ['read']:
                VirtualInstance.read_file_command(current_directory, arg)
            elif command in ['download']:
                VirtualInstance.download_file_command(
                    current_directory, zip_file, arg)
            elif command in ['extract', 'unzip']:
                VirtualInstance.extract_file_command(current_directory, arg)
            elif command in ['run']:
                VirtualInstance.run_file_command(current_directory, arg)
            elif command in ['clear', 'cls']:
                terminal.clear_terminal()
                print(f"{head_gda}\n")
            elif command in ['print']:
                VirtualInstance.print_file_command(current_directory, arg)
            elif command in ['help']:
                VirtualInstance.help_command()
            elif command in ['exit']:
                terminal.clear_terminal()
                exit(0)
            elif command in ['execute']:
                subprocess.call(x)
            else:
                print("unknown command:", command)
        except NotImplementedError:
            print("invalid usage of command", command, "with args:", arg)
        except Exception as e:
            print(e)


if __name__ == "__main__":
    signal.signal(signal.SIGTSTP, signal.SIG_IGN)

    SOLUTIONS = Solutions(1)
    terminal.clear_terminal()

    # Show head text (SERVER LOGIN)
    head_text = open_file_and_get_content('assets/head.txt')
    print(terminal.bold_green_text(head_text))

    # Login password guard block
    while True:
        x = input(terminal.bold_yellow_text(f"Enter {IP} password: "))

        print("Verifing password...")
        if x == SOLUTIONS.server_login_password:
            terminal.show_progress(0.01, 100)
            print(terminal.green_text("\nLogging in..."))

            terminal.show_progress(0.08, 100)

            lines = open_file_and_get_content('assets/login.txt').split('\n')
            for i, line in enumerate(lines):
                if i % 50 == 0:
                    time.sleep(0.05)
                print(line.strip())
                if i % 432 == 0:
                    terminal.show_progress(0.009, random.randint(1, 75))
            terminal.show_progress(0.005, random.randint(1, 75))
            terminal.clear_terminal()
            time.sleep(2.0)
            break
        else:
            terminal.show_progress(0.01, random.randint(1, 75))
            print(terminal.bold_red_text("invalid password"))
        print()

    # Start task
    server_hack_task()
