"
a Slack variable is a variable that is used to represent an inequation as an equation. 

for example 
	x <= e
	=> 
	x + s = e where s is >0 and s is a slack variable.  
"
Class {
	#name : #ClSlackVariable,
	#superclass : #ClAbstractVariable,
	#category : #'Cassowary-Kernel'
}

{ #category : #testing }
ClSlackVariable >> isExternal [
	"Answer true if this a variable known outside the solver.  (We need to give such variables a value after solving is complete.)"

	^ false
]

{ #category : #testing }
ClSlackVariable >> isPivotable [
	"Answer true if we can pivot on this variable."

	^ true
]

{ #category : #testing }
ClSlackVariable >> isRestricted [
	"Answer true if this is a restricted (or slack) variable.  Such variables are constrained to be non-negative and occur only internally to the simplex solver."

	^ true
]
