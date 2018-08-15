"
This class lists a set of possible improvements.

subtractFrom: aNumber
	""Answer a new ClLinearExpression (aNumber - self).""

	^ self negated + aNumber
negated does not exist!


- printing of CLVariable should display their type. This should help debugging.
- Should add comments to classes.
- add more tests
- may be multiple exceptions should be added as subclasses of ClError.


"
Class {
	#name : #CLPossibleTodo,
	#superclass : #Object,
	#category : #'Cassowary-Kernel'
}
