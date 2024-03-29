class ProductsController < ApplicationController
    
   def index
      @products = Product.all
      @products_footwear = Product.where(category_id: Category.find_by(name: "Calzados")&.id)
      @products_clothes = Product.where(category_id: Category.find_by(name: "Indumentaria")&.id)
      @products_sport = Product.where(category_id: Category.find_by(name: "Deporte")&.id)
      @products_accessories = Product.where(category_id: Category.find_by(name: "Accesorios")&.id)
   end

   def add_to_budget
      @product = Product.find(params[:product_id])
      @budget = Budget.find(params[:product][:budget_id])

      # Verificar si el producto ya está en el presupuesto
      budget_item = @budget.budget_items.find_by(product_id: @product)
   
      if budget_item.nil?
      # Si no está en el presupuesto, crear un nuevo BudgetItem
      budget_item = @budget.budget_items.find_or_initialize_by(product_id: @product.id, amount: 1)
      budget_item.save!
      else
      # Si ya está en el presupuesto, actualizar la cantidad y el precio total
      budget_item.update(amount: budget_item.amount + 1, product_id: @product)
      end

      @product.update(stock: @product.stock - 1) if @product.stock.positive?

      total = @product.price + @budget.total
      @budget.update(total: total)
   
      redirect_to products_path, notice: "Producto agregado al presupuesto exitosamente."
   end

end