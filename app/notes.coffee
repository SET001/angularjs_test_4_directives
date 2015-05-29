app.factory 'NotesFactory', ->
	remove: (note) ->
		localStorage.removeItem "note#{note.id}"
		this.getAll()
	removeAll: ->
		localStorage.clear()
	put: (note) ->
		localStorage.setItem('note' + note.id, JSON.stringify(note));
		this.getAll()
	get: (index) ->
		JSON.parse localStorage.getItem "note#{index}"
	getAll: ->
		notes = []
		for key, note of localStorage
			if key.indexOf 'note' > -1
				notes.push JSON.parse note
		notes