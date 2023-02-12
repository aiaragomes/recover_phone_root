#!/bin/sh
# Create environment to run payload dumper

# Get python 3.6
PYTHON_BIN=$HOME/.pyenv/versions/3.6.11/bin/python
if [ ! -f ${PYTHON_BIN} ]; then
  if [ ! -f $(which pyenv) ]; then
    echo "Please install pyenv..."
    exit 1
  fi
  pyenv install 3.6.11
fi

# Create virtual environment
if [ ! -f $(which virtualenv) ]; then
  echo "Please install virtualenv..."
  exit 1
fi
virtualenv -p $PYTHON_BIN .venv

# Get payload dumper
wget https://raw.githubusercontent.com/vm03/payload_dumper/master/payload_dumper.py
wget https://raw.githubusercontent.com/vm03/payload_dumper/master/update_metadata_pb2.py

# Install dependencies
source .venv/bin/activate
if [ ! -f $(which pip) ]; then
  echo "Please install pip..."
  exit 1
fi
pip install -r requirements.txt

