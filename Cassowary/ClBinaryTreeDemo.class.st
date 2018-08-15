"
To see a demo of a binary tree of height 3

     (self height: 3) openInWorld


	  self new openInWorld
"
Class {
	#name : #ClBinaryTreeDemo,
	#superclass : #ClDemoWindow,
	#instVars : [
		'nodes',
		'lines',
		'height'
	],
	#category : #'Cassowary-Demo'
}

{ #category : #'instance creation' }
ClBinaryTreeDemo class >> height: h [

	| demo |
	demo := self basicNew.
	demo height: h.
	demo initialize.
	^ demo
]

{ #category : #enumerating }
ClBinaryTreeDemo >> childrenAndParentsDo: aBlock [
	"Evaluate aBlock for all children and parents, starting with leaves and going up the tree."
	| parentcount left right parent |

	height to: 2 by: -1 do: [:h |
		parentcount := 2 raisedTo: h-2.
		1 to: parentcount do: [:i | 
			left := nodes at: (100*h)+(2*i)-1.
			right := nodes at: (100*h)+(2*i).
			parent := nodes at: (100*(h-1))+i.
			aBlock 
				value: left 
				value: right 
				value: parent]]
]

{ #category : #enumerating }
ClBinaryTreeDemo >> constraintPointsDo: aBlock [

	nodes do: [:each | aBlock value: each]
]

{ #category : #initialization }
ClBinaryTreeDemo >> createConstraints [
	| sorted inset spacing winWidth winHeight root |

	"Add stays on each node.  Accumulate the nodes children first, so that the weights on the parents are stronger than those on the children."
	sorted := OrderedCollection new.
	self childrenAndParentsDo: [:lc :rc :p |
		(sorted includes: lc) ifFalse: [sorted add: lc].
		(sorted includes: rc) ifFalse: [sorted add: lc].
		root := p  "we need this at the end"].
	sorted add: root.
	cs addPointStays: sorted.

	inset := self inset.
	spacing := self spacing.
	winWidth := self initialExtent x.
	winHeight := self initialExtent y.
	self childrenAndParentsDo: [:lc :rc :p |
		root := p   "we need the root at the end".

		"children are at equal height"
		cs addConstraint: (lc y cnEqual: rc y).

		"children are below parents"
		cs addConstraint: (p y + spacing cnLEQ: lc y).
		cs addConstraint: (p y + spacing cnLEQ: rc y).

		"parent is centered in the x coordinate between children"
		cs addConstraint: ( (lc x*0.5) + (rc x*0.5) cnEqual: p x).

		"each node lies within the window"
		cs addBounds: lc x lowerBound: inset upperBound: winWidth-inset.
		cs addBounds: rc x lowerBound: inset upperBound: winWidth-inset.
		cs addBounds: lc y lowerBound: inset upperBound: winHeight-inset.
		cs addBounds: rc y lowerBound: inset upperBound: winHeight-inset].
	cs addBounds: root x lowerBound: inset upperBound: winWidth-inset.
	cs addBounds: root y lowerBound: inset upperBound: winHeight-inset.
]

{ #category : #drawing }
ClBinaryTreeDemo >> drawForegroundOn: aCanvas [

	lines do: [:each |
		aCanvas 
			line: each first valuePoint + self position
			to: each second valuePoint + self position
			color: Color white].
	nodes do: [:each |
		aCanvas
			fillRectangle: ((-5@ -5 corner: 5@5) translateBy: each valuePoint + self position)
			color: Color yellow].
]

{ #category : #initialization }
ClBinaryTreeDemo >> height: aNumber [

	height := aNumber
]

{ #category : #defaults }
ClBinaryTreeDemo >> initialExtent [

	^ 500@300
]

{ #category : #initialization }
ClBinaryTreeDemo >> initialize [
	| xspace yspace index nleaves nodecount left right px |
	xspace := 20.  
	yspace := 20.
	height := 4.
	super initialize.
	nodes := Dictionary new.
	
	"create the leaves"
	nleaves := 2 raisedTo: height-1.
	1 to: nleaves do: [:i | index := 100*height + i.  nodes at: index put: 
			((ClVariable newWith: (xspace*i) asFloat name: 'n' , index printString , 'x') @ 
			  (ClVariable newWith: (yspace*height) asFloat name: 'n' , index printString , 'y'))].

	"create the other nodes"
	height-1 to: 1 by: -1 do: [:h |
		nodecount := 2 raisedTo: h-1.
		1 to: nodecount do: [:i | 
			left := nodes at: (100*(h+1))+(2*i)-1.  
			right := nodes at: (100*(h+1))+(2*i).
			px := (left x value + right x value) * 0.5.
			index := 100*h+ i.  nodes at: index put: 
			((ClVariable newWith: px name: 'n' , index printString , 'x') @ 
			  (ClVariable newWith: yspace*h name: 'n' , index printString , 'y'))]].

	lines := OrderedCollection new.
	self childrenAndParentsDo: [:lc :rc :p | 
		lines add: (Array with: p with: lc).
		lines add: (Array with: p with: rc)].

	self createConstraints.
]

{ #category : #defaults }
ClBinaryTreeDemo >> inset [
	
	^ 10.0
]

{ #category : #defaults }
ClBinaryTreeDemo >> spacing [
	
	^ 10.0
]

{ #category : #copying }
ClBinaryTreeDemo >> veryDeepFixupWith: deepCopier [
	"If some fields were weakly copied, fix new copy here."

	super veryDeepFixupWith: deepCopier.

	"nodes is a Dictionary of Points; fix the points"
	nodes keysAndValuesDo: [:key :point |
		nodes at: key put: (self fixupPoint: point with: deepCopier)].
	
	"lines is a Dictionary of Arrays of Points; fix the points"
	lines keysAndValuesDo: [:key :pointArray |
		lines
			at: key
			put: (pointArray collect: [:pt | self fixupPoint: pt with: deepCopier])].
]
