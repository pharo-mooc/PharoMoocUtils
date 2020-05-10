Class {
	#name : #SlideDescription,
	#superclass : #Object,
	#instVars : [
		'identification',
		'title'
	],
	#category : #MoocUtils
}

{ #category : #accessing }
SlideDescription >> identification [
	^ identification
]

{ #category : #accessing }
SlideDescription >> identification: anObject [
	identification := anObject
]

{ #category : #printing }
SlideDescription >> printOn: aStream [

	"super printOn: aStream."
	aStream 
		nextPutAll: ' '; 
		nextPutAll: self title;
		nextPutAll: '/';
		nextPutAll: self identification 
]

{ #category : #accessing }
SlideDescription >> title [
	^ title
]

{ #category : #accessing }
SlideDescription >> title: anObject [
	title := anObject
]
