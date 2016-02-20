#!/usr/bin/python

from nltk.corpus import wordnet as wn

for synset in list(wn.all_synsets(wn.ADJ)):
    print synset.lemma_names()[0]