# require 'pp'
#require 'pry'


def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  # Returns a matching hash if a match is found between the desired name and a given hash's item key
i=0
  while i< collection.length do
    if name==collection[i][:item]
      return collection[i]
    end
    i+= 1
  end
  return nil
end

def find_item_index_by_name_in_collection(name, collection)

  # Returns a matching hash's INDEX if a match is found between the desired name and a given hash's item key
i=0
  while i< collection.length do
    if name==collection[i][:item]
      return i
    end
    i+= 1
  end
  return nil
end

def add_count_key_to_item_hash(item_hash)
  {
    :item => item_hash[:item],
    :price => item_hash[:price],
    :clearance => item_hash[:clearance],
    :count => 1
  }
end


def consolidate_cart(cart)


  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  new_consolidated_cart=[]
  i=0

    while i< cart.length do

    old_item_hash = cart[i]
    new_item_hash_index = find_item_index_by_name_in_collection(old_item_hash[:item],new_consolidated_cart)
      if new_item_hash_index != nil #if returns true, aka, it has a match and already exists in new_consolidated_cart, increase the count by 1
        new_consolidated_cart[new_item_hash_index][:count] +=1
      else
        #new_consolidated_cart<<cart[i] #if it returns false, add hash item to new_consolidated_cart and add a count key with value of 1
        new_consolidated_cart<<add_count_key_to_item_hash(old_item_hash)
      end
      i+=1
    end
    new_consolidated_cart
  end



  # to update keys and values after coupon is confirmed
  def update_coupon_item_hash(item_hash, coupon_item_hash)
    {
      :item => item_hash[:item] + ' W/COUPON',
      :price => coupon_item_hash[:cost] / coupon_item_hash[:num],
      :clearance => item_hash[:clearance],
      :count => coupon_item_hash[:num]
    }
  end

  # makes a new item and updates the original cart item count
  def update_original_cart_item_count(item_hash, coupon_item_hash)
    {
      :item => item_hash[:item],
      :price => item_hash[:price],
      :clearance => item_hash[:clearance],
      :count => item_hash[:count] - coupon_item_hash[:num]
    }
  end

  def apply_coupons(cart, coupons)
    if coupons.length == 0
      return cart
    end


    i=0
    while i<coupons.length do
      j=0
      while j<cart.length do
        if coupons[i][:item] == cart[j][:item] && cart[j][:count] >= coupons[i][:num]
          cart << update_coupon_item_hash(cart[j], coupons[i])
          cart[j][:count] = cart[j][:count] - coupons[i][:num]
          # coupon_applied_cart<< update_original_cart_item_count(cart[j],coupons[i])
        end
        j +=1
      end
      i +=1
    end

    return cart
  end


def discount(cart_item)
  discounted = (cart_item[:price] * 0.8).round(2)
  return discounted
end


def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

  i=0
  while i<cart.length do
    if cart[i][:clearance] == true
      clearance_price= discount(cart[i])
      cart[i][:price] = clearance_price
    end
    i +=1
  end

  return cart
end



def checkout(cart, coupons)

  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  puts "cart"
  puts cart

  puts "coupons"
  puts coupons

  cart_consolidated = consolidate_cart(cart)

  puts "consolidate_cart result:"
  puts cart_consolidated

  coupons_consolidated_cart = apply_coupons(cart_consolidated, coupons)

  puts "apply_coupons result:"
  puts coupons_consolidated_cart

  cheapest_cart = apply_clearance(coupons_consolidated_cart)
  puts "apply_clearance result:"
  puts cheapest_cart


  cart_total = 0
  i=0
  while i<cheapest_cart.length do
    cart_total += cheapest_cart[i][:price] * cheapest_cart[i][:count]

    i +=1
  end

  if cart_total >= 100
    final_discount = (cart_total * 0.9).round(2)
    return final_discount
  else
    puts "cart total before return:"
    puts cart_total
    return cart_total
  end

end
