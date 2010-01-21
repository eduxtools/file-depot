class ImagesController < ApplicationController
  
  def index
     @images = Image.all

     respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @works }
     end
   end

   def new
     if params[:work_id]
       @image = Image.new
       @work = Work.find(params[:work_id])
     else
       redirect_to(works_url)
     end
        
   end
   
   def create
     success_count = file_count = 0
     @work = Work.find(params[:work][:id])
     
     # Image processing -- atypical validations 
     #
     @image = Image.new
     params[:image_data] ||= []
     params[:image_data].each do |file|
       if file != ""
         file_count = file_count + 1
         @image = Image.new({:uploaded_data => file, :work_id => @work.id })
         if @image.save
           success_count = success_count + 1 
         end
       end
     end
     flash[:success_count] = success_count
     flash[:file_count] = file_count
     
     redirect_to work_url(@work)
     
  end
end
