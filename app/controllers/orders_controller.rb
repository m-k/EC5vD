# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    scope = Order.open.order(:created_at)
    @orders = OrderPresenter.wrap(scope)
  end

  def update
    @order = Order.find(params[:id])
    result = @order.update(permitted_params)

    respond_to do |format|
      format.turbo_stream
      format.html do
        flash = update_flash(result)
        redirect_to root_path, **flash
      end
    end
  end

  private

  def permitted_params
    params.require(:order).permit(:state)
  end

  def update_flash(result)
    if result
      { notice: t('.notice') }
    else
      { alert: t('.alert') }
    end
  end
end
