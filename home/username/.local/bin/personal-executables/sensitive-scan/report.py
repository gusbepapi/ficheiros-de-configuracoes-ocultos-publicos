#!/usr/bin/env python3
"""Convert filename records to a minimal YAML document without external packages."""
import json
import os
import pathlib
import re
import sys
import tempfile


def yaml_write(destination, files):
  destination = pathlib.Path(destination).expanduser()
  destination.parent.mkdir(parents=True, exist_ok=True, mode=0o700)
  files = sorted(set(files))
  fd, temporary = tempfile.mkstemp(prefix='.scan-', dir=destination.parent)
  try:
    with os.fdopen(fd, 'w', encoding='utf-8') as output:
      output.write('files:\n')
      for filename in files:
        output.write('  - ' + json.dumps(filename, ensure_ascii=True) + '\n')
      if not files:
        output.write('  []\n')
    os.replace(temporary, destination)
  finally:
    if os.path.exists(temporary):
      os.unlink(temporary)


def main():
  mode, source, destination = sys.argv[1:4]
  source = pathlib.Path(source)
  previous = []
  if pathlib.Path(destination).exists():
    # Reading the previously written JSON-compatible quoted YAML strings
    for line in pathlib.Path(destination).read_text(encoding='utf-8').splitlines():
      if line.startswith('  - '):
        previous.append(json.loads(line[4:]))
  if mode == 'gitleaks':
    findings = json.loads(source.read_text(encoding='utf-8')) if source.exists() and source.stat().st_size else []
    files = [finding['File'] for finding in (findings or []) if finding.get('File')]
  elif mode == 'rg':
    data = source.read_bytes()
    files = [part.decode('utf-8', 'surrogateescape') for part in data.split(b'\0') if part]
  else:
    raise SystemExit('Unknown mode')
  yaml_write(destination, previous + files)


if __name__ == '__main__':
  main()
