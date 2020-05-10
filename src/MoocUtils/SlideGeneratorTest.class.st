Class {
	#name : #SlideGeneratorTest,
	#superclass : #TestCase,
	#category : #MoocUtils
}

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
