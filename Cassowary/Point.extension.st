Extension { #name : #Point }

{ #category : #'*Cassowary' }
Point >> valuePoint [
	"Answer a Point with the values of my x and y coordinates"

	^ x value @ y value
]
