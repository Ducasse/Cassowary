Class {
	#name : #ClError,
	#superclass : #Error,
	#category : #'Cassowary-Kernel'
}

{ #category : #'instance creation' }
ClError class >> error [

	^ self new messageText: '(ExCLError) An error has occured in CL'


]

{ #category : #'instance creation' }
ClError class >> internal [

	^ self new messageText: '(ExCLInternalError) An internal error has occured'


]

{ #category : #'instance creation' }
ClError class >> nonlinear [

	^ self new messageText: '(ExCLNonlinearExpression) The resulting expression would be nonlinear' 


]

{ #category : #'instance creation' }
ClError class >> notEnoughStays [

	^ self new messageText: '(ExCLNotEnoughStays) There are not enough stays to give specific values to every variable'  


]

{ #category : #'instance creation' }
ClError class >> requiredFailure [

	^ self new messageText: '(ExCLRequiredFailure) A required constraint cannot be satisfied' 
]

{ #category : #'instance creation' }
ClError class >> tooDifficult [

	^ self new messageText: '(ExCLError) An error has occured in CL' 
]
