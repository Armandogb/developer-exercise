
var Quote = Backbone.Model.extend({
	defaults: {
		source: "n/a",
		context: "n/a",
		quote: "n/a",
		theme: "n/a"
	}
});

var QuoteCatalog = Backbone.PageableCollection.extend({
	url: "https://gist.githubusercontent.com/anonymous/8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/quotes.json",
	model: Quote,
	mode: "client",
	state: {
		pageSize: 15
	}
});

var QuoteView = Backbone.View.extend({
	tagName: 'li',

	my_template: _.template("<strong><%= context %></strong> (<%= theme %>) - <%= quote %> - <%= source %>"),

	initialize: function(){
		this.render();
	},

	render: function(){
		this.$el.html( this.my_template(this.model.toJSON()));
		return this;
	}
});

var QuoteList = Backbone.View.extend({
	tagName: 'ul',

	initialize: function(){
		var self = this;
		this.collection = new QuoteCatalog();
		this.collection.fetch().done(function(){
			self.render();
		});
	},
	render: function(){
		this.collection.each(function(quote){
			var quoteView = new QuoteView({ model: quote });
			$('ul').append(quoteView.el);
		});
	}

});