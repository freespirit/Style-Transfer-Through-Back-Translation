#!/bin/bash
  
python style_decoder/preprocess.py \
 -train_src data/allsides/biased.train.fr -train_tgt data/allsides/biased.train.en \
 -valid_src data/allsides/biased.dev.fr -valid_tgt data/allsides/biased.dev.en \
 -save_data data/allsides/biased_generator \
 -src_vocab models/translation/french_english/french_english_vocab.src.dict \
 -tgt_vocab political_centrist.src.dict \
 -seq_len 50

 python style_decoder/preprocess.py \
 -train_src data/allsides/centrist.train.fr -train_tgt data/allsides/centrist.train.en \
 -valid_src data/allsides/centrist.dev.fr -valid_tgt data/allsides/centrist.dev.en \
 -save_data data/allsides/centrist_generator \
 -src_vocab models/translation/french_english/french_english_vocab.src.dict \
 -tgt_vocab political_centrist.src.dict \
 -seq_len 50

 python style_decoder/train_decoder.py \
 -data data/allsides/centrist_generator.train.pt \
 -save_model models/allsides/centrist_generator \
 -classifier_model models/allsides/allsides_centrist_classifier_acc_64.00_loss_0.08_e13.pt \
 -encoder_model models/translation/french_english/french_english.pt \
 -batch_size 8 -epochs 100 -learning_rate_decay 0.9\
 -tgt_label 1 -gpu 0

 python style_decoder/train_decoder.py \
 -data data/allsides/biased_generator.train.pt \
 -save_model models/allsides/biased_generator \
 -classifier_model models/allsides/allsides_centrist_classifier_acc_64.00_loss_0.08_e13.pt \
 -encoder_model models/translation/french_english/french_english.pt \
 -batch_size 8 -epochs 100 -learning_rate_decay 0.9\
 -tgt_label 0 -gpu 0
