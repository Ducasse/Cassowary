Class {
	#name : #ClLinearExpression,
	#superclass : #Object,
	#instVars : [
		'constant',
		'terms'
	],
	#category : #'Cassowary-Kernel'
}

{ #category : #'instance creation' }
ClLinearExpression class >> newWithSymbolicWeight [

	| newGuy |
	newGuy := self new.
	newGuy constant: ClSymbolicWeight zero.
	^ newGuy
]

{ #category : #manipulation }
ClLinearExpression >> * x [
	"Answer a new CLLinearExpression formed by multiplying self by x.  (Note that this result must be linear.)"
	
	| expr n result |
	"If this expression is just a constant then we can just multiply by it..."
	self isConstant ifTrue: [^ x * self constant].

	"otherwise multipy by x"
	x isNumber 
		ifTrue: [n := x asFloat]
		ifFalse: [
			expr := x asLinearExpression.
			expr isConstant ifFalse: [ClError nonlinear signal "result would be non-linear"].
			n := expr constant].
	result := ClLinearExpression new.
	result constant: n * self constant.
	self terms keysAndValuesDo: [:v :c | result terms at: v put: n*c].
	^ result
]

{ #category : #manipulation }
ClLinearExpression >> + x [
	"Answer a new CLLinearExpression formed by adding x to self."
	| expr result |

	expr := x asLinearExpression.
	result := ClLinearExpression new.
	result constant: self constant + expr constant.
	self terms keysAndValuesDo: [:v :c | result terms at: v put: c].
	expr variablesAndCoefficientsDo: [:v :c | result addVariable: v coefficient: c].
	^ result
]

{ #category : #manipulation }
ClLinearExpression >> - x [
	"Answer a new CLLinearExpression formed by subtracting x from self."
	| expr result |

	expr := x asLinearExpression.
	result := ClLinearExpression new.
	result constant: self constant - expr constant.
	self terms keysAndValuesDo: [:v :c | result terms at: v put: c].
	expr variablesAndCoefficientsDo: [:v :c | result addVariable: v coefficient: c negated].
	^ result
]

{ #category : #manipulation }
ClLinearExpression >> / x [
	"Answer a new linear expression formed by dividing self by x. (Note that this result must be linear.)"

	| expr |
	expr := x asLinearExpression.
	expr isConstant ifFalse: [ClError nonlinear signal "result would be non-linear"].
	^ self * expr constant reciprocal
]

{ #category : #manipulation }
ClLinearExpression >> addExpression: expr times: n [
	"Add n * expr to this expression.

	expr	<ClLinearExpression>
	n		<Number>"

	self incrementConstant: n * expr constant.
	expr terms keysAndValuesDo: [:v :c |
		self addVariable: v coefficient: n*c]
]

{ #category : #manipulation }
ClLinearExpression >> addExpression: expr times: n subject: subject solver: solver [
	"Add n * expr to this expression.  Notify the solver if a variable is added or deleted from this expression.

	expr	<ClLinearExpression>
	n		<Number>
	subject	<ClAbstractVariable>
	solver	<ClSimplexSolver>"

	self incrementConstant: n * expr constant.
	expr terms keysAndValuesDo: [:v :c |
		self addVariable: v coefficient: n*c subject: subject solver: solver]
]

{ #category : #manipulation }
ClLinearExpression >> addVariable: v coefficient: c [
	"Add a term c*v to this expression.  If the expression already contains a term involving v, add c to the existing coefficient.  If the new coefficient is approximately 0, delete v.

	v		<ClVariable>
	c		<Number>"
	| newCoeff |

	(self terms includesKey: v)
		ifTrue: [
			newCoeff := c + (self terms at: v).
			(newCoeff clApproxZero)
				ifTrue: [
					self terms removeKey: v.
					^ self]
				ifFalse: [ self terms at: v put: newCoeff]]
		ifFalse: [self terms at: v put: c]
]

{ #category : #manipulation }
ClLinearExpression >> addVariable: v coefficient: c subject: subject solver: solver [
	"Add a term c*v to this expression.  If the expression already contains a term involving v, add c to the existing coefficient.  If the new coefficient is approximately 0, delete v.  Notify the solver if v appears or disappears from this expression.

	v		<ClVariable>
	c		<Number>
	subject	<ClAbstractVariable>
	solver	<ClSimplexSolver>"
	| newCoeff |

	(self terms includesKey: v)
		ifTrue: [
			newCoeff := c + (self terms at: v).
			(newCoeff clApproxZero)
				ifTrue: [
					self terms removeKey: v.
					solver noteRemovedVariable: v subject: subject.
					^ self]
				ifFalse: [ self terms at: v put: newCoeff]]
		ifFalse: [
			self terms at: v put: c.
			solver noteAddedVariable: v subject: subject]
]

{ #category : #accessing }
ClLinearExpression >> anyVariable [
	"Answer any ClAbstractVariable from this expression. (It is an error if this expression is constant)"

	self terms keysDo: [:v | ^ v].
	ClError signal: 'Expression is constant and this should not be the case'
]

{ #category : #conversion }
ClLinearExpression >> asLinearExpression [

	^ self
]

{ #category : #manipulation }
ClLinearExpression >> changeSubject: oldSubject newSubject: newSubject [
	"This linear expression currently represents the equation oldSubject=self.  Destructively modify it so that it represents the equation newSubject=self.

	Precondition: newSubject currently has a nonzero coefficient in this expression.

	oldSubject	<ClAbstractVariable>
	newSubject	<ClAbstractVariable>

	Suppose this expression is c + a*newSubject + a1*v1 + ... + an*vn.
	Then the current equation is oldSubject = c + a*newSubject + a1*v1 + ... + an*vn.
	The new equation will be newSubject = -c/a + oldSubject/a - (a1/1)*v1 - ... - (an/a)*vn.
	Note that the term involving newSubject has been dropped."
	| reciprocal nreciprocal |

	"remove newSubject from my dictionary of terms, saving the reciprocal of its coefficient"
	reciprocal := (self terms removeKey: newSubject) reciprocal.
	nreciprocal := reciprocal negated.
	self constant: nreciprocal * self constant.
	self terms keysAndValuesDo: [:v :c | self terms at: v put: c * nreciprocal].
	self terms at: oldSubject put: reciprocal
]

{ #category : #accessing }
ClLinearExpression >> cnEqual: expr [
	"Answer a ClLinearEquation self=expr with strength=required and weight=1.
	expr	<ClLinearExpression | ClVariable | Number>"

	^ self cnEqual: expr strength: self requiredStrength weight: 1.0
]

{ #category : #accessing }
ClLinearExpression >> cnEqual: expr strength: s [
	"Answer a ClLinearEquation self=expr with strength s and weight=1.
	expr	<ClLinearExpression | ClVariable | Number>
	s		<ClStrength>"

	^ self cnEqual: expr strength: s weight: 1.0
]

{ #category : #accessing }
ClLinearExpression >> cnEqual: expr strength: s weight: w [
	"Answer a ClLinearEquation self=expr with strength s and weight w.
	expr	<ClLinearExpression | ClVariable | Number>
	s		<ClStrength>
	w		<Float>"
	| cn |

	cn := ClLinearEquation new.
	cn expression: self - expr; strength: s; weight: w.
	^ cn

]

{ #category : #accessing }
ClLinearExpression >> cnGEQ: expr [
	"Answer a ClLinearInequality self>=expr with strength=required and weight=1.
	expr	<ClLinearExpression | ClVariable | Number>"

	^ self cnGEQ: expr strength: self requiredStrength weight: 1.0
]

{ #category : #accessing }
ClLinearExpression >> cnGEQ: expr strength: s [
	"Answer a ClLinearInequality self>=expr with strength s and weight=1.
	expr	<ClLinearExpression | ClVariable | Number>
	s		<ClStrength>"

	^ self cnGEQ: expr strength: s weight: 1.0
]

{ #category : #accessing }
ClLinearExpression >> cnGEQ: expr strength: s weight: w [
	"Answer a ClLinearInequality self>=expr with strength s and weight w.
	expr	<ClLinearExpression | ClVariable | Number>
	s		<ClStrength>
	w		<Float>"
			
	| cn |
	cn := ClLinearInequality new.
	cn expression: self - expr; strength: s; weight: w.
	^ cn

]

{ #category : #accessing }
ClLinearExpression >> cnLEQ: expr [
	"Answer a ClLinearInequality self<=expr with strength=required and weight=1.
	expr	<ClLinearExpression | ClVariable | Number>"

	^ self cnLEQ: expr strength: self requiredStrength weight: 1.0
]

{ #category : #accessing }
ClLinearExpression >> cnLEQ: expr strength: s [
	"Answer a ClLinearInequality self<=expr with strength s and weight=1.
	expr	<ClLinearExpression | ClVariable | Number>
	s		<ClStrength>"

	^ self cnLEQ: expr strength: s weight: 1.0
]

{ #category : #accessing }
ClLinearExpression >> cnLEQ: expr strength: s weight: w [
	"Answer a ClLinearInequality self<=expr with strength s and weight w.
	expr	<ClLinearExpression | ClVariable | Number>
	s		<ClStrength>
	w		<Float>"
	| cn |

	cn := ClLinearInequality new.
	cn expression: expr - self; strength: s; weight: w.
	^ cn

]

{ #category : #accessing }
ClLinearExpression >> coefficientFor: aClVariable [
	"Answer the coefficient corresponding to aClVariable (i.e. the 'ci' corresponding to the 'vi' that aClVariable is:
		v1@c1 + v2*c2 + ... + vn*cn + c"

	^ self terms at: aClVariable ifAbsent: [0.0]
]

{ #category : #accessing }
ClLinearExpression >> constant [
	"Answer the constant part of this expression (i.e. the 'c' in: c + a1*v1 + a2*v2 + ... + an*vn)"

	^ constant
]

{ #category : #manipulation }
ClLinearExpression >> constant: aNumber [
	"see ClLinearExpression constant"

	constant := aNumber
]

{ #category : #accessing }
ClLinearExpression >> divFrom: aNumber [
	"Answer a new ClLinearExpression (aNumber/self).  Since the result must be linear, this is permissible only if self is a constant."

	self isConstant ifTrue: [^ aNumber / self constant].
	"nonLinear Error"
	ClError signal: 'result would be non-linear'
]

{ #category : #manipulation }
ClLinearExpression >> incrementConstant: aNumber [
	"Increment the constant part of this expression by aNumber."

	self constant: self constant + aNumber
]

{ #category : #private }
ClLinearExpression >> initialize [
	"Initialize this linear expression to 0"

	"original code uses LookupTable instead of Dictionary"
	self 
		constant: 0.0;
		terms: Dictionary new.
	^ self

]

{ #category : #testing }
ClLinearExpression >> isConstant [
	"Answer true if this expression is a constant (i.e. it contains no varables)."

	^ self terms isEmpty
]

{ #category : #manipulation }
ClLinearExpression >> newSubject: subject [
	"This linear expression currently represents the equation self=0.  Destructively modify it so that subject=self represents an equivalent equation.  Precondition: subject must be one of the variables in this expression.

	subject	<ClAbstractVariable>

	Suppose this expression is c + a*subject + a1*v1 + ... + an*vn, representing
	c + a*subject + a1*v1 + ... + an*vn = 0.
	The modified expression will be -c/a - (a1/a)*v1 - ... - (an/a)*vn, representing
	subject = -c/a - (a1/a)*v1 - ... - (an/a)*vn
	Note that the term involving subject has been dropped."
	| nreciprocal |

	nreciprocal := (self terms removeKey: subject) reciprocal negated.
	self constant: nreciprocal * self constant.
	self terms keysAndValuesDo: [:v :c | self terms at: v put: c*nreciprocal]	
]

{ #category : #printing }
ClLinearExpression >> printOn: aStream [	
	| sortedKeys |

	self constant printOn: aStream.
	sortedKeys := self terms keys asSortedCollection: [:v1 :v2 |
		v1 name isNil or: [v2 name isNil or: [v1 name <= v2 name]]].
	sortedKeys do: [:v |
		aStream nextPut: $+.
		(self terms at: v) printOn: aStream.
		aStream nextPut: $*.
		v printOn: aStream].
]

{ #category : #accessing }
ClLinearExpression >> requiredStrength [
	^ ClStrength required
]

{ #category : #manipulation }
ClLinearExpression >> substituteOut: var expr: expr subject: subject solver: solver [
	"Replace var with a symbolic expression expr that is equal to it.  If a variable has been added to this expression that wasn't therer before, or if a variable has been dropped from this expression because it now has a coefficient of 0, inform the solver.

	Precondition: var occurs with a nonzero coefficient in this expression

	var		<ClAbstractVariable>
	expr	<ClLinearExpression>
	subject	<ClAbstractVariable>
	solver	<ClSimplexSolver>"
	| multiplier |
	
	multiplier := self terms removeKey: var.
	self incrementConstant: multiplier * expr constant.
	expr terms keysAndValuesDo: [:v :c | | newCoeff oldCoeff |
		oldCoeff := self terms at: v ifAbsent: [nil].
		oldCoeff 
			ifNil: [
				self terms at: v put: multiplier * c.
				solver noteAddedVariable: v subject: subject]
			ifNotNil: [
				newCoeff := oldCoeff + (multiplier * c).
				(newCoeff clApproxZero)
					ifTrue: [
						self terms removeKey: v.
						solver noteRemovedVariable: v subject: subject]
					ifFalse: [self terms at: v put: newCoeff]]]
]

{ #category : #accessing }
ClLinearExpression >> subtractFrom: aNumber [
	"Answer a new ClLinearExpression (aNumber - self)."

	^ self negated + aNumber

]

{ #category : #private }
ClLinearExpression >> terms [
	"Answer the terms dictionary.  The keys in the dictionary will be variables and the values will be numbers ( the corresponding coefficients).. If 'terms' contains variables v1, ..., vn and coefficients a1, ..., an, then this object represents the linear expression:
	constant + a1*v1 + ... + an*vn
Note that the coefficients should all be nonzero -- if there were going to be a zero coefficient, that term should be dropped from the linear expression."

	^ terms
]

{ #category : #private }
ClLinearExpression >> terms: aDictionary [
	"See ClLinearExpression terms.  

	aDictionary		<Dictionary of <ClVariable>-><Number>>"

	terms := aDictionary
]

{ #category : #enumerating }
ClLinearExpression >> variablesAndCoefficientsDo: aBlock [
	"Evaluate aBlock with each variable-coefficient pair asArguments.

	aBlock <Block [ClConstrainableVariable,Number]>"

	self terms keysAndValuesDo: [:v :c | aBlock value: v value: c]
]
