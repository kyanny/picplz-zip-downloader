
class WelcomeController < ApplicationController
  def index
  end

  def archive
    case
    when request.post?
      archive = Archive.create!(:user_id => current_user.id)
      archive.delay.archive
      redirect_to :index, :notice => 'Start creating zip archive. Please wait a few minutes and reload this page. Download link appears.'
    when request.delete?
      current_user.archive.destroy
    else
      raise
    end
  end
end
