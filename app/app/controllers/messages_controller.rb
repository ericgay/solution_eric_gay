class MessagesController < ApplicationController
  def create
    if params[:message].present?
      render json: {
        digest: sha_manager.to_hash(params[:message])
      }, status: 201
    else
      render json: {}, status: 400
    end
  end

  def show
    if message = sha_manager.to_text(params[:id])
      render json: { message: message }
    else
      render json: { error: "Message not found" }, status: 404
    end
  end

  private

  def sha_manager
    @sha_manager ||= ShaManager.new
  end
end
