#!/bin/bash

rm data/allsides/republican_generator*
rm data/allsides/democratic_generator*

python style_decoder/preprocess.py \
 -train_src data/allsides/democratic.train.fr -train_tgt data/allsides/democratic.train.en \
 -valid_src data/allsides/democratic.dev.fr -valid_tgt data/allsides/democratic.dev.en \
 -save_data data/allsides/democratic_generator \
 -src_vocab models/translation/french_english/french_english_vocab.src.dict \
 -tgt_vocab models/classifier/political_classifier/political_classifier_vocab.src.dict \
 -seq_len 50

python style_decoder/preprocess.py \
-train_src data/allsides/republican.train.fr -train_tgt data/allsides/republican.train.en \
-valid_src data/allsides/republican.dev.fr -valid_tgt data/allsides/republican.dev.en \
-save_data data/allsides/republican_generator \
-src_vocab models/translation/french_english/french_english_vocab.src.dict \
-tgt_vocab models/classifier/political_classifier/political_classifier_vocab.src.dict \
-seq_len 50

python style_decoder/train_decoder.py \
 -data data/allsides/democratic_generator.train.pt \
 -save_model /run/user/1000/gvfs/smb-share:server=192.168.1.1,share=ext_storage/msc/models/allsides/democratic_generator \
 -classifier_model models/classifier/political_classifier/political_classifier.pt \
 -encoder_model models/translation/french_english/french_english.pt \
 -batch_size 8 -epochs 200 -start_decay_at 75 -learning_rate_decay 0.9 -gpu 0\
 -tgt_label 1

python style_decoder/train_decoder.py \
 -data data/allsides/republican_generator.train.pt \
 -save_model /run/user/1000/gvfs/smb-share:server=192.168.1.1,share=ext_storage/msc/models/allsides/republican_generator \
 -classifier_model models/classifier/political_classifier/political_classifier.pt \
 -encoder_model models/translation/french_english/french_english.pt \
 -batch_size 8 -epochs 200 -start_decay_at 75 -learning_rate_decay 0.9 -gpu 0\
 -tgt_label 0


# results (with cleared empty rows after translation):
#     Republican @ epoch 13:
#        Train perplexity: 1.00341
#        Train accuracy: 11.3768
#        Validation perplexity: 14.212
#        Validation accuracy: 12.7872
#     Democratic @ epoch 13:
#        Train perplexity: 1.00387
#        Train accuracy: 7.61076
#        Validation perplexity: 13.139
#        Validation accuracy: 10.6862
#     Evaluation:
#        republican -> democratic -> Accuracy:  52.28915662650602
#        democratic -> republican ->Accuracy:  33.76068376068376

#    Republican @ epoch 13:
#        Train perplexity: 1.00362
#        Train accuracy: 7.31717
#        Validation perplexity: 16.6325
#        Validation accuracy: 8.39161
#    Democratic @ epoch 13:
#        Train perplexity: 1.00384
#        Train accuracy: 9.13636
#        Validation perplexity: 12.7739
#        Validation accuracy: 11.5861
