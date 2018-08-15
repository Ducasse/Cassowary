Extension { #name : #Float }

{ #category : #'*Cassowary' }
Float >> clApprox: aFloat [
	"Answer true if I am approximately equal to the argument."
	| epsilon |

	epsilon := ClSimplexSolver epsilon.
	self = 0.0 ifTrue: [^ aFloat abs < epsilon].
	aFloat = 0.0 ifTrue: [^ self abs < epsilon].
	^ (self - aFloat) abs < (self abs * epsilon)
]

{ #category : #'*Cassowary' }
Float >> clApproxZero [
	"Answer true if I am approximately zero."

	^ self clApprox: 0.0
]

{ #category : #'*Cassowary' }
Float >> definitelyNegative [
	"return true if I am definitely negative (i.e. smaller than negative epsilon)"
	^ self < (0.0 - ClSimplexSolver epsilon)
]
