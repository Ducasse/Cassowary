"
self new openInWorld
"
Class {
	#name : #ClQuadDemo,
	#superclass : #ClDemoWindow,
	#instVars : [
		'p1',
		'p2',
		'p3',
		'p4',
		'm1',
		'm2',
		'm3',
		'm4'
	],
	#category : #'Cassowary-Demo'
}

{ #category : #initialization }
ClQuadDemo >> addAdditionalConstraints [
	"no additional constraints for this version"
]

{ #category : #enumerating }
ClQuadDemo >> constraintPointsDo: aBlock [

	aBlock value: p1.
	aBlock value: p2.
	aBlock value: p3.
	aBlock value: p4.

	aBlock value: m1.
	aBlock value: m2.
	aBlock value: m3.
	aBlock value: m4
]

{ #category : #drawing }
ClQuadDemo >> drawForegroundOn: aCanvas [
	| begin end |

	"Draw the four sides of the quadrilateral."
	begin := {p1. p2. p3. p4} collect: [:p | p valuePoint + self position].
	end := {p2. p3. p4. p1} collect: [:p | p valuePoint + self position].
	begin with: end do: [:b :e |
		aCanvas line: b to: e width: 3 color: Color white].

	"Draw the lines between the midpoints."
	begin := {m1. m2. m3. m4} collect: [:m | m valuePoint + self position].
	end := {m2. m3. m4. m1} collect: [:m | m valuePoint + self position].
	begin with: end do: [:b :e |
		aCanvas line: b to: e width: 2 color: Color yellow].

]

{ #category : #initialization }
ClQuadDemo >> initialize [

	super initialize.
	p1 := (ClVariable newWith: 110.0) @ (ClVariable newWith: 10.0).
	p2 := (ClVariable newWith: 210.0) @ (ClVariable newWith: 110.0).
	p3 := (ClVariable newWith: 110.0) @ (ClVariable newWith: 210.0).
	p4 := (ClVariable newWith: 10.0) @ (ClVariable newWith: 110.0).

	m1 := (ClVariable newWith: 160.0) @ (ClVariable newWith: 60.0).
	m2 := (ClVariable newWith: 160.0) @ (ClVariable newWith: 160.0).
	m3 := (ClVariable newWith: 60.0) @ (ClVariable newWith: 160.0).
	m4 := (ClVariable newWith: 60.0) @ (ClVariable newWith: 60.0).

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

	self addAdditionalConstraints.
]

{ #category : #copying }
ClQuadDemo >> veryDeepFixupWith: deepCopier [
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

]
