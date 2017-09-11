#!/bin/bash
# Copyright 2017 Paul Twohey. All Rights reserved. See LICENSE file for details

set -e
echo '==== Installing software and applications'
./software.sh

echo '==== Configuring applications'
./configure-atom.sh
./configure-eclipse.rb

echo '==== Done ===='
