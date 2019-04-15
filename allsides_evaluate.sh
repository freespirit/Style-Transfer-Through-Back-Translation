#!/usr/bin/env bash

python classifier/cnn_translate.py \
 -model models/classifier/political_classifier/political_classifier.pt \
 -src data/allsides/republican-democratic-trained.txt \
 -tgt 'democratic' -label0 republican -label1 democratic

python classifier/cnn_translate.py \
 -model models/classifier/political_classifier/political_classifier.pt \
 -src data/allsides/democratic-republican-trained.txt \
 -tgt 'republican' -label0 republican -label1 democratic

