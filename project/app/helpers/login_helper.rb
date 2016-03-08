module Narms
  class App
    module LoginHelper
      def set_current_user(user)
        session[:user_id] = user ? user.id : nil
        session[:role_id] = user ? user.role_id : nil
      end

      def blank_session?
        !session[:user_id]
      end

      def login_from_session
        User.find_by_id(session[:user_id]) unless blank_session?
      end

      def current_user
        @current_user || login_from_session
      end

      def shift_user
        @shift_user = session[:role_id]
      end

      def signed_in?
        !!current_user
      end

      def ensure_authenticated!
        error 401, 'Wrong token' unless signed_in?
      end

      def sign_out
        session[:user_id] = nil
      end
    end

    helpers LoginHelper
  end
end
