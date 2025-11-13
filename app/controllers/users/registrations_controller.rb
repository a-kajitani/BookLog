# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :prevent_admin_destroy, only: [:destroy]

  private

  def prevent_admin_destroy
    if current_user.admin?
      redirect_to root_path, alert: "管理者は退会できません"
    end
  end
end
