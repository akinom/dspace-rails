class ConfigTypesController < ApplicationController
  before_action :set_config_type, only: [:show, :edit, :update, :destroy]

  # GET /config_types
  # GET /config_types.json
  def index
    @config_types = ConfigType.all
  end

  # GET /config_types/1
  # GET /config_types/1.json
  def show
  end

  # GET /config_types/new
  def new
    @config_type = ConfigType.new
  end

  # GET /config_types/1/edit
  def edit
  end

  # POST /config_types
  # POST /config_types.json
  def create
    @config_type = ConfigType.new(config_type_params)

    respond_to do |format|
      if @config_type.save
        format.html { redirect_to @config_type, notice: 'Config type was successfully created.' }
        format.json { render :show, status: :created, location: @config_type }
      else
        format.html { render :new }
        format.json { render json: @config_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /config_types/1
  # PATCH/PUT /config_types/1.json
  def update
    respond_to do |format|
      if @config_type.update(config_type_params)
        format.html { redirect_to @config_type, notice: 'Config type was successfully updated.' }
        format.json { render :show, status: :ok, location: @config_type }
      else
        format.html { render :edit }
        format.json { render json: @config_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /config_types/1
  # DELETE /config_types/1.json
  def destroy
    @config_type.destroy
    respond_to do |format|
      format.html { redirect_to config_types_url, notice: 'Config type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_config_type
      @config_type = ConfigType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def config_type_params
      params.require(:config_type).permit(:name, :klass)
    end
end
