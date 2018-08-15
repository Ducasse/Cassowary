Extension { #name : #Object }

{ #category : #'*Cassowary' }
Object >> clApprox: x [
	"Answer true if I am approximately equal to the argument.  The default is just an equality test."

	^ self = x
]

{ #category : #'*Cassowary' }
Object >> isSymbolicWeight [

	^ false
]
