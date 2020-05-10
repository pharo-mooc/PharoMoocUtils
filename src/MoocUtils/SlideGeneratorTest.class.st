Class {
	#name : #SlideGeneratorTest,
	#superclass : #TestCase,
	#category : #MoocUtils
}

{ #category : #tests }
SlideGeneratorTest >> testExtractInPresenceOfNoise [

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
	self assert: slides size equals: 3. 
	
]

{ #category : #tests }
SlideGeneratorTest >> testExtractInPresenceOfNoise2 [

	| stream gen slides |
	stream := 
	'This file describes the titles for each of the live videos.

├── W1
│   ├── W1-LiveA-EN.mov
		Selecting Expressions
│   ├── W1-LiveA-FR.mov
		De la selection d''expressions
' readStream.
	gen := SlideGenerator new. 
	slides := gen parse: stream.
	self assert: slides size equals: 2. 
	
]

{ #category : #tests }
SlideGeneratorTest >> testExtractMoreThanOne [

	| stream gen slides |
	stream := 
	'│   ├── W1-LiveA-EN.mov
		Selecting Expressions
│   ├── W1-LiveA-FR.mov
		De la selection d''expressions
│   ├── W1-LiveB-EN.mov
		Prof Stef
│   ├── W1-LiveB-FR.mov
		Prof Stef' readStream.
	gen := SlideGenerator new. 
	slides := gen parse: stream.
	self assert: slides size equals: 4. 
	self assert: slides last title equals: 'Prof Stef'.
	
	
]

{ #category : #tests }
SlideGeneratorTest >> testExtractSimple [

	| stream gen slides |
	stream := 
	'│   ├── W1-LiveA-EN.mov
		Selecting Expressions' readStream.
	gen := SlideGenerator new. 
	slides := gen parse: stream.
	self assert: slides isEmpty not.
	self assert: slides first identification equals: 'W1-LiveA-EN'.
	self assert: slides first title equals: 'Selecting Expressions'.
]

{ #category : #tests }
SlideGeneratorTest >> testIdentificationExtraction [

	| stream gen |
	stream := 
	'│   ├── W1-LiveA-EN.mov
		Selecting Expressions' readStream.
	gen := SlideGenerator new. 
	gen := gen parseFirstLine: stream nextLine.
	self assert: gen identification equals: 'W1-LiveA-EN'.
	
	
]

{ #category : #tests }
SlideGeneratorTest >> testTitleExtraction [

	| stream gen |
	stream := 
	'│   ├── W1-LiveA-EN.mov
		Selecting Expressions' readStream.
	gen := SlideGenerator new. 
	gen := gen parseSecondLine: (stream nextLine; nextLine).
	self assert: gen title equals: 'Selecting Expressions'.
	
	
]
