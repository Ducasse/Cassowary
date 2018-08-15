Class {
	#name : #ClEditConstraint,
	#superclass : #ClEditOrStayConstraint,
	#category : #'Cassowary-Kernel'
}

{ #category : #'instance creation' }
ClEditConstraint class >> variable: aVariable value: aValue strength: aStrength [

	^ (self variable: aVariable strength: aStrength)
		value: aValue;
		yourself
]

{ #category : #testing }
ClEditConstraint >> isEditConstraint [

	^ true
]
