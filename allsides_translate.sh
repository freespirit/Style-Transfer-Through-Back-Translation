#!/bin/bash

source backtranslate_env/bin/activate

translate() {
	echo Translating $1 ...
	rm $2
	python style_decoder/translate.py \
	 -model models/translation/english_french/english_french.pt \
	 -src $1 \
	 -output $2 \
	 -gpu 0 -replace_unk $true
}

#translate data/allsides/democratic.dev.en data/allsides/democratic.dev.fr
#translate data/allsides/democratic.test.en data/allsides/democratic.test.fr
#translate data/allsides/democratic.train.en data/allsides/democratic.train.fr
#translate data/allsides/republican.dev.en data/allsides/republican.dev.fr
#translate data/allsides/republican.test.en data/allsides/republican.test.fr
#translate data/allsides/republican.train.en data/allsides/republican.train.fr

translate data/allsides/democratic.en data/allsides/democratic.fr
translate data/allsides/republican.en data/allsides/republican.fr
#translate data/allsides/centrist.en data/allsides/centrist.fr