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
