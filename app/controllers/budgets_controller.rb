class BudgetsController < ApplicationController
  before_action :authenticate_user!
  def index
      @budgets = Budget.where(user_id: current_user.id) if current_user
      if params[:filter].present? || params[:search].present?
        case params[:filter]
          when "Mas recientes"
            @budgets = @budgets.order(created_at: :desc)
          when "Mas antiguos"
            @budgets = @budgets.order(created_at: :asc)
          when "Mayor precio"
            @budgets = @budgets.order(total: :desc)
          when "Menor precio"
            @budgets = @budgets.order(total: :asc)
          end
      end
      if params[:search].present?
        @budgets = @budgets.where("name LIKE ?", "%#{params[:search]}%")
      end
  end


  def destroy
    @budget = Budget.find(params[:id])
    @budget.destroy
    redirect_to budgets_path, notice: 'Presupuesto eliminado exitosamente.'
  end
  
  def edit
    @budget = Budget.find(params[:id])
    @products = Product.all 
    @budget_items = @budget.budget_items.includes(:product)
  end
  
  def update
    @budget = Budget.find(params[:id])
  
    if params[:add_products]
      params[:add_products].each do |product_id, quantity|
        @budget.budget_items.create(product_id: product_id, amount: quantity.to_i)
      end
    end
  
    if params[:remove_products]
      params[:remove_products].each do |budget_item_id|
        BudgetItem.find(budget_item_id).destroy
      end
    end
  
    if @budget.update(budget_params)
      redirect_to budgets_path, notice: 'Presupuesto actualizado correctamente.'
    else
      @products = Product.all
      render :edit
    end
  end
  
  private
  
  def budget_params
    params.require(:budget).permit(:expiration_date, :total, :name, :user_id)
  end
end

