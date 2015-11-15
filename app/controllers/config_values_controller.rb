class ConfigValuesController < ApplicationController
  before_action :set_config_type, :only => [:new,:create, :index]
  before_action :set_config_value, :except => [:new,:create, :index]

  # GET /config_values
  # GET /config_values.json
  def index
    @config_values = ConfigValue.all
  end

  # GET /config_values/1
  # GET /config_values/1.json
  def show
  end

  # GET /config_values/new
  def new
    @config_value = ConfigValue.new(:config_type => @config_type)
  end

  # GET /config_values/1/edit
  def edit
  end

  # POST /config_values
  # POST /config_values.json
  def create
    @config_value = ConfigValue.new(config_value_params)
    if @config_value.save
      redirect_to config_type_path(@config_type), notice: 'Config value was successfully created.'
    else
      redirect_to config_type_path(@config_type)
    end
  end

  # PATCH/PUT /config_values/1
  # PATCH/PUT /config_values/1.json
  def update
    if @config_value.update(config_value_params)
      redirect_to config_type_path(@config_type), notice: 'Config value was successfully updated.'
    else
      redirect_to config_type_path(@config_type)
    end
  end

  # DELETE /config_values/1
  # DELETE /config_values/1.json
  def destroy
    @config_value.destroy
    redirect_to config_type_path(@config_type)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_config_type
    @config_type = ConfigType.find(params['config_type_id']) if params['config_type_id']
  end

  def set_config_value
    @config_value = ConfigValue.find(params['id'])
    @config_type = @config_value.config_type
  end

  # Never trust parameters from the scary internet, only allow the white list through.
    def config_value_params
      params.require(:config_value).permit(:scope, :yaml_value, :value, :config_type_id)
    end
end
