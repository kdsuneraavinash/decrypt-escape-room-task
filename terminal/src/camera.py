import cv2
import numpy as np
import math
import ascii
import os
import imageprocess
import terminal
import shutil
from termcolor import colored, cprint
import subprocess
import time
import string
import random

cap = None


def getCameraFrame(source=0):
    '''Returns camera video frame from video source'''

    global cap

    if cap is None:
        cap = cv2.VideoCapture(source)

    ret = False
    stuck_counter = 0
    while not ret:
        ret, frame = cap.read()
        stuck_counter += 1

        if stuck_counter > 300:
            # Stuck for 300 frames
            return None

    return frame


def getPhotoFrame(file='snapshot.jpeg'):
    '''Returns a photo from file'''

    return cv2.imread(file, 1)


exit_pressed = False
detected = False


def signal_handler(signum, frame):
    global exit_pressed
    exit_pressed = True


def run_image_processor(solution_file):
    '''Main Entry Point'''
    global exit_pressed, detected
    exit_pressed = False

    terminal.set_handler(signal_handler)

    width = terminal.TERMINAL_WIDTH
    height = terminal.TERMINAL_HEIGHT - 10
    img_width = int(width*0.75)
    aspect_ratio = height/width

    while not exit_pressed:
        if detected:
            art = ""
            with open(solution_file, 'r', encoding="utf-8") as f:
                art = f.read()
            tmp_art = ""
            for line in art.split('\n'):
                tmp_art += f"{line}\n"
            art = tmp_art

            frame_color = 'white'
            color = 'green'
            attrs = ['bold', 'underline']
            art = art.split('\n')
            time.sleep(0.1)
        else:
            frame = getCameraFrame()

            if frame is None:
                # Frame lag - stop
                break

            frame, threshed, angle = imageprocess.process(frame)
            frame = cv2.rotate(threshed, cv2.ROTATE_90_COUNTERCLOCKWISE)

            if detected or abs(angle - 45) < 8:
                # Puzzle Solved
                # print("Detected... Printing...", solution_file)
                # subprocess.call(['lp', solution_file])
                time.sleep(1)
                terminal.clear_terminal()
                time.sleep(1)

                detected = True
            else:
                frame = np.pad(frame, pad_width=1,
                               mode='constant', constant_values=0)
                art = ascii.frame_to_ascii_art(
                    frame, img_width, aspect_ratio, ascii.gscale1)

                if angle == float("inf"):
                    frame_color = 'yellow'
                    color = 'white'
                    attrs = ['bold', 'blink']
                else:
                    frame_color = 'green'
                    color = 'green'
                    attrs = ['bold']

        art = terminal.center(art)
        text = "="*width + '\n'
        text += "Streaming CAMERA 1: Searching for the correct Symbol\nPress CTRL+C to exit..\n"
        text += "="*width + '\n\n'
        text = terminal.center(text)
        text += "Output[]: " + \
            colored(imageprocess.message_from_image_processor,
                    color, attrs=attrs)
        text += "\n\n\n"
        art = text + colored(art, frame_color, attrs=['bold'])
        terminal.clear_terminal()
        print(art)

    try:
        cap.release()
        terminal.set_handler(terminal.handler)
    except:
        pass


if __name__ == "__main__":
    run_image_processor("")
