#!/usr/bin/env python
import os
import yaml
import argparse

def read_conf(fname='~/rsync_sessions.yaml'):
    """
    Read the configuration file in the working directory
    to get the remote-path and files to be sent/receive.

    Input:
      fname: str
        Configuration file name.
    """
    fname = os.path.expanduser(fname)
    if not os.path.exists(fname):
        raise IOError('File not exists: '+fname)
    with open(fname,'r') as f:
        conf = yaml.safe_load(f)
    return conf

def parse_arg():
    parser = argparse.ArgumentParser()
    parser.add_argument("--session", type=str, required=True)
    parser.add_argument("--dir", type=str, choices=("send", "receive"), required=True)
    return parser

def merge_dict(global_dict, local_dict):
    if local_dict is None:
        return global_dict
    ans = global_dict
    for k,_ in ans.items():
        if k in local_dict:
            ans[k] = local_dict[k]
    return ans

def processs_dir(path:str):
    if(not path.endswith("/")):
        path += "/"
    return path

def main(args):
    session = conf["sessions"][args.session]
    direction = args.dir
    remote_host = session["host"]
    remote_dir = session["remote_dir"]
    source_dir = session["source_dir"]
    if(session["type"] == "dir"):
        remote_dir = processs_dir(remote_dir)
        source_dir = processs_dir(source_dir)
    remote_dir = remote_host + ":" + remote_dir
    settings = merge_dict(conf["settings"], session["settings"] if "settings" in session else None)

    cmd = ""
    cmd += settings["rsync"] + " " + settings["options"] + " " 
    cmd += "--exclude-from " + settings["exclude-from"] + " "
    if(direction == "send"):
        cmd += source_dir + " " +  remote_dir + " "
    else:
        cmd += remote_dir + " " +  source_dir + " "
    
    print(cmd)
    os.system(cmd)

if __name__ == "__main__":
    conf = read_conf()
    args = parse_arg().parse_args()
    main(args)
