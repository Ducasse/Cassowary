"
self new openInWorld
"
Class {
	#name : #ClLineDemo,
	#superclass : #ClDemoWindow,
	#instVars : [
		'p1',
		'p2'
	],
	#category : #'Cassowary-Demo'
}

{ #category : #'as yet unclassified' }
ClLineDemo >> constraintPointsDo: aBlock [

	aBlock value: p1.
	aBlock value: p2
]

{ #category : #'as yet unclassified' }
ClLineDemo >> drawForegroundOn: aCanvas [

	aCanvas 
		line: p1 valuePoint + self position 
		to: p2 valuePoint + self position
		width: 2
		color: Color white

]

{ #category : #'as yet unclassified' }
ClLineDemo >> initialize [

	super initialize.
	p1 := (ClVariable newWith: 10.0 name: 'p1x') @ (ClVariable newWith: 20.0 name: 'p1y').
	p2 := (ClVariable newWith: 110.0 name: 'p2x') @ (ClVariable newWith: 220.0 name: 'p2y').
	cs addStay: p1 x.
	cs addStay: p1 y.
	cs addStay: p2 x.
	cs addStay: p2 y.
]

{ #category : #copying }
ClLineDemo >> veryDeepFixupWith: deepCopier [
	"If some fields were weakly copied, fix new copy here."

	super veryDeepFixupWith: deepCopier.
	p1 := self fixupPoint: p1 with: deepCopier.
	p2 := self fixupPoint: p2 with: deepCopier.

]
