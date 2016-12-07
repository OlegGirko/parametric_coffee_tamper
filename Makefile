all: coffee_tamper_2cup.stl coffee_tamper_3cup.stl

%.stl: %.scad
	openscad -o $*.stl $*.scad
