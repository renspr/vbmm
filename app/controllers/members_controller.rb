# coding: utf-8

class MembersController < ApplicationController

  before_filter :authenticate_member!

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    if @member.update_attributes(params[:member])
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @member = current_member
    if @member.destroy && session[:member_id] = nil
      flash[:success] = "Konto gelöscht. Auf wiedersehen."
    else
      flash[:error] = "Konto konnte nicht gelöscht werden. Es ist ein Fehler aufgetreten."
    end

    redirect_to root_path
  end

end