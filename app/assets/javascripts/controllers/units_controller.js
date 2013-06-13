SmartEating.UnitController = Ember.ArrayController.create()

var units = [];

$.get('api/units', function(data) {
    for(var i = 0; i < data.length; i++){
        console.log(data[i]["unit"]["name"]);
        units.push(data[i]["unit"]["name"]);
    }
    SmartEating.UnitController.set('content', units);

});

