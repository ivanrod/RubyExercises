=begin
ShoppingCart class

items: array
=end

class ShoppingCart

	def initialize
		@items = []
	end

	def add(symb)
		@items.push(Item.new(symb))
	end

	def cost
		cost = 0
		@items.each do |item|
			cost += item.cost
		end
		return cost
	end

end

class Item
	attr_reader :cost, :name
	def initialize(symb)
		@name = symb

		@cost = 0

		@prices = { :apple => 10, :orange => 5, :grape => 15, :banana => 20, :watermelon => 50 }
		@discount = Discount.new(Time.now, @prices)
		@discount.bySeason
		@discount.byDay
		@prices = @discount.prices

		@prices.keys.each do |fruit|
			if symb == fruit
				@cost = @prices[fruit]
			end
		end
	end

end

class Discount
	attr_reader :prices
	def initialize(date, prices)
		@date = date
		@prices = prices
	end

	def bySeason
		if @date.month <= 3 || @date.month > 11
			#Winter
			@prices[:apple] = 12
			@prices[:orange] = 5
			@prices[:grape] = 15
			@prices[:banana] = 21 
		elsif @date.month > 3 || @date.month <= 6
			#Spring
			@prices[:apple] = 10
			@prices[:orange] = 5
			@prices[:grape] = 15
			@prices[:banana] = 20 
		elsif @date.month > 6 || @date.month <= 9
			#Summer
			@prices[:apple] = 10
			@prices[:orange] = 2
			@prices[:grape] = 15
			@prices[:banana] = 20 
		else
			#Autumn
			@prices[:apple] = 15
			@prices[:orange] = 5
			@prices[:grape] = 15
			@prices[:banana] = 20 
		end
	end

	def byDay
		if @date.sunday?
			@prices[:watermelon] = @prices[:watermelon]*2
		end
	end
end



def test1
	cart = ShoppingCart.new

	cart.add :apple
	cart.add :banana

	return cart
end