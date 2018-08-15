Class {
	#name : #ClLinearEquation,
	#superclass : #ClLinearConstraint,
	#category : #'Cassowary-Kernel'
}

{ #category : #printing }
ClLinearEquation >> printOn: aStream. [

	self strength printOn: aStream.
	aStream nextPut: $(.
	expression printOn: aStream.
	aStream nextPutAll: '=0)'
]
