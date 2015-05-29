describe "NotesFactory", ->
	genNote = ->
		id: "note#{Math.random()*10000}"
		text: "asdasd"

	beforeEach ->
		module 'app'
		inject ($injector) ->
			window.NotesFactory = $injector.get 'NotesFactory'
			NotesFactory.removeAll()

	it 'should add notes', ->
		length = NotesFactory.getAll().length
		note = genNote()
			
		NotesFactory.put note
		expect(NotesFactory.getAll().length).toBe length+1
		expect(NotesFactory.getAll()[0]).toEqual note

	it 'should remove notes', ->
		note = genNote()
		NotesFactory.put note
		length = NotesFactory.getAll().length
		NotesFactory.remove note
		expect(NotesFactory.getAll().length).toBe length-1
		expect(NotesFactory.get note.id).toBeFalsy()

	it 'should found note', ->
		note = genNote()
		NotesFactory.put note
		expect(NotesFactory.get note.id).toEqual note
		expect(NotesFactory.get genNote()).toBeFalsy()