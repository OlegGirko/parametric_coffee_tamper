all: coffee_tamper_2cup.stl coffee_tamper_3cup.stl coffee_tamper_9cup.stl

%.stl: %.scad
	openscad -o $*.stl $*.scad
