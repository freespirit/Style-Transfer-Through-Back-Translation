#!/bin/bash

#python classifier/preprocess.py -train_src data/allsides/allsides_centrist_classifier.train.en -label0 biased -label1 centrist -valid_src data/allsides/allsides_centrist_classifier.dev.en -save_data political_centrist -src_vocab_size 20000

#python classifier/cnn_train.py -data political_centrist.train.pt -save_model models/allsides/allsides_centrist_classifier -batch_size 8 -gpu 0

python classifier/cnn_translate.py \
 -model models/allsides/allsides_centrist_classifier_acc_64.00_loss_0.08_e13.pt \
 -src data/allsides/allsides_centrist_classifier.test.centrist_only.en \
 -tgt 'centrist' -label0 biased -label1 centrist
# Accuracy:  64.28571428571429


python classifier/cnn_translate.py  \
 -model models/allsides/allsides_centrist_classifier_acc_64.00_loss_0.08_e13.pt \
 -src data/allsides/allsides_centrist_classifier.test.biased_only.en \
 -tgt 'biased' -label0 biased -label1 centrist
# Accuracy:  68.96551724137932
