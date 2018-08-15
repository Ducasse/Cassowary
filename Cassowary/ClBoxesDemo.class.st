"
self new openInWorld
"
Class {
	#name : #ClBoxesDemo,
	#superclass : #ClDemoWindow,
	#instVars : [
		'p1',
		'p2',
		'p3',
		'p4',
		'p5'
	],
	#category : #'Cassowary-Demo'
}

{ #category : #enumerating }
ClBoxesDemo >> constraintPointsDo: aBlock [

	aBlock value: p1.
	aBlock value: p2.
	aBlock value: p3.
	aBlock value: p4.
	aBlock value: p5
]

{ #category : #drawing }
ClBoxesDemo >> drawForegroundOn: aCanvas [
	| colors index |

	colors := Color wheel: 5.
	index := 1.

	self constraintPointsDo: [:each | | col |
		col := (colors at: index) lighter lighter.
		index := index + 1.
		aCanvas 
			fillRectangle: ((-20@ -20 corner: 20@20) translateBy: each valuePoint + self position)
			color: col]

]

{ #category : #defaults }
ClBoxesDemo >> initialExtent [

	^ 600@300
]

{ #category : #initialization }
ClBoxesDemo >> initialize [

	super initialize.
	p1 := (ClVariable newWith: 50.0) @ (ClVariable newWith: 200.0).
	p2 := (ClVariable newWith: 100.0) @ (ClVariable newWith: 200.0).
	p3 := (ClVariable newWith: 150.0) @ (ClVariable newWith: 200.0).
	p4 := (ClVariable newWith: 200.0) @ (ClVariable newWith: 200.0).
	p5 := (ClVariable newWith: 250.0) @ (ClVariable newWith: 200.0).

	p1 x name: 'p1x'.
	p1 y name: 'p1y'.
	p2 x name: 'p2x'.
	p2 y name: 'p2y'.
	p3 x name: 'p3x'.
	p3 y name: 'p3y'.
	p4 x name: 'p4x'.
	p4 y name: 'p4y'.
	p5 x name: 'p5x'.
	p5 y name: 'p5y'.

	cs addStay: p1 x.
	cs addStay: p2 x.
	cs addStay: p3 x.
	cs addStay: p4 x.
	cs addStay: p5 x.

	cs addStay: p1 y strength: ClStrength required.
	cs addStay: p2 y strength: ClStrength required.
	cs addStay: p3 y strength: ClStrength required.
	cs addStay: p4 y strength: ClStrength required.
	cs addStay: p5 y strength: ClStrength required.

	cs addConstraint: (p1 x cnGEQ: 24.0).
	cs addConstraint: (p5 x cnLEQ: 576.0).

	cs addConstraint: (p1 x + 44.0 cnLEQ: p2 x).
	cs addConstraint: (p2 x + 44.0 cnLEQ: p3 x).
	cs addConstraint: (p3 x + 44.0 cnLEQ: p4 x).
	cs addConstraint: (p4 x + 44.0 cnLEQ: p5 x).
]

{ #category : #copying }
ClBoxesDemo >> veryDeepFixupWith: deepCopier [
	"If some fields were weakly copied, fix new copy here."

	super veryDeepFixupWith: deepCopier.
	p1 := self fixupPoint: p1 with: deepCopier.
	p2 := self fixupPoint: p2 with: deepCopier.
	p3 := self fixupPoint: p3 with: deepCopier.
	p4 := self fixupPoint: p4 with: deepCopier.
	p5 := self fixupPoint: p5 with: deepCopier.

]
