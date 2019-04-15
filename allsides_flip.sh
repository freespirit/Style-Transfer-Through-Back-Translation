#!/usr/bin/env bash

rm data/allsides/republican-democratic-trained.txt
rm data/allsides/democratic-republican-trained.txt

python style_decoder/translate.py \
 -encoder_model models/translation/french_english/french_english.pt \
 -decoder_model /run/user/1000/gvfs/smb-share:server=192.168.1.1,share=ext_storage/msc/models/allsides/democratic_generator_acc_20.02_ppl_7.88_e200.pt \
 -src data/allsides/republican.fr \
 -output data/allsides/republican-democratic-trained.txt \
 -replace_unk -gpu 0

python style_decoder/translate.py \
 -encoder_model models/translation/french_english/french_english.pt \
 -decoder_model /run/user/1000/gvfs/smb-share:server=192.168.1.1,share=ext_storage/msc/models/allsides/republican_generator_acc_20.88_ppl_8.57_e200.pt \
 -src data/allsides/democratic.fr \
 -output data/allsides/democratic-republican-trained.txt \
 -replace_unk -gpu 0


rm data/allsides/biased-centrist-trained.txt
rm data/allsides/centrist-biased-trained.txt

python style_decoder/translate.py \
 -encoder_model models/translation/french_english/french_english.pt \
 -decoder_model models/allsides/centrist_generator_acc_19.85_ppl_7.64_e25.pt \
 -src data/allsides/biased.train.fr \
 -output data/allsides/biased-centrist-trained.txt \
 -replace_unk

python classifier/cnn_translate.py \
 -model models/allsides/allsides_centrist_classifier_acc_68.67_loss_0.09_e13.pt \
 -src data/allsides/biased-centrist-trained.txt \
 -tgt 'centrist' -label0 biased -label1 centrist
 # Accuracy:  84.3103448275862

python style_decoder/translate.py \
 -encoder_model models/translation/french_english/french_english.pt \
 -decoder_model models/allsides/biased_generator_acc_22.52_ppl_8.05_e25.pt \
 -src data/allsides/centrist.train.fr \
 -output data/allsides/centrist-biased-trained.txt \
 -replace_unk

python classifier/cnn_translate.py \
 -model models/allsides/allsides_centrist_classifier_acc_68.67_loss_0.09_e13.pt \
 -src data/allsides/centrist-biased-trained.txt \
 -tgt 'biased' -label0 biased -label1 centrist
 # Accuracy:  96.82539682539682





# Experiment with the pretrained Back-Translation classifier - how would it classify the trained and flipped allsides data

python classifier/cnn_translate.py \
 -model models/classifier/political_classifier/political_classifier.pt \
 -src data/allsides/biased-centrist-trained.txt \
 -tgt 'democratic' -label0 republican -label1 democratic
 # Accuracy:  87.75862068965517

python classifier/cnn_translate.py \
 -model models/classifier/political_classifier/political_classifier.pt \
 -src data/allsides/biased-centrist-trained.txt \
 -tgt 'republican' -label0 republican -label1 democratic
 # Accuracy:  12.241379310344827

 python classifier/cnn_translate.py \
 -model models/classifier/political_classifier/political_classifier.pt \
 -src data/allsides/centrist-biased-trained.txt \
 -tgt 'democratic' -label0 republican -label1 democratic
# Accuracy:  98.41269841269842


python classifier/cnn_translate.py \
 -model models/classifier/political_classifier/political_classifier.pt \
 -src data/allsides/centrist-biased-trained.txt \
 -tgt 'republican' -label0 republican -label1 democratic
 # Accuracy:  1.5873015873015872