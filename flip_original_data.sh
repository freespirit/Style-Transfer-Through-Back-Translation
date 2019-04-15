python style_decoder/translate.py -encoder_model models/translation/french_english/french_english.pt -decoder_model models/style_generators/democratic_generator.pt -src data/political_data/republican_only.test.fr -output republican-democratic-pretrained-test.txt -replace_unk -gpu 0

python style_decoder/translate.py -encoder_model models/translation/french_english/french_english.pt -decoder_model models/style_generators/republican_generator.pt -src data/political_data/democratic_only.test.fr -output democratic-republican-pretrained-test.txt -replace_unk -gpu 0
