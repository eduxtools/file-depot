class AttachmentsController < ApplicationController
  def create
    @attachment = Attachment.new(attachment_params)

    if params[:temp_image_token]
      @attachment.temp_id = params[:temp_image_token]

    elsif params[:work_id]
      @attachment.parent = Work.find(params[:work_id])

    elsif params[:course_id]
      @attachment.parent = Course.find(params[:course_id])

    end
    
    respond_to do |format|
      if @attachment.save
        format.any{ render :text => 'success (temp page)' }
      else
        format.any{ render :text => 'error (temp page)' }
      end
    end
  end

  def destroy
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def attachment_params
      params.require(:attachment).permit(:attachment)
    end
end
