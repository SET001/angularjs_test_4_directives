el = scope = null

genNote = ->
	id: "note#{Math.random()*10000}"
	text: "asdasd"
getNotes = -> el.find 'li'

describe "Directive", ->
	beforeEach ->
		module 'app'
		module 'templates/notepad.html'
		module 'templates/noteNavigation.html'
		inject ($rootScope, $compile, NotesFactory) ->
			window.NotesFactory = NotesFactory
			NotesFactory.removeAll()
			for i in [1..10]
				NotesFactory.put genNote()
			el = angular.element "<notepad/>"
			$compile(el) scope = $rootScope
			scope.$digest()

	describe 'notepad', ->
		it 'should render all notes', ->
			expect((el.find 'li').length).toBe NotesFactory.getAll().length

		it 'should add note', inject ($compile) ->
			length = NotesFactory.getAll().length
			note = genNote()
			NotesFactory.put note
			$compile(el) scope
			scope.$apply()
			expect(getNotes().length).toBe length+1


	describe "noteNavigation", ->
		it 'should remove note', inject ($compile) ->
			notes = getNotes()
			length = notes.length
			notes.eq(0).find('.glyphicon-remove').click()
			expect(getNotes().length).toBe length-1