Class {
	#name : #ClInternalError,
	#superclass : #ClError,
	#category : #'Cassowary-Kernel'
}

{ #category : #initialization }
ClInternalError >> initialize [

	super initialize.
	self messageText: '(ExCLInternalError) An internal error has occured'
]
