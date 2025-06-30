#!/bin/bash

if [ -f "/.dockerenv" ] || [ -f "/run/.containerenv" ]; then
  echo "Detected container environment. Exiting the script"
  exit 0
else
  echo "Executing render template"

  # Check python and pip
  if ! command -v python3 &> /dev/null || ! command -v pip &> /dev/null; then
      echo "Python3 or Pip is not installed in your WSL."
      echo "In WSL, you can install them with the following command:"
      echo "sudo apt update && sudo apt install -y python3 python3-venv python3-pip"
      exit 1
  fi

  # Set up a virtual environment
  VENV="$HOME/venvs/template_venv"
  if [ ! -d "$VENV" ]; then
      echo "Virtual environment not found. Creating template_venv"
      python3 -m venv "$VENV"
  fi

  # Activate virtual environment
  source "$VENV/bin/activate"

  # Install requirements
  if ! pip freeze | grep -q -f .template/requirements.txt; then
      echo "Installing packages from requirements.txt..."
      pip install --upgrade pip
      pip install -r .template/requirements.txt
  fi
  
  # Run the render script
  python3 .template/render/render.py

  # Deactivate virtual environment
  deactivate

fi