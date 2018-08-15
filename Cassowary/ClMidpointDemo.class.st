"
self new openInWorld
"
Class {
	#name : #ClMidpointDemo,
	#superclass : #ClDemoWindow,
	#instVars : [
		'p1',
		'p2',
		'm1'
	],
	#category : #'Cassowary-Demo'
}

{ #category : #enumerating }
ClMidpointDemo >> constraintPointsDo: aBlock [

	aBlock value: p1.
	aBlock value: p2.
	aBlock value: m1.
]

{ #category : #drawing }
ClMidpointDemo >> drawForegroundOn: aCanvas [

	aCanvas 
		line: p1 valuePoint + self position
		to: p2 valuePoint + self position
		width: 2
		color: Color white.

	aCanvas 
		line: m1 valuePoint + self position - (0@1)
		to: m1 valuePoint + self position + (0@1)
		width: 2
		color: Color red.
]

{ #category : #initialization }
ClMidpointDemo >> initialize [

	super initialize.
	p1 := (ClVariable newWith: 100.0) @ (ClVariable newWith: 100.0).
	p2 := (ClVariable newWith: 200.0) @ (ClVariable newWith: 100.0).
	m1 := (ClVariable newWith: 150.0) @ (ClVariable newWith: 100.0).

	p1 x name: 'p1x'.
	p1 y name: 'p1y'.
	p2 x name: 'p2x'.
	p2 y name: 'p2y'.
	m1 x name: 'm1x'.
	m1 y name: 'm1y'.

	"add stays on the corner points"
	cs addPointStays: (Array with: p1 with: p2).

	"set up the midpoint constraints"
	cs addConstraint: (p1 x + p2 x cnEqual: m1 x * 2.0).
	cs addConstraint: (p1 y + p2 y cnEqual: m1 y * 2.0).
]

{ #category : #copying }
ClMidpointDemo >> veryDeepFixupWith: deepCopier [
	"If some fields were weakly copied, fix new copy here."

	super veryDeepFixupWith: deepCopier.
	p1 := self fixupPoint: p1 with: deepCopier.
	p2 := self fixupPoint: p2 with: deepCopier.
	m1 := self fixupPoint: m1 with: deepCopier.
]
