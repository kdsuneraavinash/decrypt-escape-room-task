# Terminal Puzzle

## Run

### Ubuntu 18.04

```bash
# Installing dependencies and running

sudo apt-get update

sudo apt-get install -y python3 # install python 3
sudo apt-get -y install python3-pip # install pip

pip3 install opencv-python # install opencv
sudo apt-get install -y libsm6 libxext6 # opencv additional libraries
sudo apt-get install -y libxrender-dev # opencv additional libraries

pip3 install termcolor # Python library: Termcolor
pip3 install progressbar2 # Python library progressbar2

cd src
python3 serverhack.py # Run
```

### Using Conda

```bash
conda create -n py3-cv python=3.7
conda activate py3-cv

conda install opencv # install opencv

conda install termcolor # Python library: Termcolor
conda install progressbar2 # Python library progressbar2

cd src
python serverhack.py # Run
```

## Demo

**Note: This was recorded for an earlier version of the program.**

[Demo Video](decrypt-escaperoom-terminal.mkv)
