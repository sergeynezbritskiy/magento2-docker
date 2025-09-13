#!/bin/bash

sudo pgrep php-fpm | head -n 1 | xargs -i kill -USR2 {}
