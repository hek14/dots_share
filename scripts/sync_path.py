#!/usr/bin/env python
import subprocess
import os
import sys
import re
import argparse

def parse_arg():
    parser = argparse.ArgumentParser()
    parser.add_argument("--host", type=str, required=True)
    parser.add_argument("--path", type=str, required=True)
    return parser

if __name__ == "__main__":
    args = parse_arg().parse_args()
    cmd = 'ssh -t {} \'cd {} && fd --no-ignore ".*"  && echo success\''.format(args.host, args.path)
    print(cmd)
    result = subprocess.run(cmd, shell=True, text=True, stdout = subprocess.PIPE, stderr = subprocess.PIPE)
    if result.stderr and not re.match("^Connection to" ,result.stderr):
        print(result.stderr)
    if result.stdout:
        ansi_escape = re.compile(r"\x1b\[[0-?]*[ -/]*[@-~]")
        stdout = ansi_escape.sub('', result.stdout) # remove ANSI escape characters for colored text
        lines = list(filter(lambda e: len(e), stdout.split('\n')))
        if(lines[-1]!="success"):
            print("failed")
            sys.exit(1)
        root = args.path if args.path.endswith("/") else args.path + "/"
        keep_lines = []
        root_path = root.replace("/", "&")
        output = f"{os.environ['HOME']}/mnt/{args.host}/{root_path}.path"
        print(output)
        if os.path.exists(output):
            with open(output, "r") as f:
                og_lines = f.read().splitlines()
                for line in og_lines:
                    if(len(line) and not re.search(fr"{args.host}:{root}", line)):
                        keep_lines.append(line)
        print("success")
        lines = [f"{args.host}:{root}{e}" for e in lines[:-1]]
        lines.extend(keep_lines)
        with open(output, "w") as f:
            for line in lines:
                f.write(f"{line}\n")
