#!/bin/bash

rm -rf AWSLexProgramSynthesisCalendar.egg-info
rm -rf venv
rm -rf OpenDF
rm -rf semantic_parsing_with_constrained_lm
rm -rf data/result
rm -rf data/database
find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete