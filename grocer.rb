def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  oldCartIndex = 0
  collectionItem = nil
  while oldCartIndex < collection.length do
    if collection[oldCartIndex][:item] == name
     return collection[oldCartIndex]
    else
      oldCartIndex += 1 
    end  
  end
  return
end

def consolidate_cart(cart)
  newCart = []
  oldCartIndex = 0
  while oldCartIndex < cart.length do 
    newCartIndex = 0
    if newCart.length > 0
      while newCartIndex < newCart.length do
        if newCart[newCartIndex][:item] == cart[oldCartIndex][:item]
          newCart[newCartIndex][:count] += 1
          break
        end
        newCartIndex += 1 
      end 
      if newCartIndex == newCart.length
        newCart.push(cart[oldCartIndex])
        newCart[newCart.length - 1][:count] = 1
      end
    else
      newCart.push(cart[oldCartIndex])
      newCart[0][:count] = 1
    end
    oldCartIndex += 1
  end 
  return newCart
end 

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  consolCartIndex = 0 
  while consolCartIndex < cart.length do 
    coupCartIndex = 0 
    while coupCartIndex < coupons.length do 
      if coupons[coupCartIndex][:item] == cart[consolCartIndex][:item]
        cart[consolCartIndex][:count] = cart[consolCartIndex][:count] - coupons[coupCartIndex][:num]
        cart.push({:item => "#{cart[consolCartIndex][:item]} W/COUPON", :price => coupons[coupCartIndex][:cost] / coupons[coupCartIndex][:num], :clearance => cart[consolCartIndex][:clearance], :count => coupons[coupCartIndex][:num]})
        break 
      end 
    coupCartIndex += 1  
    end  
    
  consolCartIndex += 1   
  end 
  puts cart
  return cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  origCartIndex = 0 
  puts cart.length
  while origCartIndex < cart.length do 
    if cart[origCartIndex][:clearance] == true
      cart[origCartIndex][:price] = cart[origCartIndex][:price] - (cart[origCartIndex][:price] * 0.20)
      cart[origCartIndex][:price].round(2)
    end
  origCartIndex += 1
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
  totalprice = 0
  finalCartIndex = 0
  finalCart = consolidate_cart(cart)
  puts finalCart
  apply_coupons(finalCart, coupons)
  puts finalCart
  apply_clearance(finalCart)
  puts finalCart
  
  while finalCartIndex < finalCart.length do 
    iprice = 0
    iprice = finalCart[finalCartIndex][:price] * finalCart[finalCartIndex][:count]
    puts iprice
    totalprice = totalprice + iprice
    puts totalprice
    finalCartIndex += 1
  end   
  if totalprice > 100
  totalprice = totalprice - (totalprice * 0.10)  
  totalprice.round(2)
  puts totalprice
  end  
  return totalprice
end
