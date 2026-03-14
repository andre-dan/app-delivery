module ApplicationHelper
  # Returns the active visual theme based on the current hour.
  def current_theme
    hour = Time.current.hour
    if hour >= 8 && hour < 15
      "theme-lunch"
    elsif hour >= 18 && hour < 23
      "theme-dinner"
    end
  end

  # Unsplash placeholder based on product shift / category name.
  PRODUCT_IMAGES = {
    lunch:  "https://images.unsplash.com/photo-1598103442097-8b74394b95c3?w=400&h=300&fit=crop",
    dinner: "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&h=300&fit=crop",
    both:   "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400&h=300&fit=crop"
  }.freeze
  DRINK_IMAGE = "https://images.unsplash.com/photo-1544145945-f90425340c7e?w=400&h=300&fit=crop"

  def product_image_url(product)
    if product.category.name.downcase.include?("bebida")
      DRINK_IMAGE
    else
      PRODUCT_IMAGES[product.shift.to_sym]
    end
  end
end
