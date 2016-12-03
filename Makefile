all: coffee_tamper.stl

%.stl: %.scad
	openscad -o $*.stl $*.scad
