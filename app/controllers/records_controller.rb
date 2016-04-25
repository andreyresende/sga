class RecordsController < ApplicationController

  respond_to :html, :js
  before_action :set_record, only: [:show, 
                                    :edit, 
                                    :update, 
                                    :destroy, 
                                    :download,
                                    :edit_users,
                                    :edit_discussions]

  # GET /records
  def index
  end

  # POST /select_sector_records
  def select_sector_records
    @sector = Sector.find(params[:sector][:id])
    session[:sector_id] = @sector.id
  end

  # GET /records/1/download
  def download
    send_file view_context.download_record(@record)
  end

  # GET /records/1
  # GET /records/1.json
  def show
  end

  # GET /records/new
  def new
    @record = Record.new(sector_id: params[:sector_id])
  end

  # GET /records/1/edit
  def edit
  end

  def edit_users
  end

  def edit_discussions
  end

  # POST /records
  # POST /records.json
  def create
    @sector = Sector.find(record_params[:sector_id])
    @record = Record.create(record_params)
    @records = @sector.records
  end

  # PATCH/PUT /records/1
  # PATCH/PUT /records/1.json
  def update
    unless params[:record].nil?
      @record.update(record_params)
      @record.update_attribute(:updated_at, Time.now)
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @sector = @record.sector
    @record.destroy
    @records = @sector.records
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = Record.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def record_params
      params.require(:record).permit(:date, 
             :sector_id,
             :number,
             user_ids: [],
             discussions_attributes: [:id, :name, :content, :_destroy])
    end

end
