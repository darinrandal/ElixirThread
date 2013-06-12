class RegistrationsController < Devise::RegistrationsController
	def sign_up(resource_name, resource)
		event_log(1, resource.id)
		sign_in(resource_name, resource)
	end
end