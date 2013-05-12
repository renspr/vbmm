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
      'vb_login_username' => params[:name],
      'vb_login_password' => params[:password]
    })

    logged_in = (response.try(:body) || "").match(/<form.+action=".+forum\.php\?s=[a-f0-9]+"/)
    vb_id     = (response.try(:body) || "").match(/LOGGEDIN\s*=\s*(\d+)/i)[1]

    if logged_in && vb_id
      session[:member_id] = create_or_update_member(vb_id, params[:name])
      redirect_to root_url
    else
      flash.now[:error] = "Name oder Passwort ist falsch."
      render :new
    end
  end

  def destroy
    session[:member_id] = nil
    redirect_to root_url
  end

private

  def create_or_update_member(vb_id, name)
    if member = Member.find_by_name(name.try(:strip).try(:downcase))
      member.update_attributes!({vb_id: vb_id}, as: :admin)
      member
    else
      Member.create!({name: name, vb_id: vb_id}, as: :admin)
    end
  end

end