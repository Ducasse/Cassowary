Class {
	#name : #ClEditOrStayConstraint,
	#superclass : #ClConstraint,
	#instVars : [
		'variable'
	],
	#category : #'Cassowary-Kernel'
}

{ #category : #'instance creation' }
ClEditOrStayConstraint class >> variable: aVariable strength: aStrength [

	^ self variable: aVariable strength: aStrength weight: 1.0
]

{ #category : #'instance creation' }
ClEditOrStayConstraint class >> variable: aVariable strength: aStrength weight: aFloat [

	^ self new
		variable: aVariable;
		strength: aStrength;
		weight: aFloat;
		yourself
]

{ #category : #accessing }
ClEditOrStayConstraint >> expression [

	| e |
	e := ClLinearExpression new.
	e constant: self variable value.
	e terms at: self variable put: -1.0.
	^ e
]

{ #category : #accessing }
ClEditOrStayConstraint >> variable [

	^ variable
]

{ #category : #private }
ClEditOrStayConstraint >> variable: aVariable [

	variable := aVariable
]
