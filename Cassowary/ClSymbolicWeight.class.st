Class {
	#name : #ClSymbolicWeight,
	#superclass : #Object,
	#type : #variable,
	#classVars : [
		'Zero'
	],
	#category : #'Cassowary-Kernel'
}

{ #category : #'class initialization' }
ClSymbolicWeight class >> initialize [
	"Initialize the class variables to the pre-defined strengths."

	Zero := self new.
	1 to: Zero size do: [:i | Zero at: i put: 0.0]
]

{ #category : #'instance creation' }
ClSymbolicWeight class >> new [

	^ self basicNew: ClStrength nLevels
]

{ #category : #accessing }
ClSymbolicWeight class >> zero [

	^ Zero
]

{ #category : #operations }
ClSymbolicWeight >> * n [
	"Multiply this symbolic weight by n (n should be a number)"
	
	| result |
	self checkArgumentIsNumber: n.
	result := self class new.
	1 to: self size do: [:i | result at: i put: n*(self at: i)].
	^ result
]

{ #category : #operations }
ClSymbolicWeight >> + n [
	"Add this symbolic weight to n (which must also be a symbolic weight)"

	| result |
	self checkArgumentIsSymbolicWeight: n.
	result := self class new.
	1 to: self size do: [ :i | result at: i put: (self at: i) + (n at: i) ].
	^ result
]

{ #category : #operations }
ClSymbolicWeight >> - n [
	"Subtract n from this symbolic weight (n must also be a symbolic weight)"

	| result |
	self checkArgumentIsSymbolicWeight: n.
	result := self class new.
	1 to: self size do: [ :i | result at: i put: (self at: i) - (n at: i) ].
	^ result
]

{ #category : #operations }
ClSymbolicWeight >> / n [
	"Divide this symbolic weight by n (n should be a number)"

	| result |
	self checkArgumentIsNumber: n.
	result := self class new.
	1 to: self size do: [ :i | result at: i put: (self at: i) / n ].
	^ result
]

{ #category : #comparing }
ClSymbolicWeight >> < n [
	| a b |
	self checkArgumentIsSymbolicWeight: n.
	1 to: self size do: [ :i | 
		a := self at: i.
		b := n at: i.
		a < b
			ifTrue: [ ^ true ].
		a > b
			ifTrue: [ "they're equal ... keep going" ^ false ] ].
	"all elements were equal"
	^ false
]

{ #category : #comparing }
ClSymbolicWeight >> <= n [
	| a b |
	self checkArgumentIsSymbolicWeight: n.
	1 to: self size do: [ :i | 
		a := self at: i.
		b := n at: i.
		a < b
			ifTrue: [ ^ true ].
		a > b
			ifTrue: [ "they're equal ... keep going" ^ false ] ].
	"all elements were equal"
	^ true
]

{ #category : #comparing }
ClSymbolicWeight >> = n [

	n isSymbolicWeight ifFalse: [^false].
	1 to: self size do: [:i | 
		(self at: i) = (n at: i) ifFalse: [^false]].
	"all elements were equal"
	^ true
]

{ #category : #comparing }
ClSymbolicWeight >> > n [

	^ (self <= n) not

]

{ #category : #comparing }
ClSymbolicWeight >> >= n [

	^ (self < n) not

]

{ #category : #'internal validation' }
ClSymbolicWeight >> checkArgumentIsNumber: n [
	n isNumber
		ifFalse: [ ClInternalError signal: 'Argument should be a number' ]
]

{ #category : #'internal validation' }
ClSymbolicWeight >> checkArgumentIsSymbolicWeight: n [
	n isSymbolicWeight
		ifFalse: [ ClInternalError signal: 'Argument should be a symbolic weight' ]
]

{ #category : #operations }
ClSymbolicWeight >> clApprox: s [
	"Answer true if this symbolic weight is approximately equal to s.  The argument s must be another symbolic weight -- we can't compare symbolic weights with ordinary numbers."

	self checkArgumentIsSymbolicWeight: s.
	1 to: self size do: [:i | 
		((self at: i) clApprox: (s at: i)) ifFalse: [^ false]].
	^ true
]

{ #category : #operations }
ClSymbolicWeight >> clApproxZero [
	"Answer true if this symbolic weight is approximately zero"

	^ self clApprox: Zero
]

{ #category : #operations }
ClSymbolicWeight >> definitelyNegative [
	"return true if this symbolic weight is negative.  Allow coefficients that are within epsilon of 0 to count as 0"
	
	| a epsilon nepsilon |
	epsilon := ClSimplexSolver epsilon.
	nepsilon := 0.0 - epsilon.
	1 to: self size do: [:i | 
		a := self at: i.  
		a < nepsilon ifTrue: [ ^ true ].
		a > epsilon ifTrue: [ ^ false ] ].
	^ false

]

{ #category : #testing }
ClSymbolicWeight >> isSymbolicWeight [

	^ true
]

{ #category : #printing }
ClSymbolicWeight >> printOn: aStream [

	aStream nextPutAll: '['.
	(self at: 1) printOn: aStream.
	2 to: self size do: [:i | aStream nextPutAll: ','.  (self at: i) printOn: aStream].
	aStream nextPutAll: ']'
]
