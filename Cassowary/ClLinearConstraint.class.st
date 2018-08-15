Class {
	#name : #ClLinearConstraint,
	#superclass : #ClConstraint,
	#instVars : [
		'expression'
	],
	#category : #'Cassowary-Kernel'
}

{ #category : #accessing }
ClLinearConstraint >> expression [
	"Answer my linear expression. (For linear equations, this constraint represents expression=0; for linear inequalities it represents expression>=0.
	<answer> a CLLinearExpression"
	^ expression  
]

{ #category : #private }
ClLinearConstraint >> expression: aCLLinearExpression [

	expression := aCLLinearExpression
]
