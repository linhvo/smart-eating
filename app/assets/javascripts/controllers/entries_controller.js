SmartEating.EntriesController = Ember.ArrayController.extend
({
    addFood: function () {
        if (this.get('food') && this.get('quantity')) {
            this.pushObject(Ember.Object.create({
                name: this.get('food'),
                quantity: this.get('quantity'),
                unit: SmartEating.UnitController.get('unit')
            })
            );
            return this.set('food', ""),
                this.set('quantity', "");
        } else {
            alert("Fill in food or quantity")
        }
    }
});

