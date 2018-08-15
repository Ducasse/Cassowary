"
To see a demo 

	self new openInWorld
"
Class {
	#name : #ClBoundedLineDemo,
	#superclass : #ClDemoWindow,
	#instVars : [
		'p1',
		'p2'
	],
	#category : #'Cassowary-Demo'
}

{ #category : #enumerating }
ClBoundedLineDemo >> constraintPointsDo: aBlock [

	aBlock value: p1.
	aBlock value: p2
]

{ #category : #drawing }
ClBoundedLineDemo >> drawForegroundOn: aCanvas [

	aCanvas 
		line: p1 valuePoint + self position 
		to: p2 valuePoint + self position
		width: 2
		color: Color white

]

{ #category : #initialization }
ClBoundedLineDemo >> initialize [

	| offset box left right top bottom |

	super initialize.
	p1 := (ClVariable newWith: 10.0 name: 'p1x') @ (ClVariable newWith: 20.0 name: 'p1y').
	p2 := (ClVariable newWith: 110.0 name: 'p2x') @ (ClVariable newWith: 220.0 name: 'p2y').

	offset := 10.0.
	box := 0 @ 0 corner: 300 @ 300.
	left := box origin x asFloat + offset.
	right := box corner x asFloat - offset.
	top := box origin y asFloat + offset.
	bottom := box corner y asFloat - offset.

	cs addStay: p1 x.
	cs addStay: p1 y.
	cs addStay: p2 x.
	cs addStay: p2 y.

	cs addConstraint: (p1 x cnGEQ: left).  cs addConstraint: (p1 x cnLEQ: right).
	cs addConstraint: (p1 y cnGEQ: top).  cs addConstraint: (p1 y cnLEQ: bottom).
	cs addConstraint: (p2 x cnGEQ: left).  cs addConstraint: (p2 x cnLEQ: right).
	cs addConstraint: (p2 y cnGEQ: top).  cs addConstraint: (p2 y cnLEQ: bottom).
]

{ #category : #copying }
ClBoundedLineDemo >> veryDeepFixupWith: deepCopier [
	"If some fields were weakly copied, fix new copy here."

	super veryDeepFixupWith: deepCopier.
	p1 := self fixupPoint: p1 with: deepCopier.
	p2 := self fixupPoint: p2 with: deepCopier.
	
]
