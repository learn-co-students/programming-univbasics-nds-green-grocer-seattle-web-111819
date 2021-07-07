def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  i = 0
  while i < collection.length do
    if collection[i][:item] == name
      return collection[i]
    end
    i += 1
  end
  nil
end


def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  con_cart = []
  i = 0
  while i < cart.length do
    u = 0
    while u <= con_cart.length do
      if u == con_cart.length
        con_cart[u] = cart[i]
        con_cart[u][:count] = 1
        u = con_cart.length
      elsif cart[i][:item] == con_cart[u][:item]
        con_cart[u][:count] += 1
        u = con_cart.length
      end
      u += 1
    end
    i += 1
  end
  return con_cart      
end


def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coup_cart = []
  c = 0
  while c < coupons.length do
    i = 0
    while i < cart.length do
      if cart[i][:item] == coupons[c][:item] && cart[i][:count] >= coupons[c][:num]
        coup_cart << {item: cart[i][:item] + " W/COUPON", price: coupons[c][:cost]/coupons[c][:num], clearance: cart[i][:clearance], count: coupons[c][:num]}
        cart[i][:count] -= coupons[c][:num]
        i = cart.length
      end
      i += 1
    end
  c += 1
  end
  cart.concat(coup_cart)
  return cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0
  while i < cart.length do
    if cart[i][:clearance]
      cart[i][:price] = (cart[i][:price] * 0.8).round(2)
    end
    i += 1
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
  check_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  tot = 0
  i = 0
  while i < check_cart.length do
    tot += check_cart[i][:price] * check_cart[i][:count]
    i += 1
  end
  if tot >= 100
    tot = (tot * 0.9).round(2)
  end
  tot
end
