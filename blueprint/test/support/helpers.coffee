# Model helpers

QUnit.assert.belongsTo = (subject, belongsTo) ->

  mdl = subject()
  relationship = Ember.get(mdl.get('constructor'), 'relationshipsByName').get(belongsTo)
  @push(relationship.kind is 'belongsTo', relationship.kind, 'belongsTo', "#{mdl.get('constructor').toString().toLowerCase()} should belong to #{belongsTo}")

QUnit.assert.hasMany = (subject, hasMany) ->

  mdl = subject()
  relationship = Ember.get(mdl.get('constructor'), 'relationshipsByName').get(hasMany)
  @push(relationship.kind is 'hasMany', relationship.kind, 'hasMany', "#{mdl.get('constructor').toString().toLowerCase()} should have many #{hasMany}")

window.assert = QUnit.assert