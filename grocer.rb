def find_item_by_name_in_collection(name, collection)
  index = 0
  while index < collection.length do
    if collection[index][:item] != name
       nil
    else
      return collection[index]
  end
  index += 1
  end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
    #
    # REMEMBER: This returns a new Array that represents the cart. Don't merely
    # change `cart` (i.e. mutate) it. It's easier to return a new thing.
    array = []
    hash = {}
    index = 0
    while index < cart.length do
      item_name = cart[index][:item]
      if hash.has_key?("#{item_name}")
        hash["#{item_name}"][:count] += 1
      else
        hash["#{item_name}"] = cart[index]
        hash["#{item_name}"][:count] = 1
        array << hash["#{item_name}"]
      end
      index += 1
    end
    array
    end



def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  if coupons == []
    index = 0
    array = []
    while index < cart.length do
      array << cart[index]
      index += 1
    end
  else
    array = []
    hash = {}
    coupon_hash = {}
    index = 0
    while index < cart.length
      item_name = cart[index][:item]
      hash["#{item_name}"] = cart[index]
      i = 0
      while i < coupons.length do
       coupon_name = coupons[i][:item]
       coupon_hash["#{coupon_name}"] = coupons[i]
        if
          item_name == coupon_name && hash["#{item_name}"][:count] >= coupon_hash["#{coupon_name}"][:num]
          left_over = hash["#{item_name}"][:count] % coupon_hash["#{coupon_name}"][:num]
          coupon_hash["#{coupon_name}"][:count] = hash["#{item_name}"][:count] - left_over
          hash["#{item_name}"][:count] = left_over
          coupon_hash["#{coupon_name}"][:item] = "#{coupon_hash["#{coupon_name}"][:item].upcase} W/COUPON"
          coupon_hash["#{coupon_name}"][:price] = coupons[i][:cost] / coupons[i][:num]
          coupon_hash["#{coupon_name}"][:clearance] = cart[index][:clearance]
            if hash["#{item_name}"][:count] == 0
              array << coupon_hash["#{coupon_name}"]
            else
              array << coupon_hash["#{coupon_name}"]

            end
        end
          i += 1
      end
      array << hash["#{item_name}"]
      index += 1
    end
  end
  array
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  array = []
  hash = {}
  index = 0
  while index < cart.length do
    item_name = cart[index][:item]
    hash["#{item_name}"] = cart[index]
    if hash["#{item_name}"][:clearance] == true
      new_price = hash["#{item_name}"][:price] * 0.8
      hash["#{item_name}"][:price] = new_price.round(2)
      array << hash["#{item_name}"]
    else
      array << hash["#{item_name}"]
    end
    index += 1
  end
  array
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
  # some irritated customer
  if coupons == []
    new_cart = consolidate_cart(cart)
    coupons_applied_cart = apply_coupons(new_cart, [])
    clearance_applied_cart = apply_clearance(coupons_applied_cart)
    total = 0
    index = 0
      while index < clearance_applied_cart.length do
      price = clearance_applied_cart[index][:price]
      count = clearance_applied_cart[index][:count]
      total += (price * count)
      index += 1
      end
    end
  if cart[0][:count] != nil && coupons != []
    coupons_applied_cart = apply_coupons(cart, coupons)
    clearance_applied_cart = apply_clearance(coupons_applied_cart)
    total = 0
    index = 0
      while index < clearance_applied_cart.length do
      price = clearance_applied_cart[index][:price]
      count = clearance_applied_cart[index][:count]
      total += (price * count)
      index += 1
      end
  elsif coupons != []
    new_cart = consolidate_cart(cart)
    coupons_applied_cart = apply_coupons(new_cart, coupons)
    clearance_applied_cart = apply_clearance(coupons_applied_cart)
    total = 0
    index = 0
      while index < clearance_applied_cart.length do
      price = clearance_applied_cart[index][:price]
      count = clearance_applied_cart[index][:count]
      total += (price * count)
      index += 1
      end
    end
    if total > 100
      total = (total * 0.9)
      total.round(2)
    else
    total
  end
  end
