
class WelcomeController < ApplicationController
  def index
  end

  def archive
    archive = Archive.create!(:user_id => current_user.id)
    archive.delay.archive
    redirect_to :index, :notice => 'Start creating zip archive. Please wait a few minutes and reload this page. Download link appears.'
  end
end
