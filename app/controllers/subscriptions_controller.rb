class SubscriptionsController < ApplicationController
	before_action :authenticate_user!
	before_action :already_premium?, except: :destroy

  def new
  	@stripe_btn_data = {
  		key: "#{ Rails.configuration.stripe[:publishable_key] }",
  		description: "Premium Membership - #{current_user.username}",
  		amount: 199
  	}
  end

  def create
  	begin
			#create stripe customer
			customer = Stripe::Customer.create(
				email: current_user.email,
				card: params[:stripeToken],
				plan: 'premium'
			)
			# update user model to keep stripe_id and make premium
			current_user.update_attributes(stripe_id: customer.id, role: 'premium')
			#flash success message
			flash[:notice] = "Thanks for upgrading to premium membership!"
			redirect_to current_user
		rescue Stripe::CardError => e
			# flash error message. card problem
			flash[:error] = e.message
			redirect_to new_subscription_path
		rescue => e
			# flash error catch all
			flash[:error] = e.message
			redirect_to new_subscription_path
		end
	end

	def destroy
		customer = Stripe::Customer.retrieve(current_user.stripe_id)
		subscription = customer.subscriptions.first

		if subscription.delete()
			current_user.update_attributes(role: 'standard')
			flash[:notice] = "You have successfully downgraded to standard membership. All of your wikis are now public."
			make_wikis_public current_user
			redirect_to current_user
		else
			flash[:error] = "There was an error and we couldn't complete your request. Please try again."
			redirect_to edit_user_registration_path(current_user)
		end
	end

	private
	def already_premium?
		if current_user.premium? && current_user.stripe_id != nil
			flash[:alert] = "You are already a premium user."
			redirect_to edit_user_registration_path(current_user)
		elsif current_user.admin?
			flash[:alert] = "Administrators do not need to pay for premium membership."
			redirect_to edit_user_registration_path(current_user)
		end
	end

	def make_wikis_public(user)
		wikis = user.wikis.where(private: true)
		wikis.each do |wiki|
			wiki.update_attributes(private: false)
		end
	end
end
