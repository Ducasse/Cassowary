Class {
	#name : #BaselineOfCassowary,
	#superclass : #BaselineOf,
	#category : #BaselineOfCassowary
}

{ #category : #baselines }
BaselineOfCassowary >> baseline: spec [
	<baseline>

	spec
		for: #common
		do: [ 	
			spec package: 'Cassowary'.			
		]

]
