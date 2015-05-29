app.directive 'notepad', (NotesFactory) ->
  restrict: 'AE'
  scope: {}
  templateUrl: 'templates/notepad.html'
  controller: ($scope) ->
    @remove = (note) ->
      $scope.notes = NotesFactory.remove note
    no

  link: (scope, elem, attrs) ->
    scope.openEditor = (index) ->
      scope.editMode = yes
      unless index is undefined
        scope.noteText = NotesFactory.get(index).content
        scope.index = index
      else
        scope.noteText = undefined
    
    scope.save = ->
      if scope.noteText isnt "" && scope.noteText isnt undefined
        note = {}
        note.title = if scope.noteText.length > 10 then scope.noteText.substring(0, 10) + '. . .' else scope.noteText
        note.content = scope.noteText
        note.id = if scope.index isnt -1 then scope.index else localStorage.length
        scope.notes = NotesFactory.put note
      scope.restore()

    scope.restore = ->
      scope.editMode = no
      scope.index = -1
      scope.noteText = ""

    editor = elem.find('#editor')

    scope.restore()

    scope.notes = NotesFactory.getAll()

    editor.bind 'keyup keydown', ->
      scope.noteText = editor.text().trim()
