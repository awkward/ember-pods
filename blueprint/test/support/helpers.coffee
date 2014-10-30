# Model helpers

QUnit.assert.belongsTo = (model, msg) ->

  relationship = Ember.get(val, 'relationshipsByName').get(exp)

  @push(relationship.kind is 'belongsTo', relationship.kind, 'belongsTo', msg)

# QUnit.assert.hasMany = (val, exp, msg) ->

  # @push(res, act, exp, msg)