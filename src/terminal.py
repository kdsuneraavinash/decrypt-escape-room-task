import signal
import os
import time
import progressbar
import struct
from termcolor import colored, cprint

DEBUG = True
TERMINAL_WIDTH = 170
TERMINAL_HEIGHT = 77


def center(s):
    if type(s) is str:
        s = s.split('\n')
    s = [i.strip().center(TERMINAL_WIDTH) for i in s]
    s = "\n".join(s) + '\n'
    return s

# =======================================================


def handler(signum, frame):
    pass


def set_handler(h):
    signal.signal(signal.SIGINT, h)
    signal.signal(signal.SIGTSTP, h)


set_handler(handler)

# =======================================================


def clear_terminal():
    os.system('tput reset')

# =======================================================


def show_progress(wait, progress):
    for i in progressbar.progressbar(range(100)):
        if i > progress:
            print()
            break
        time.sleep(wait)

# ======================================================


def green_text(message):
    return colored(message, 'green')


def bold_green_text(message):
    return colored(message, 'green', attrs=['bold'])


def yellow_text(message):
    return colored(message, 'yellow')


def bold_yellow_text(message):
    return colored(message, 'yellow', attrs=['bold'])


def red_text(message):
    return colored(message, 'red')


def bold_red_text(message):
    return colored(message, 'red', attrs=['bold'])


def cyan_text(message):
    return colored(message, 'cyan')


def bold_cyan_text(message):
    return colored(message, 'cyan', attrs=['bold'])


def dark_white_text(message):
    return colored(message, 'white', attrs=['dark'])


def white_text(message):
    return colored(message, 'white')
