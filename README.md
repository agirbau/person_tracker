### Person Tracker ###

* Semi-supervised Person tracker for Matlab (with python wrapper). Providing a person mask (or a bounding box over the desired person) do the tracking. Uses [MNC](https://github.com/daijifeng001/MNC) for person extraction.
* Version 0.1

### Setting up ###

* Clone MNC from https://github.com/daijifeng001/MNC into "./utils"
* *Copy* the following files:
	* funcs/object_proposal.py -> utils/MNC/tools
	* funcs/vis_seq.py -> utils/MNC/lib/utils
* *Move* the following files:
	* funcs/mnc_root -> utils/MNC

### Playing with person tracker ###

* Run install.m
* Enjoy!

### TODO ###

* Add model generation!
* Script to download MNC and move files in it automatically
