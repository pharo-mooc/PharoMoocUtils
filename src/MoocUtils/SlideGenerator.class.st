"
From a file annotated from the tree linux command output, I generate slides
Here is typical file. 


This file describes the titles for each of the live videos.

├── W1
│   ├── W1-LiveA-EN.mov
		Selecting Expressions
│   ├── W1-LiveA-FR.mov
		De la selection d'expressions
│   ├── W1-LiveB-EN.mov
		Prof Stef
│   ├── W1-LiveB-FR.mov
		Prof Stef
│   ├── W1-LiveC-EN.mov
		Syntax Highlighting gives Feedback
│   ├── W1-LiveC-FR.mov
		La coloration syntaxique donne des informations
│   ├── W1-LiveD-EN.mov
		Learn keyboard shortcuts
│   ├── W1-LiveD-FR.mov
		Raccourcis clavier
│   ├── W1-Redo1-EN.mov
		Redo: Package, Class and Method
│   ├── W1-Redo1-FR.mov
		Redo: Package, Class et Methodes
│   ├── W1-Redo2-EN.mov
		Redo: Adding some unit tests
│   ├── W1-Redo2-FR.mov
		Redo: Les tests entre en scene
│   ├── W1-Redo3-EN.mov
		Redo: Looking back at Method creation
│   ├── W1-Redo3-FR.mov
		Redo: Revisitons la creation de methodes
│   ├── W1-Redo4-EN.mov
		Redo: Save your code with Iceberg
│   ├── W1-Redo4-FR.mov
		Redo: Sauver son code avec Iceberg
		


	| stream gen slides |
	stream := 
	'│   ├── W1-LiveA-EN.mov
		Selecting Expressions
		
│   ├── W1-LiveA-FR.mov
		De la selection d''expressions

│   ├── W1-LiveB-EN.mov
		Prof Stef
' readStream.
	gen := SlideGenerator new. 
	slides := gen parse: stream.
	(gen generateOneSlide: slides first) 
"
Class {
	#name : #SlideGenerator,
	#superclass : #Object,
	#instVars : [
		'identification',
		'title',
		'slides'
	],
	#category : #MoocUtils
}

{ #category : #parsing }
SlideGenerator >> addSlideDescription [
	slides add: (SlideDescription new 
							title: self title; 
						 identification: self identification)
]

{ #category : #generation }
SlideGenerator >> generateOneSlide: aSlide [

	(FileSystem workingDirectory / (aSlide identification, '.pillar')) asFileReference writeStream 
		nextPutAll: (self generateOneSlideContents: aSlide)
	
]

{ #category : #generation }
SlideGenerator >> generateOneSlideContents: aSlide [

	^ 
	'\{
    "title": "{title}",
    "subtitle": "",
	 "slidesid": "{identification}"
\}' format: { 'title' -> aSlide title . 'identification' -> aSlide identification } asDictionary 

	
]

{ #category : #accessing }
SlideGenerator >> identification [
	^ identification
]

{ #category : #initialization }
SlideGenerator >> initialize [ 
	super initialize.
	slides := OrderedCollection new.
]

{ #category : #parsing }
SlideGenerator >> parse: aStream [
	
	| inStream line |
	inStream := aStream readStream.
	[ line := inStream nextLine.
	line isNil ] whileFalse: [ 
			(line beginsWith: '│   ├──')
				ifTrue: [ self parseFirstLine: line.
							 self parseSecondLine: inStream nextLine.
							 self addSlideDescription ]
			].
	^ slides 	
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
