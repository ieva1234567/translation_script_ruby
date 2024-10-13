Script for creating translations for react 18next. 

Usage: run 'ruby "final_script.rb"' in terminal or 'load "final_script.eb"' in irb or rails console.

Short explanation and use cases :
For example main language (lt) has more keys than translation file in en. Translated keys which was missing in en is added after running script. 
If only this needs to be done it can be done calling TranslateMissingKeys class instance process method with appropriate parameters.
Data can be taken from REST endpoint and added to main language and desired for translation files.

Back log:
1. Leaving special symbols in translation values f.e.:'"'
2. Leaving HTML stuff in strings "untouched"
3. Creating translation files for "show" views with specified data from endpoint

