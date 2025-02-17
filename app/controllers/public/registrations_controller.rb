# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController
   before_action :configure_sign_up_params, only: [:create]
   before_action :configure_account_update_params, only: [:update]
   before_action :ensure_normal_user, only: %i[update destroy]#ゲストアカウント削除・変更対策

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if(user_edit_params[:name]).present?&&(user_edit_params[:email]).present?
    @user.update(user_edit_params)
    redirect_to public_user_path(current_user)
    else
      redirect_to  edit_user_registration_path(current_user)
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name])
   end

  # If you have extra params to permit, append them to the sanitizer.
   def configure_account_update_params
     devise_parameter_sanitizer.permit(:account_update, keys: [:email, :name])
   end

   def user_edit_params
      params.require(:user).permit(:name, :email)
   end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  #ゲストユーザーをemailで判別
  def ensure_normal_user
    if resource.check != 1
      redirect_to public_user_path(current_user), notice: '更新・削除はできません。'
    end
  end

end
