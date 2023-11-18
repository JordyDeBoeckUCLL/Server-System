#!/bin/bash

mysql -u check -prDEetGxq82DCE -e "USE check; DELETE FROM log ORDER BY date LIMIT 10;"
