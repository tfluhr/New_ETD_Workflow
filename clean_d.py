import os
import sys


def clean_name(working_dir):
    #rootdir = r'C:\Users\tfluhr\Desktop\ETDS_UNZIP\Fall2019'
    str = "_DATA"
    for filename in os.listdir(working_dir):
        if str in filename:
            filepath = os.path.join(working_dir, filename)
            newfilepath = os.path.join(working_dir, filename.replace(str, ""))
            os.rename(filepath, newfilepath)
