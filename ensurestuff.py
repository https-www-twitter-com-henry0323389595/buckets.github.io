#!/usr/bin/env python
from __future__ import print_function

import sys
import os

errors = []

posts = os.listdir('_posts')
for post in posts:
    print(post)
    fpath = os.path.join('_posts', post)
    with open(fpath, 'rb') as fh:
        for i,line in enumerate(fh):
            if line.startswith('image:'):
                # header image
                if not line.count('site.url'):
                    # lacking
                    errors.append((
                        fpath,
                        'line {0}'.format(i),
                        line.strip(),
                        'lacks {{ site.url }} prefix'))
            elif line.count('<img'):
                # html image
                if line.count('<img') != line.count('site.url'):
                    errors.append((
                        fpath,
                        'line {0}'.format(i),
                        'lacks {{ site.url }} prefix'))

if errors:
    print('Errors:')
    for stuff in errors:
        print(*stuff)
    sys.exit(1)
    