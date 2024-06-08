class ApplicationController < ActionController::Base

    private

    def require_admin
        # before_action :authenticate_user!
        unless current_user&.admin?
            redirect_to root_path, alert: 'You are not authorized to view this page'
        end
    end
end
