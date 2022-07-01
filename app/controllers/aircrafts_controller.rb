class AircraftsController < ApplicationController
  $aircrafts = Array.new

  # GET /aircrafts
  def index
  end

  # GET /aircrafts/new
  def new
    @aircraft = Aircraft.new
  end

  # GET /aircrafts/show
  def show
  end

  # POST /aircrafts
  def enqueue
    @aircraft = Aircraft.new(aircraft_params)
    if @aircraft.valid?
      $aircrafts.each do |aircraft|
        # check aircraft_name duplicate items
        if @aircraft.name == aircraft.name
          return redirect_to aircrafts_new_url, notice: "'#{aircraft.name}' aircraft is already exists."
        end
      end
      $aircrafts.push(@aircraft)
      redirect_to aircrafts_show_url, notice: "'#{@aircraft.name}' aircraft was enqueued."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /aircrafts/dequeue
  def dequeue
    dequeue_aircraft = nil

    $aircrafts.each_with_index do |current_aircraft, index|
      next_aircraft = $aircrafts[index+1]
      if next_aircraft.nil?
        dequeue_aircraft = $aircrafts.delete(current_aircraft)
        break
      else
        # Dequeue the earlier enqueued aircraft take precedence over later enqueued aircraft of the same type and size
        if current_aircraft.type == next_aircraft.type && current_aircraft.size == next_aircraft.size
          dequeue_aircraft = $aircrafts.delete(current_aircraft)
          break
        # Dequeue the passenger aircraft take precedence over Cargo aircraft
        elsif current_aircraft.type != next_aircraft.type
          if current_aircraft.type == "Passenger" && next_aircraft.type == "Cargo"
            dequeue_aircraft = $aircrafts.delete(current_aircraft)
            break
          elsif current_aircraft.type == "Cargo" && next_aircraft.type == "Passenger"
            dequeue_aircraft = $aircrafts.delete(next_aircraft)
            break
          end
        # Dequeue the large aircraft take precedence over Small aircraft of the same type
        elsif current_aircraft.type == next_aircraft.type
          if current_aircraft.size == "Large" && next_aircraft.size == "Small"
            dequeue_aircraft = $aircrafts.delete(current_aircraft)
            break
          elsif current_aircraft.size == "Small" && next_aircraft.size == "Large"
            dequeue_aircraft = $aircrafts.delete(next_aircraft)
            break
          end
        end
      end
    end

    if dequeue_aircraft.nil?
      redirect_to aircrafts_show_url, notice: "No aircraft was dequeued."
    else
      redirect_to aircrafts_show_url, notice: "'#{dequeue_aircraft.name}' aircraft was dequeued."
    end
  end

  private

  def aircraft_params
    params.require(:aircraft).permit(:name, :type, :size)
  end
end
