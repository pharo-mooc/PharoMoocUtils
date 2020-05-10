Class {
	#name : #SlideGenerator,
	#superclass : #Object,
	#instVars : [
		'identification',
		'title'
	],
	#category : #MoocUtils
}

{ #category : #accessing }
SlideGenerator >> identification [
	^ identification
]

{ #category : #parsing }
SlideGenerator >> parseFirstLine: aString [ 
	
	identification := (aString copyFrom: '│   ├──' size + 1 to: (aString indexOf: $.) - 1) trim
]

{ #category : #parsing }
SlideGenerator >> parseSecondLine: aString [ 
	title := aString trim
]

{ #category : #accessing }
SlideGenerator >> title [
	^ title
]
