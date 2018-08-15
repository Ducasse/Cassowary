"
self makeDemos
"
Class {
	#name : #ClDemoWindow,
	#superclass : #Morph,
	#instVars : [
		'shell',
		'main',
		'form',
		'da',
		'gc',
		'gcw',
		'buffer',
		'grabPoint',
		'dragPoint',
		'cs',
		'errorPixel',
		'editX',
		'editY'
	],
	#category : #'Cassowary-Demo'
}

{ #category : #'instance creation' }
ClDemoWindow class >> makeDemos [
	"statements to build various demos"

	ClBoundedLineDemo new openInWorld.
	ClElasticBoundedLineDemo new openInWorld.
	ClQuadDemo new openInWorld.
	ClMidpointDemo new openInWorld.
	ClBoundedQuadDemo new openInWorld.
	ClCrossedQuadDemo new openInWorld.
	ClElasticQuadDemo new openInWorld.
"	ClTreeDemo1 new openInWorld.
	ClTreeDemo2 new openInWorld."
	ClBoxesDemo new openInWorld.
"	ClSequenceDiagramDemo1 new openInWorld."
	(ClBinaryTreeDemo height: 4) openInWorld.
]

{ #category : #'event handling' }
ClDemoWindow >> beginManipulation [
	"This method is called when a constrainable point is starting to be manipulated, i.e., upon mouse down.  The constrainable point is stored in the 'dragPoint' instance variable, and the corresponding plan for moving that point is stored in the 'plan' instance variable.

The order of messages is:
	1. #beginManipulation
	2-N. #manipulationMoveTo:
	N+1. #endManipulation"

	self constraintPointsDo: [:p |
		dragPoint == p ifTrue: [
			cs addEditVar: p x strength: ClStrength strong.
			cs addEditVar: p y strength: ClStrength strong.
			cs beginEdit.
			^nil]].

	 "drag point not found"
	self error: 'Drag point not found' 
]

{ #category : #enumerating }
ClDemoWindow >> constraintPointsDo: aBlock [
	"Evaluate this block for each of the constrainable points in this demo.  Constrainable points are those that can be manipulated by the mouse.  A constraint point is a Point object whose x and y instance variables hold instances of ClVariable.

	aBlock 	<Block<Point<ClVariable>>>"

	self subclassResponsibility
]

{ #category : #initialization }
ClDemoWindow >> createForm [

	self error: 'this needs to be redone for morphic.'.

	"da := form createDrawingArea: 'da' argBlock: nil.
	da manageChild.
	da setValuesBlock: [:w |
		w
			bottomAttachment: XmATTACHFORM;
			topAttachment: XmATTACHFORM;
			rightAttachment: XmATTACHFORM;
			leftAttachment: XmATTACHFORM].
	da
		addCallback: XmNexposeCallback
			receiver: self
			selector: #exposeArea:clientData:callData:
			clientData: nil;
		addCallback: XmNresizeCallback
			receiver: self
			selector: #resizeArea:clientData:callData:
			clientData: nil;
		addEventHandler: Button1MotionMask
			receiver: self
			selector: #button1Motion:clientData:callData:
			clientData: nil;
		addEventHandler: ButtonPressMask
			receiver: self
			selector: #buttonPress:clientData:callData:
			clientData: nil;
		addEventHandler: ButtonReleaseMask
			receiver: self
			selector: #buttonRelease:clientData:callData:
			clientData: nil;
		addEventHandler: PointerMotionMask
			receiver: self
			selector: #pointerMotion:clientData:callData:
			clientData: nil"

]

{ #category : #initialization }
ClDemoWindow >> createWindow [

	self error: 'this needs to be redone for morphic.'.

	"shell :=
		CwTopLevelShell
			createApplicationShell: 'shell'
			argBlock: [:w |
				w
					title: self title;
					width: self initialExtent x;
					height: self initialExtent y].
	main := shell createMainWindow: 'main' argBlock: nil.
	main manageChild.
	form := main createForm: 'form' argBlock: nil.
	form manageChild.
	shell
		addCallback: XmNdestroyCallback
		receiver: self
		selector: #destroyWindow:clientData:callData:
		clientData: nil.
	self createForm"

]

{ #category : #drawing }
ClDemoWindow >> drawBackgroundOn: aCanvas [

	aCanvas fillRectangle: self bounds fillStyle: self fillStyle
]

{ #category : #drawing }
ClDemoWindow >> drawForegroundOn: aCanvas [


]

{ #category : #drawing }
ClDemoWindow >> drawGrabBoxOn: aCanvas [

	grabPoint ifNotNil: [
		aCanvas 
			frameRectangle: ((grabPoint valuePoint - self grabThreshold + self position) corner: 
								(grabPoint valuePoint + self grabThreshold + self position))
			color: Color yellow]
]

{ #category : #drawing }
ClDemoWindow >> drawOn: aCanvas [

	self 
		drawBackgroundOn: aCanvas;
		drawForegroundOn: aCanvas;
		drawGrabBoxOn: aCanvas.

]

{ #category : #'event handling' }
ClDemoWindow >> endManipulation [
	"This method is called when a constrainable point is ending being manipulated, i.e., upon mouse up.  The constrainable point is stored in the 'dragPoint' instance variable, and the corresponding plan for moving that point is stored in the 'plan' instance variable.

	The order of messages is:
		1. #beginManipulation
		2-N. #manipulationMoveTo:
		N+1. #endManipulation"

	cs endEdit.
	self changed.
]

{ #category : #copying }
ClDemoWindow >> fixupPoint: aPoint with: deepCopier [
	"Answer a Point that contains the deeply copied counterparts of its x and y values"

	^ (deepCopier references at: aPoint x) @ (deepCopier references at: aPoint y)
	
]

{ #category : #defaults }
ClDemoWindow >> grabThreshold [

	^ 7@7
]

{ #category : #'event handling' }
ClDemoWindow >> handleListenEvent: evt [

	| threshold |

	dragPoint ifNil: [
		threshold := self grabThreshold * 2.
		self constraintPointsDo: [:pt | | pv |
			pv := pt valuePoint rounded + self position.
			(((pv - threshold) corner: (pv + threshold)) containsPoint: evt position) ifTrue: [
				grabPoint == pv ifFalse: [
					grabPoint := pt.
					self changed].
				^ self]].
		grabPoint ifNotNil: [
			grabPoint := nil.
			self changed]]
]

{ #category : #'event handling' }
ClDemoWindow >> handlesMouseDown: evt [

	evt redButtonPressed ifTrue: [^ true].
	^ super handlesMouseDown: evt
]

{ #category : #'event handling' }
ClDemoWindow >> handlesMouseOver: evt [

	^ true
]

{ #category : #'event handling' }
ClDemoWindow >> handlesMouseStillDown: evt [

	evt redButtonPressed ifTrue: [^ true].
	^ super handlesMouseStillDown: evt
]

{ #category : #defaults }
ClDemoWindow >> initialExtent [

	^ 300@300
]

{ #category : #initialization }
ClDemoWindow >> initialize [
	"Initialize the demo structures before the widgets are created."

	super initialize.
	self extent: self initialExtent.
	cs := ClSimplexSolver new.
	errorPixel := nil
]

{ #category : #'event handling' }
ClDemoWindow >> manipulationMoveTo: aPoint [
	"This method is called when a constrainable point is manipulated using the mouse, i.e., during mouse motion.  aPoint is the location of the mouse and thus the new requested location of the constrainable point.  The constrainable point is stored in the 'dragPoint' instance variable, and the corresponding plan for moving that point is stored in the 'plan' instance variable.

	The order of messages is:
		1. #beginManipulation
		2-N. #manipulationMoveTo:
		N+1. #endManipulation"

	cs suggestValue: dragPoint x newValue: aPoint x asFloat.
	cs suggestValue: dragPoint y newValue: aPoint y asFloat.
	cs resolve.
	self changed
]

{ #category : #'event handling' }
ClDemoWindow >> mouseDown: evt [

	super mouseDown: evt.

	grabPoint ifNil: [^ self].
	dragPoint := grabPoint.
	grabPoint := nil.
	
	self beginManipulation

]

{ #category : #'event handling' }
ClDemoWindow >> mouseEnter: evt [

	super mouseEnter: evt.
	evt hand addMouseListener: self
]

{ #category : #'event handling' }
ClDemoWindow >> mouseLeave: evt [

	super mouseLeave: evt.
	evt hand removeMouseListener: self
]

{ #category : #'event handling' }
ClDemoWindow >> mouseStillDown: evt [

	super mouseStillDown: evt.

	dragPoint ifNil: [^ self].
	self manipulationMoveTo: (evt cursorPoint - self position)
]

{ #category : #'event handling' }
ClDemoWindow >> mouseUp: evt [

	super mouseUp: evt.

	dragPoint ifNil: [^ self].
	dragPoint := nil.
	
	self endManipulation

]

{ #category : #copying }
ClDemoWindow >> veryDeepFixupWith: deepCopier [
	"If some fields were weakly copied, fix new copy here."

	super veryDeepFixupWith: deepCopier.
	grabPoint ifNotNil: [grabPoint := self fixupPoint: grabPoint with: deepCopier].
	dragPoint ifNotNil: [dragPoint := self fixupPoint: dragPoint with: deepCopier].
]
