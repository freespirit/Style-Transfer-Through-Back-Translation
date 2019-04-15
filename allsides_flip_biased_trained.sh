rm data/allsides/biased-centrist-trained.txt
rm data/allsides/centrist-biased-trained.txt

python style_decoder/translate.py \
 -encoder_model models/translation/french_english/french_english.pt \
 -decoder_model models/allsides/centrist_generator_acc_20.88_ppl_7.65_e25.pt \
 -src data/allsides/biased.train.fr \
 -output data/allsides/biased-centrist-trained.txt \
 -replace_unk -gpu 0

 python classifier/cnn_translate.py \
 -model models/allsides/allsides_centrist_classifier_acc_64.00_loss_0.08_e13.pt \
 -src data/allsides/biased-centrist-trained.txt \
 -tgt 'centrist' -label0 biased -label1 centrist
 # Accuracy:  50.91954022988506

python style_decoder/translate.py \
 -encoder_model models/translation/french_english/french_english.pt \
 -decoder_model models/allsides/biased_generator_acc_22.21_ppl_8.09_e25.pt \
 -src data/allsides/centrist.train.fr \
 -output data/allsides/centrist-biased-trained.txt \
 -replace_unk -gpu 0

 python classifier/cnn_translate.py \
 -model models/allsides/allsides_centrist_classifier_acc_64.00_loss_0.08_e13.pt \
 -src data/allsides/centrist-biased-trained.txt \
 -tgt 'biased' -label0 biased -label1 centrist
 # Accuracy:  71.34920634920636
