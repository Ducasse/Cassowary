"
self new openInWorld
"
Class {
	#name : #ClElasticBoundedLineDemo,
	#superclass : #ClBoundedLineDemo,
	#category : #'Cassowary-Demo'
}

{ #category : #initialization }
ClElasticBoundedLineDemo >> initialize [

	super initialize.
	cs addConstraint: (p2 y - p1 y cnEqual: 200.0 strength: ClStrength medium).
]
