Class {
	#name : #ClAbstractVariable,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'Cassowary-Kernel'
}

{ #category : #'instance creation' }
ClAbstractVariable class >> newNamed: aString [

	^ self new
			name: aString;
			yourself
]

{ #category : #testing }
ClAbstractVariable >> isDummy [
	"Answer true if this is a dummy variable (used as a marker variable for required equality constraints).  Such variables aren't allowed to enter the basis when pivoting."

	^ false
]

{ #category : #testing }
ClAbstractVariable >> isExternal [
	"Answer true if this is a variable known outside the solver. (We need to give such variables a value after solving is complete.)"

	self subclassResponsibility
]

{ #category : #testing }
ClAbstractVariable >> isPivotable [
	"Answer true if we can pivot on this variable"

	self subclassResponsibility 
]

{ #category : #testing }
ClAbstractVariable >> isRestricted [
	"Answer true if this is a restricted (or slack) variable.  Such variables are constrained to be non-negative, and occur only internally to the simplex solver."

	self subclassResponsibility 
]

{ #category : #accessing }
ClAbstractVariable >> name [
	"Answers <String> | nil"

	^ name
]

{ #category : #accessing }
ClAbstractVariable >> name: aString [

	name := aString
]

{ #category : #printing }
ClAbstractVariable >> printOn: aStream [
	"Prints a semi-descriptive representation to the stream, using the name if there is one, and otherwise the hash number of this object.

	Examples:
		x[10.0]			- with name
		x[0.0, 100]		- with name/bounds, but no value yet
		CV#345(10.0)	- without name"

	self name 
		ifNil: [aStream nextPutAll: 'CV#', self hash printString]
		ifNotNil: [aStream nextPutAll: self name].
]
