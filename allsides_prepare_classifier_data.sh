#!/bin/bash

cat data/allsides/centrist.en | sed 's/\(.*\)/centrist \1/g' > data/allsides/allsides_centrist_classifier.txt
head -1000 data/allsides/republican.en | sed 's/\(.*\)/biased \1/g' >> data/allsides/allsides_centrist_classifier.txt
head -1000 data/allsides/democratic.en | sed 's/\(.*\)/biased \1/g' >> data/allsides/allsides_centrist_classifier.txt

cat data/allsides/allsides_centrist_classifier.txt | sort -R | split -l 3017
mv xaa data/allsides/allsides_centrist_classifier.train.en
split -l 300 xab allsides_centrist_classifier.
cat allsides_centrist_classifier.aa > data/allsides/allsides_centrist_classifier.dev.en
cat allsides_centrist_classifier.ab | grep -e "centrist .*" |sed "s/\(centrist \)\(.*\)/\2/g" > data/allsides/allsides_centrist_classifier.test.centrist_only.en
cat allsides_centrist_classifier.ab | grep -e "biased .*" |sed "s/\(biased \)\(.*\)/\2/g" > data/allsides/allsides_centrist_classifier.test.biased_only.en

rm allsides_centrist_classifier.aa
rm allsides_centrist_classifier.ab
