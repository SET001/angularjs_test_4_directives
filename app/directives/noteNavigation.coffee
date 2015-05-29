app.directive 'noteNavigation', ->
	restrict: 'E'
	scope:
		note: '='
	require: '^notepad'
	templateUrl: 'templates/noteNavigation.html'
	link: (scope, elem, attrs, notepadCtrl) ->
		scope.remove = ->
			notepadCtrl.remove scope.note
