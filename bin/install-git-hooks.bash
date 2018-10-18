#!/bin/bash

FILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for f in ${FILE_DIR}/../git-hooks/*; do
    filename=$(basename ${f})
    ln -sf ${f} ${FILE_DIR}/../.git/hooks/${filename}
done
