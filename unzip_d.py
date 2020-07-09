import os, os.path
from zipfile import ZipFile
import sys

def unzip(working_dir):
    for root, dirs, files in os.walk(working_dir):
        for file in files:
            if file.endswith('.zip'):
                print(working_dir + '\\' + file)
                with ZipFile(working_dir + '\\' + file, 'r') as zipObj:
                    zipObj.extractall(working_dir)
                os.remove(working_dir + '\\' + file)
