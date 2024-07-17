#!/usr/bin/env python
import subprocess
import os
import sys
import argparse

def parse_arg():
    parser = argparse.ArgumentParser()
    parser.add_argument("--host", type=str, required=True)
    parser.add_argument("--cmd", type=str, required=True)
    parser.add_argument("--output", type=str, required=True)
    return parser

if __name__ == "__main__":
    args = parse_arg().parse_args()
    cmd = f"ssh -t {args.host} '{args.cmd}'"
    f = open(args.output, "w")
    result = subprocess.run(cmd, shell=True, text=True, stdout = f, stderr = subprocess.PIPE)
    f.close()
    if result.stderr:
        print(result.stderr)
