Class {
	#name : #ClVariable,
	#superclass : #ClAbstractVariable,
	#instVars : [
		'value'
	],
	#category : #'Cassowary-Kernel'
}

{ #category : #'instance creation' }
ClVariable class >> newWith: anObject [
	"Create a new variable with anObject as its initial value."

	^ self new
		value: anObject;
		yourself
]

{ #category : #'instance creation' }
ClVariable class >> newWith: anObject name: nameString [
	"Create a new variable with anObject as its initial value and name nameString."

	^ self new
		value: anObject;
		name: nameString;
		yourself
]

{ #category : #operations }
ClVariable >> * expr [

	^ self asLinearExpression * expr
]

{ #category : #operations }
ClVariable >> + expr [

	^ self asLinearExpression + expr
]

{ #category : #operations }
ClVariable >> - expr [

	^ self asLinearExpression - expr
]

{ #category : #operations }
ClVariable >> / expr [

	^ self asLinearExpression / expr
]

{ #category : #operations }
ClVariable >> @ anObject [
	"A convenience method for creating point pairs of constrainable variables.  Mostly used in graphic constraints where the x and y dimensions are constrained separately."

	^ Point x: self y: anObject
]

{ #category : #conversion }
ClVariable >> asLinearExpression [
	"Coerce this variable to be a linear expression.
	<answer> 	<ClLinearExpression>"
	
	| expr |
	expr := ClLinearExpression new.
	expr terms at: self put: 1.0.
	^ expr
]

{ #category : #operations }
ClVariable >> cnEqual: expr [
	"Answer a linear constraint self=expr with strength=required and weight=1.
	expr 		<ClLinearExpression | ClVariable | Number>
	<answer>	<ClLinearEquation>"

	^ self cnEqual: expr strength: self requiredStrength weight: 1.0
]

{ #category : #operations }
ClVariable >> cnEqual: expr strength: s [
	"Answer a linear constraint self=expr of strength s and weight=1.
	expr 		<ClLinearExpression | ClVariable | Number>
	s 			<ClStrength>
	<answer>	<ClLinearEquation>"

	^ self cnEqual: expr strength: s weight: 1.0
]

{ #category : #operations }
ClVariable >> cnEqual: expr strength: s weight: w [
	"Answer a linear constraint self=expr of strength s and weight w.
	expr 		<ClLinearExpression | ClVariable | Number>
	s 			<ClStrength>
	w 			<Float>
	<answer>	<ClLinearEquation>"

	| cn |
	cn := ClLinearEquation new.
	cn 
		expression: self - expr; 
		strength: s; 
		weight: w.
	^ cn
]

{ #category : #operations }
ClVariable >> cnGEQ: expr [
	"Answer a linear constraint self>=expr with strength=required and weight=1.
	expr 		<ClLinearExpression | ClVariable | Number>
	<answer>	<ClLinearInequality>"

	^ self cnGEQ: expr strength: self requiredStrength weight: 1.0
]

{ #category : #operations }
ClVariable >> cnGEQ: expr strength: s [
	"Answer a linear constraint self>=expr of strength s and weight=1.
	expr 		<ClLinearExpression | ClVariable | Number>
	s 			<ClStrength>
	<answer>	<ClLinearInequality>"

	^ self cnGEQ: expr strength: s weight: 1.0
]

{ #category : #operations }
ClVariable >> cnGEQ: expr strength: s weight: w [
	"Answer a linear constraint self>=expr of strength s and weight w.

	expr 		<ClLinearExpression | ClVariable | Number>
	s 			<ClStrength>
	w 			<Float>
	<answer>	<ClLinearEquation>"
	
	| cn |
	cn := ClLinearInequality new.
	cn 
		expression: self - expr; 
		strength: s; 
		weight: w.
	^ cn
]

{ #category : #operations }
ClVariable >> cnLEQ: expr [
	"Answer a linear constraint self<=expr with strength=required and weight=1.
	expr 		<ClLinearExpression | ClVariable | Number>
	<answer>	<ClLinearInequality>"

	^ self cnLEQ: expr strength: self requiredStrength weight: 1.0
]

{ #category : #operations }
ClVariable >> cnLEQ: expr strength: s [
	"Answer a linear constraint self<=expr of strength s and weight 1.

	expr 		<ClLinearExpression | ClVariable | Number>
	s 			<ClStrength>
	<answer>	<ClLinearInequality>"

	^ self cnLEQ: expr strength: s weight: 1.0
]

{ #category : #operations }
ClVariable >> cnLEQ: expr strength: s weight: w [
	"Answer a linear constraint self <= expr of strength s and weight w.
	expr 		<ClLinearExpression | ClVariable | Number>
	s 			<ClStrength>
	w 			<Float>
	<answer>	<ClLinearEquation>"

	| cn |
	cn := ClLinearInequality new.
	cn 
		expression: expr asLinearExpression - self asLinearExpression; 
		strength: s; 
		weight: w.
	^ cn
]

{ #category : #operations }
ClVariable >> divFrom: aNumber [
	"We should return a new linear expression (aNumber/self) -- but since the result must be linear, this is always an error."

	ClNonLinearError signal: 'We should return a new linear expression (aNumber/self) -- but since the result must be linear, this is always an error.'
]

{ #category : #testing }
ClVariable >> isExternal [
	"Answer true if this a variable known outside the solver.  (We need to give such variables a value after solving is complete.)"

	^ true
]

{ #category : #testing }
ClVariable >> isPivotable [
	"Answer true if we can pivot on this variable."

	^ false
]

{ #category : #testing }
ClVariable >> isRestricted [
	"Answer true if this is a restricted (or slack) variable.  Such variables are constrained to be non-negative and occur only internally to the simplex solver."

	^ false
]

{ #category : #operations }
ClVariable >> negated [

	^ -1.0 * self
]

{ #category : #printing }
ClVariable >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: '['.  self value printOn: aStream.  aStream nextPutAll: ']'
]

{ #category : #constants }
ClVariable >> requiredStrength [
	^ ClStrength required
]

{ #category : #operations }
ClVariable >> subtractFrom: aNumber [
	"Answer a new linear expression (aNumber - self).
	<answer> <ClLinearExpression>"

	^ self negated + aNumber
]

{ #category : #accessing }
ClVariable >> value [
	"Answer the current value, aNumber, I hold."

	^ value 
]

{ #category : #accessing }
ClVariable >> value: aNumber [

	value := aNumber
]
