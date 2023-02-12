#!/bin/sh
# Create environment to run payload dumper

# Get python 3.6
pyenv install 3.6.11

# Create virtual environment
virtualenv -p $HOME/.pyenv/versions/3.6.11/bin/python .venv

# Get payload dumper
wget https://raw.githubusercontent.com/vm03/payload_dumper/master/payload_dumper.py
wget https://raw.githubusercontent.com/vm03/payload_dumper/master/update_metadata_pb2.py

# Install dependencies
source .venv/bin/activate
pip install -r requirements.txt
echo "Payload dumper successfully installed!"
