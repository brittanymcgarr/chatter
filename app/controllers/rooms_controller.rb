class RoomsController < ApplicationController
  # Loads:
  # @rooms = all rooms
  # @room = current room when applicable
  before_action :load_entities

  # Landing page for all listed rooms
  def index
    @rooms = Room.all
  end

  # New room generation
  def new
    @room = Room.new
  end

  # Create and save the new room
  def create
    @room = Room.new permitted_parameters

    if @room.save
      flash[:success] = "Room: #{@room.name} was created successfully"
      redirect_to rooms_path
    else
      render :new
    end
  end

  # Edit the room selected
  # (empty for now)
  def edit

  end

  # Update the room as directed
  def update
    if @room.update_attributes(permitted_parameters)
      flash[:success] = "Room: #{@room.name} was updated successfully."
      redirect_to rooms_path
    else
      render :new
    end
  end

  # Display the current room
  def show
    @room_message = RoomMessage.new room: @room
    @room_messages = @room.room_messages.includes(:user)
  end

  protected
  # Restrict loading to protected and callable only within app
  def load_entities
    @rooms = Room.all

    if params[:id]
      @room = Room.find(params[:id])
    end
  end

  # Define permitted parameters to accept on edits
  def permitted_parameters
    params.require(:room).permit(:name)
  end
end
