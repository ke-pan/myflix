class Admin::PaymentsController < AdministratorsController
  def index
    @billings = Billing.recent.decorate
  end
end
