Class {
	#name : #ClObjectiveVariable,
	#superclass : #ClAbstractVariable,
	#category : #'Cassowary-Kernel'
}

{ #category : #testing }
ClObjectiveVariable >> isExternal [
	"Return true if this is a variable known outside the solver. (We need to give such variables a value after solving is complete.)"

	^ false
]

{ #category : #testing }
ClObjectiveVariable >> isPivotable [
	"Answer true if we can pivot on this variable"

	^ false
]

{ #category : #testing }
ClObjectiveVariable >> isRestricted [
	"Answer true if this is a restricted (or slack) variable.  Such variables are constrained to be non-negative and occur only internally to the simplex solver."

	^ false
]
