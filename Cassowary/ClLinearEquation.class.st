Class {
	#name : #ClLinearEquation,
	#superclass : #ClLinearConstraint,
	#category : #'Cassowary-Kernel'
}

{ #category : #testing }
ClLinearEquation >> isFullfilled [
	
	^ self expression hasNumericValue and: [ self expression numericValue rounded = 0 ]
]

{ #category : #printing }
ClLinearEquation >> printOn: aStream. [

	self strength printOn: aStream.
	aStream nextPut: $(.
	expression printOn: aStream.
	aStream nextPutAll: '=0)'
]
