# coding: utf-8

class SessionsController < ApplicationController

  def new
  end

  def create
    if Setting['sessions.force_confirmation'] && params[:confirm].blank?
      flash[:error] = "Bitte bestätige die Hinweise zum Datenschutz"
      return redirect_to new_session_path
    end

    response = post_url("#{Setting['vbulletin.base_url']}/login.php?do=login", {
      'do'                => 'login',
      'securitytoken'     => 'guest',
      'vb_login_username' => params[:name],
      'vb_login_password' => params[:password]
    })

    if response && response['set-cookie']['vbseo_loggedin=yes'].present?
      session[:member_id] = create_or_update_member(params[:name])
      redirect_to root_url, notice: "Erfolgreich angemeldet"
    else
      flash.now.alert = "Name oder Passwort ist falsch."
      render :new
    end
  end

  def destroy
    session[:member_id] = nil
    redirect_to root_url, notice: "Erfolgreich abgemeldet."
  end

  private

  def create_or_update_member(name)
    if member = Member.find_by_name(name.try(:strip).try(:downcase))
      member
    else
      Member.create!({name: name}, as: :admin)
    end
  end

end