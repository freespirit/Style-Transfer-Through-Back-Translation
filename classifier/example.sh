
# Preprocess data
## Note: First create a dev.txt file such that
## 1. Each instance is on a new line
## 2. The label and the sentence are separated by a space
python preprocess.py -train_src ../data/political_data/classtrain.txt -label0 republican -label1 democratic -valid_src ../data/political_data/dev.txt -save_data political -src_vocab_size 20000

# Train the classifier
python cnn_train.py -data political.train.pt -save_model political_model

# Test the classifier accuracy
python cnn_translate.py -model ../models/classifier/political_classifier/political_classifier.pt -src ../data/political_data/democratic_only.test.en -tgt 'democratic' -label0 republican -label1 democratic

python cnn_translate.py -gpu 0 -model ../models/classifier/political_classifier/political_classifier.pt -src ../style_decoder/trained_models/republican_democratic.txt -tgt 'democratic' -label0 republican -label1 democratic
python cnn_translate.py -gpu 0 -model ../models/classifier/political_classifier/political_classifier.pt -src ../style_decoder/trained_models/democratic_republican.txt -tgt 'republican' -label0 republican -label1 democratic
