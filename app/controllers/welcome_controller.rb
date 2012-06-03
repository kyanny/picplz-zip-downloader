
class WelcomeController < ApplicationController
  def index
    if current_user
      @archive = current_user.archive || Archive.new
    else
      @archive = Archive.new
    end
  end

  def archive
    case
    when request.post?
      if current_user.archive
        current_user.archive.destroy
      end
      archive = Archive.create!(:user_id => current_user.id)
      archive.delay.archive
      archive.update_attributes(:enqueue => true)
      redirect_to :welcome_index, :notice => 'Start creating zip archive. Please wait a few minutes and reload this page. Download link appears.'
    when request.delete?
      current_user.archive.destroy
      redirect_to :welcome_index, :notice => 'Zip deleted. Goodbye!'
    else
      raise
    end
  end
end
