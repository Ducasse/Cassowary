"
self new openInWorld
"
Class {
	#name : #ClCrossedQuadDemo,
	#superclass : #ClDemoWindow,
	#instVars : [
		'p1',
		'p2',
		'p3',
		'p4',
		'm1',
		'm2',
		'm3',
		'm4',
		'center'
	],
	#category : #'Cassowary-Demo'
}

{ #category : #initialization }
ClCrossedQuadDemo >> addAdditionalConstraints [
	"no additional constraints for this version"
]

{ #category : #enumerating }
ClCrossedQuadDemo >> constraintPointsDo: aBlock [

	aBlock value: p1.
	aBlock value: p2.
	aBlock value: p3.
	aBlock value: p4.

	aBlock value: m1.
	aBlock value: m2.
	aBlock value: m3.
	aBlock value: m4.

	aBlock value: center
]

{ #category : #drawing }
ClCrossedQuadDemo >> drawForegroundOn: aCanvas [
	| begin end |

	"Draw the four sides of the quadrilateral."
"	begin := {p1. p2. p3. p4} collect: [:p | p valuePoint + self position].
	end := {p2. p3. p4. p1} collect: [:p | p valuePoint + self position].
	begin with: end do: [:b :e |
		aCanvas line: b to: e width: 3 color: Color white]."

	aCanvas 
		drawPolygon: ({p1. p2. p3. p4} collect: [:p | p valuePoint + self position])
		color: Color transparent
		borderWidth: 3
		borderColor: Color white.

	"Draw the lines between the midpoints."
	begin := {m1. m2. m3. m4} collect: [:m | m valuePoint + self position].
	end := {m2. m3. m4. m1} collect: [:m | m valuePoint + self position].
	begin with: end do: [:b :e |
		aCanvas line: b to: e width: 2 color: Color yellow].

	"Draw the cross lines"
	aCanvas line: begin first to: begin third width: 2 color: Color red.
	aCanvas line: begin second to: begin fourth width: 2 color: Color red.

	
]

{ #category : #initialization }
ClCrossedQuadDemo >> initialize [

	super initialize.
	p1 := (ClVariable newWith: 110.0) @ (ClVariable newWith: 10.0).
	p2 := (ClVariable newWith: 210.0) @ (ClVariable newWith: 110.0).
	p3 := (ClVariable newWith: 110.0) @ (ClVariable newWith: 210.0).
	p4 := (ClVariable newWith: 10.0) @ (ClVariable newWith: 110.0).

	m1 := (ClVariable newWith: 160.0) @ (ClVariable newWith: 60.0).
	m2 := (ClVariable newWith: 160.0) @ (ClVariable newWith: 160.0).
	m3 := (ClVariable newWith: 60.0) @ (ClVariable newWith: 160.0).
	m4 := (ClVariable newWith: 60.0) @ (ClVariable newWith: 60.0).

	center := (ClVariable newWith: 110.0) @ (ClVariable newWith: 110.0).

	p1 x name: 'p1x'.
	p1 y name: 'p1y'.
	p2 x name: 'p2x'.
	p2 y name: 'p2y'.
	p3 x name: 'p3x'.
	p3 y name: 'p3y'.
	p4 x name: 'p4x'.
	p4 y name: 'p4y'.

	m1 x name: 'm1x'.
	m1 y name: 'm1y'.
	m2 x name: 'm2x'.
	m2 y name: 'm2y'.
	m3 x name: 'm3x'.
	m3 y name: 'm3y'.
	m4 x name: 'm4x'.
	m4 y name: 'm4y'.

	center x name: 'cx'.
	center y name: 'cy'.

	"add stays on the corner points"
	cs addPointStays: (Array with: p1 with: p2 with: p3 with: p4).

	"set up the midpoint constraints"
	cs addConstraint: (p1 x + p2 x cnEqual: m1 x * 2.0).
	cs addConstraint: (p2 x + p3 x cnEqual: m2 x * 2.0).
	cs addConstraint: (p3 x + p4 x cnEqual: m3 x * 2.0).
	cs addConstraint: (p4 x + p1 x cnEqual: m4 x * 2.0).
	cs addConstraint: (p1 y + p2 y cnEqual: m1 y * 2.0).
	cs addConstraint: (p2 y + p3 y cnEqual: m2 y * 2.0).
	cs addConstraint: (p3 y + p4 y cnEqual: m3 y * 2.0).
	cs addConstraint: (p4 y + p1 y cnEqual: m4 y * 2.0).

	"set up the centerpoint constraints"
	cs addConstraint: (m1 x + m3 x cnEqual: center x * 2.0).
	cs addConstraint: (m1 y + m3 y cnEqual: center y * 2.0).
	cs addConstraint: (m2 x + m4 x cnEqual: center x * 2.0).
	cs addConstraint: (m2 y + m4 y cnEqual: center y * 2.0).

	self addAdditionalConstraints.
]

{ #category : #copying }
ClCrossedQuadDemo >> veryDeepFixupWith: deepCopier [
	"If some fields were weakly copied, fix new copy here."

	super veryDeepFixupWith: deepCopier.
	p1 := self fixupPoint: p1 with: deepCopier.
	p2 := self fixupPoint: p2 with: deepCopier.
	p3 := self fixupPoint: p3 with: deepCopier.
	p4 := self fixupPoint: p4 with: deepCopier.
	m1 := self fixupPoint: m1 with: deepCopier.
	m2 := self fixupPoint: m2 with: deepCopier.
	m3 := self fixupPoint: m3 with: deepCopier.
	m4 := self fixupPoint: m4 with: deepCopier.
	center := self fixupPoint: center with: deepCopier.
]
