Extension { #name : #Number }

{ #category : #'*Cassowary' }
Number >> asLinearExpression [
	"Coerce this number to be a ClLinearExpression."
	
	| expr |
	expr := ClLinearExpression new.
	expr constant: self asFloat.
	^ expr
]

{ #category : #'*Cassowary' }
Number >> cnEqual: expr [
	"Answer a linear constraint self=expr with strength=required and weight=1.

	expr 		<ClLinearExpression | ClVariable | Number>
	<answer>	<ClLinearEquation>"

	^ self cnEqual: expr strength: ClStrength required weight: 1.0
]

{ #category : #'*Cassowary' }
Number >> cnEqual: expr strength: s [
	"Answer a linear constraint self=expr of strength s and weight=1.

	expr 		<ClLinearExpression | ClVariable | Number>
	s 			<ClStrength>
	<answer>	<ClLinearEquation>"

	^ self cnEqual: expr strength: s weight: 1.0
]

{ #category : #'*Cassowary' }
Number >> cnEqual: expr strength: s weight: w [
	"Answer a linear constraint self=expr of strength s and weight w.

	expr 		<ClLinearExpression | ClVariable | Number>
	s 			<ClStrength>
	w 			<Float>
	<answer>	<ClLinearEquation>"
	| cn |

	cn := ClLinearEquation new.
	cn 
		expression: self-expr; 
		strength: s; 
		weight: w.
	^ cn
]

{ #category : #'*Cassowary' }
Number >> cnGEQ: expr [
	"Answer a linear constraint self>=expr with strength=required and weight=1.

	expr 		<ClLinearExpression | ClVariable | Number>
	<answer>	<ClLinearInequality>"

	^ self cnGEQ: expr strength: ClStrength required weight: 1.0
]

{ #category : #'*Cassowary' }
Number >> cnGEQ: expr strength: s [
	"Answer a linear constraint self>=expr of strength s and weight=1.

	expr 		<ClLinearExpression | ClVariable | Number>
	s 			<ClStrength>
	<answer>	<ClLinearInequality>"

	^ self cnGEQ: expr strength: s weight: 1.0
]

{ #category : #'*Cassowary' }
Number >> cnGEQ: expr strength: s weight: w [
	"Answer a linear constraint self>=expr of strength s and weight w.

	expr 		<ClLinearExpression | ClVariable | Number>
	s 			<ClStrength>
	w 			<Float>
	<answer>	<ClLinearEquation>"
	| cn |

	cn := ClLinearInequality new.
	cn 
		expression: self-expr; 
		strength: s; 
		weight: w.
	^ cn
]

{ #category : #'*Cassowary' }
Number >> cnLEQ: expr [
	"Answer a linear constraint self<=expr with strength=required and weight=1.

	expr 		<ClLinearExpression | ClVariable | Number>
	<answer>	<ClLinearInequality>"

	^ self cnLEQ: expr strength: ClStrength required weight: 1.0
]

{ #category : #'*Cassowary' }
Number >> cnLEQ: expr strength: s [
	"Answer a linear constraint self<=expr of strength s and weight 1.

	expr 		<ClLinearExpression | ClVariable | Number>
	s 			<ClStrength>
	<answer>	<ClLinearInequality>"

	^ self cnLEQ: expr strength: s weight: 1.0
]

{ #category : #'*Cassowary' }
Number >> cnLEQ: expr strength: s weight: w [
	"Answer a linear constraint self<=expr of strength s and weight w.

	expr 		<ClLinearExpression | ClVariable | Number>
	s 			<ClStrength>
	w 			<Float>
	<answer>	<ClLinearEquation>"
	| cn |

	cn := ClLinearInequality new.
	cn 
		expression: expr-self; 
		strength: s; 
		weight: w.
	^ cn
]
