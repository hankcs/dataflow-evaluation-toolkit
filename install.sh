#!/bin/bash

set -e

rm -rf venv
python3.7 -m venv venv
source venv/bin/activate

git clone https://github.com/telepathylabsai/OpenDF.git
pushd OpenDF
git checkout c0907a4cc67d32a81a55291812f9f32e6f92d953
git apply ../opendf_changes.patch
pip install .
popd
rm -rf OpenDF

git clone https://github.com/microsoft/semantic_parsing_with_constrained_lm.git
pushd semantic_parsing_with_constrained_lm
git checkout 40c2bfd3ac256b610eec467803b466508641e31a
git apply ../semantic_parsing_with_constrained_lm_changes.patch
pip install ./src
popd
cp -rf semantic_parsing_with_constrained_lm/src/semantic_parsing_with_constrained_lm venv/lib/python3.7/site-packages
rm -rf semantic_parsing_with_constrained_lm

pip install packaging==21.3
pip install -e . --extra-index-url=https://smpypi.z5.web.core.windows.net/

if python aws_lex_program_synthesis_calendar/bot_cli.py <<<''; then
  echo 'Installation succeed'
  echo 'Run the following command to activate the installed venv:'
  echo '    source venv/bin/activate'
else
  echo 'Installation failed'
fi
