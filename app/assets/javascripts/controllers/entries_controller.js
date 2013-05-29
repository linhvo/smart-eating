SmartEating.EntriesController = Ember.Controller.extend
({
    entries: [],
    unit: ["gram", "cup"],
    addFood: function () {
        if (this.get('food') && this.get('quantity')) {
            this.entries.pushObject({
                name: this.get('food'),
                quantity: this.get('quantity')
            });
            return this.set('food', ""),
                this.set('quantity', "");
        } else{
            alert("Fill in food or quantity")
        }
    }
});