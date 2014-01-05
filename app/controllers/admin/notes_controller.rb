class Admin::NotesController < ApplicationController
  before_filter :set_admin
  before_filter :authenticate_user!

  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    redirect_to request.referrer
  end
end
