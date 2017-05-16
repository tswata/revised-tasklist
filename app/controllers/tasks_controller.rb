class TasksController < ApplicationController
  def index
    @tasks = Task.where("(status = ?) OR (status = ?)","未着手","対応中").order(:limit).page(params[:page]).per(5)
  end
  
  def done
    @tasks = Task.where(status:"完了").order(updated_at: :DESC).page(params[:page]).per(5)
  end

  def show
    set_task
  end
  
  def new
   
    
  end

  def create
    p "!!!!!"
    p params[:user_id]
    
    @array = []
    @errors = []
    (0..2).each  do |n|
      task = Task.new(content: params["content#{n}"],
                    status:  params["status#{n}"],
                    limit:   params["limit#{n}"],
                    user_id: params[:user_id])
                    
      task.validate
      @errors << task.errors.full_messages
      if params["content#{n}"].present? && params["limit#{n}"].present?
        @array[n] =Task.new(content: params["content#{n}"],
                    status:  params["status#{n}"],
                    limit:   params["limit#{n}"],
                    user_id: params[:user_id])
      else
        @array[n] = nil
      end
    end
    p "***********************"
    p @errors
   x = []
  
    (0..2).each do |n|
      if @array[n] != nil
        if @array[n].save
          x[n] = true
        else
          x[n] = false
        end
      else
          x[n] = true
      end
    end
    
    if x.include? false or @array == [nil, nil, nil]
      flash.now[:danger] = "タスクが登録されませんでした。"
      render :new
    else
      flash[:success] = "タスクが登録されました。"
      redirect_to root_url
    end
  end
    

  def edit
    set_task
  end

  def update
    set_task
    if @task.update(task_params)
      flash[:success] = "タスクは正常に更新されました"
      if @task.status =="完了"
        redirect_to done_path
      else
        redirect_to tasks_url
      end
    else
      flash.now[:danger] = "タスクは更新されませんでした"
      render :edit
    end
  end

  def destroy
    set_task
    if @task.status == "完了"
      @task.destroy
      flash[:success] = "タスクは正常に削除されました"
      redirect_to done_path
    else
      @task.destroy
      flash[:success] = "タスクは正常に削除されました"
      redirect_to tasks_url
    end
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content,:status,:limit, :user)
  end
  
  def set_task
    @task = Task.find(params[:id])
  end
end
