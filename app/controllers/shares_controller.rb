class SharesController < ApplicationController
  def create
    current_user.share_event params[:message] if current_user.sharable
    redirect_back fallback_location: root_path, flash: { success: 'Message shared.'}
  end
end
