rm data/allsides/republican-democratic-trained.txt
rm data/allsides/democratic-republican-trained.txt

python style_decoder/translate.py \
 -encoder_model models/translation/french_english/french_english.pt \
 -decoder_model models/style_generators/democratic_generator.pt \
 -src data/allsides/republican.fr \
 -output data/allsides/republican-democratic-pretrained.txt \
 -replace_unk -gpu 0

python style_decoder/translate.py \
 -encoder_model models/translation/french_english/french_english.pt \
 -decoder_model models/style_generators/republican_generator.pt \
 -src data/allsides/democratic.fr \
 -output data/allsides/democratic-republican-pretrained.txt \
 -replace_unk -gpu 0

python classifier/cnn_translate.py \
 -model models/classifier/political_classifier/political_classifier.pt \
 -src data/allsides/republican-democratic-pretrained.txt \
 -tgt 'democratic' -label0 republican -label1 democratic \
 -gpu 0

python classifier/cnn_translate.py \
 -model models/classifier/political_classifier/political_classifier.pt \
 -src data/allsides/democratic-republican-pretrained.txt \
 -tgt 'republican' -label0 republican -label1 democratic \
 -gpu 0


