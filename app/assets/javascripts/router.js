SmartEating.Router.map(function() {
    return this.route('entries', {
        path: '/'
    });
});

SmartEating.EntriesRoute = Ember.Route.extend({
    model: function() {
        return SmartEating.Entry;
    }
});


