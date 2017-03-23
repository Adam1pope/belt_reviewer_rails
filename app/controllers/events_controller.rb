class EventsController < ApplicationController
  def index
    @user = User.find(session[:id])
    @event = Event.where(state: @user.state)
    @other_event = Event.where.not(state: @user.state)
  end

  def show
    @event = Event.find(params[:id])
    @comment = Comment.where(event_id:@event.id)
  end

  def create
    @event = Event.new(events_params)
    @event.host_id = session[:id]
    if @event.save
      redirect_to '/events'
    else
      flash[:errors] = @event.errors.full_messages
      redirect_to :back
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(events_params)
      redirect_to '/events'
    else
      flash[:errors] = @event.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to :back
  end

  private
    def events_params
      params.require(:event).permit(:name, :date, :city, :state)
    end
end
