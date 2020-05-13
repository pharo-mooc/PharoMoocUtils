"
From a file annotated from the tree linux command output, I generate slides
Here is typical file. 


This file describes the titles for each of the live videos.

 W1
>  W1-LiveA-EN.mov
		Selecting Expressions
>  W1-LiveA-FR.mov
		De la selection d'expressions
>  W1-LiveB-EN.mov
		Prof Stef


Here is how the slides are generated.

	| gen slides stream |
	stream := '/Users/ducasse/Workspace/FirstCircle/MyBooks/Bk-Writing/PharoMooc/SlidesForVideos/TitlesForVideos.txt' asFileReference.
	gen := SlideGenerator new. 
	gen folder: '/Users/ducasse/Workspace/FirstCircle/MyBooks/Bk-Writing/PharoMooc/SlidesForVideos' asFileReference.
	slides := gen parse: stream.
	slides do: [ :aSlide | gen generateOneSlide: aSlide ] 



"
Class {
	#name : #SlideGenerator,
	#superclass : #Object,
	#instVars : [
		'identification',
		'title',
		'slides',
		'folder'
	],
	#category : #MoocUtils
}

{ #category : #accessing }
SlideGenerator class >> script [
	<script>
	| gen slides stream |
	stream := '/Users/ducasse/Workspace/FirstCircle/MyBooks/Bk-Writing/PharoMooc/SlidesForVideos/TitlesForVideos.txt' asFileReference.
	gen := SlideGenerator new. 
	gen folder: '/Users/ducasse/Workspace/FirstCircle/MyBooks/Bk-Writing/PharoMooc/SlidesForVideos' asFileReference.
	slides := gen parse: stream.
	slides do: [ :aSlide | gen generateOneSlide: aSlide ] 

]

{ #category : #parsing }
SlideGenerator >> addSlideDescription [
	slides add: (SlideDescription new 
							title: self title; 
						 identification: self identification)
]

{ #category : #generation }
SlideGenerator >> folder [

	^ folder ifNil: [ folder := FileSystem workingDirectory ]
]

{ #category : #generation }
SlideGenerator >> folder: aFileReference [

	folder := aFileReference 
]

{ #category : #generation }
SlideGenerator >> generateOneSlide: aSlide [

	(self folder / (aSlide identification, '.pillar')) asFileReference writeStreamDo: [ :str |  
		str nextPutAll: (self generateOneSlideContents: aSlide)]
	
]

{ #category : #generation }
SlideGenerator >> generateOneSlideContents: aSlide [

	^ 
	'\{
    "title": "{title}",
    "author": "S. Ducasse and L. Fabresse with Q. Ducasse",
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
			(line beginsWith: '>')
				ifTrue: [ self parseFirstLine: line.
							 self parseSecondLine: inStream nextLine.
							 self addSlideDescription ]
			].
	^ slides 	
]

{ #category : #parsing }
SlideGenerator >> parseFirstLine: aString [ 
	
	identification := (aString copyFrom: '>' size + 1 to: (aString indexOf: $.) - 1) trim
]

{ #category : #parsing }
SlideGenerator >> parseSecondLine: aString [ 
	title := aString trim
]

{ #category : #accessing }
SlideGenerator >> title [
	^ title
]
