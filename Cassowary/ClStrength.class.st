Class {
	#name : #ClStrength,
	#superclass : #Object,
	#instVars : [
		'name',
		'symbolicWeight'
	],
	#classVars : [
		'MediumStrength',
		'RequiredStrength',
		'StrongStrength',
		'WeakStrength'
	],
	#category : #'Cassowary-Kernel'
}

{ #category : #'class initialization' }
ClStrength class >> initialize [
	"Initialize the class variables to the pre-defined strengths."

	| s m w |

	RequiredStrength := self new.  
	RequiredStrength name: 'required'.

	s := ClSymbolicWeight new.  
	s at: 1 put: 1.0.  
	s at: 2 put: 0.0.  
	s at: 3 put: 0.0.
	StrongStrength := self new.
	StrongStrength 
		name: 'strong'; 
		symbolicWeight: s.

	m := ClSymbolicWeight new.  
	m at: 1 put: 0.0.  
	m at: 2 put: 1.0.  
	m at: 3 put: 0.0.
	MediumStrength := self new.
	MediumStrength 
		name: 'medium'; 
		symbolicWeight: m.

	w := ClSymbolicWeight new.  
	w at: 1 put: 0.0.  
	w at: 2 put: 0.0.  
	w at: 3 put: 1.0.

	WeakStrength := self new.
	WeakStrength 
		name: 'weak'; 
		symbolicWeight: w.
]

{ #category : #strengths }
ClStrength class >> medium [

	^ MediumStrength 
]

{ #category : #strengths }
ClStrength class >> nLevels [
	"Answer the number of non-required strengths."

	^ 3
]

{ #category : #strengths }
ClStrength class >> required [

	^ RequiredStrength 
]

{ #category : #strengths }
ClStrength class >> strengthsDo: block [
	"Evaluate the block for each defined strength, strongest to weakest.

	block	<Block value: ClStrength>"

	block
		value: RequiredStrength;
		value: StrongStrength;
		value: MediumStrength;
		value: WeakStrength
]

{ #category : #strengths }
ClStrength class >> strong [

	^ StrongStrength 
]

{ #category : #strengths }
ClStrength class >> weak [

	^ WeakStrength 
]

{ #category : #testing }
ClStrength >> isRequired [

	^ self == RequiredStrength
]

{ #category : #private }
ClStrength >> name [

	^ name
]

{ #category : #private }
ClStrength >> name: aString [

	name := aString
]

{ #category : #printing }
ClStrength >> printOn: aStream [

	aStream nextPutAll: self name
]

{ #category : #accessing }
ClStrength >> symbolicWeight [

	^ symbolicWeight
]

{ #category : #private }
ClStrength >> symbolicWeight: weight [

	symbolicWeight := weight
]
