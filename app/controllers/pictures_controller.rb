class PicturesController < ApplicationController
  before_action :set_picture, only: %I[ show edit update destroy]

  def index
    @pictures = Picture.all
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if @picture.save
      ContactMailer.contact_mail(@picture).deliver
      redirect_to pictures_path, notice: "投稿しました！"
    else
        render :new
    end
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def edit
    if @picture.user == current_user
        render "edit"
      else
        redirect_to pictures_path
      end
  end

  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @picture.destroy
    redirect_to pictures_path, notice:"削除しました！"
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  private

  def picture_params
    params.require(:picture).permit(:user_id, :content, :picture, :picture_cache)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end

end
