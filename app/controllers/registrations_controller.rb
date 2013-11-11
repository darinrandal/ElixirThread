class RegistrationsController < Devise::RegistrationsController
	def sign_up(resource_name, resource)
		event_log(1, resource.id)

		if resource.id == 1
			resource.update_attributes(:admin => true)
		end

		sign_in(resource_name, resource)
	end
end