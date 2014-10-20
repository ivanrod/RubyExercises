=begin
ShoppingCart class
items: array
loyalCustomer: boolean
day: string
discount: Float
=end

class ShoppingCart
    attr_accessor :bill, :discounts
    
    def initialize(items,loyalCustomer,day)
    	@items = items
		@loyalCustomer = loyalCustomer
		@day = day
		@bill = 0
		@discounts = 0
		for i in @items
			@bill += i.price
		end

	end
	def discount()
		for i in @items
            i.discount(@day)
			@discounts += i.discounts
		end
		if @loyalCustomer && @items.length > 5
			@discounts += 0.1  * @bill
		end
	end
end

=begin
item class
name: string
type: string
price: Float
discounts: Float
=end
class Item
    attr_accessor :price, :discounts
	def initialize(name, price, type)
		@name = name
		@type =  type
		@price = price
		@discounts = 0
	end
	def discount(day)
		if @type == "fruit" && (day == "saturday" || day == "sunday")
			@discounts += 0.1 * @price
		elsif @type == "houseware" && @price > 100
			@discounts += 0.05 * @price
		end
	end
end

=begin
test with a set of items and a shopping cart 
=end
def test()
	banana = Item.new("Banana",10,"fruit")
	orangeJuice = Item.new("Orange Juice", 10, "juice")
	rice = Item.new("Rice", 1, "food")
	vacuumCleaner = Item.new("Vacuum Cleaner", 150, "houseware")
	anchovies = Item.new("Anchovies", 2, "food")

	cart = ShoppingCart.new([banana, orangeJuice, rice, vacuumCleaner,anchovies], true, "saturday")

	return cart
end