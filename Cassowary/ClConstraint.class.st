Class {
	#name : #ClConstraint,
	#superclass : #Object,
	#instVars : [
		'strength',
		'weight'
	],
	#category : #'Cassowary-Kernel'
}

{ #category : #accessing }
ClConstraint >> expression [
	"Answer my linear expression.  (For linear equations, this constraint represents expression=0; for linear inequalities it represents expression>=0.)"

	self subclassResponsibility
]

{ #category : #testing }
ClConstraint >> isEditConstraint [

	^ false
]

{ #category : #testing }
ClConstraint >> isInequality [
	"Answer true if this is an inequality constraint and false if it is an equality constraint.  Default is equality."

	^ false
]

{ #category : #testing }
ClConstraint >> isRequired [
	"Answer true if my strength is 'required'."

	^ strength isRequired
]

{ #category : #testing }
ClConstraint >> isStayConstraint [

	^ false
]

{ #category : #accessing }
ClConstraint >> strength [
	"Answers <ClStrength>"

	^ strength
]

{ #category : #private }
ClConstraint >> strength: aClStrength [
	
	strength := aClStrength
]

{ #category : #accessing }
ClConstraint >> weight [
	"Answers <Float>"

	^ weight
]

{ #category : #private }
ClConstraint >> weight: aFloat [
	
	weight := aFloat
]
