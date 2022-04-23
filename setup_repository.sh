#!/bin/bash

# Args:
# $1 = Path to Language Model

curr_dir=$(pwd)

# Create a Python venv
pip install virtualenv
virtualenv lillie
source $curr_dir/lillie/bin/activate

# LILLIE
pip install -r requirements.txt
python3 -m spacy download en_core_web_md

mkdir ./rule_based/parser

wget http://nlp.stanford.edu/software/stanford-english-corenlp-2018-10-05-models.jar
wget http://nlp.stanford.edu/software/stanford-corenlp-full-2018-10-05.zip

unzip stanford-corenlp-full-2018-10-05.zip -d ./rule_based/parser
mv stanford-english-corenlp-2018-10-05-models.jar ./rule_based/parser/stanford-corenlp-full-2018-10-05


# pyclausie
cd $curr_dir/learning_based/pyclausie
# There is a bug in the code; the author uses "basestring", which is no longer
# valid in Python 3.x. Replace all occurrences of that.
sed -i 's/basestring/str/g' ./build/lib/pyclausie/ClausIE.py
python3 setup.py install


# OpenIE
cd $curr_dir/learning_based/OpenIE-standalone

gdown 19z8LO-CYOfJfV5agm82PZ2JNWNUPIB6D

wget https://github.com/dair-iitd/OpenIE-standalone/releases/download/v5.0/BONIE.jar
wget https://github.com/dair-iitd/OpenIE-standalone/releases/download/v5.0/ListExtractor.jar

cp $1 ./data/

mkdir ./lib
mv BONIE.jar ./lib
mv ListExtractor.jar ./lib

cd $curr_dir
