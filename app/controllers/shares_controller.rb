class SharesController < ApplicationController
  def create
    current_user.share_event params[:message] if current_user.sharable
    redirect_to :back, flash: { success: 'Message shared.'}
  end
end
