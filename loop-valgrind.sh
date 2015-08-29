#!/bin/bash

function shit {
    echo $t
    exit 99
}

find . -maxdepth 1 -regex '.*test_?' -type f -print | while read t; do
if [[ "$t" = "./gmock_output_test_" || "$t" = "./gmock_leak_test_" ]]; then continue; fi
valgrind --leak-check=full --show-leak-kinds=all --error-exitcode=192 --child-silent-after-fork=yes --suppressions=valgrind.supp --track-origins=yes $t || shit ; done
