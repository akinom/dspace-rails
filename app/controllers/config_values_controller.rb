class ConfigValuesController < ApplicationController
  before_action :set_config_type, :only => [:new,:create, :index]
  before_action :set_config_value, :except => [:new,:create, :index]

  # GET /config_values
  # GET /config_values.json
  def index
    @c_config_values = ConfigValue.all
  end

  # GET /config_values/1
  # GET /config_values/1.json
  def show
  end

  # GET /config_values/new
  def new
    @c_config_value = ConfigValue.new(:config_type => @c_config_type)
  end

  # GET /config_values/1/edit
  def edit
  end

  # POST /config_values
  # POST /config_values.json
  def create
    @c_config_value = ConfigValue.new(config_value_params)
    if @c_config_value.save
      redirect_to config_type_path(@c_config_type), notice: 'Config value was successfully created.'
    else
      redirect_to config_type_path(@c_config_type)
    end
  end

  # PATCH/PUT /config_values/1
  # PATCH/PUT /config_values/1.json
  def update
    if @c_config_value.update(config_value_params)
      redirect_to config_type_path(@c_config_type), notice: 'Config value was successfully updated.'
    else
      redirect_to edit_config_value_path(@c_config_value, notice: "Could not update")
    end
  end

  # DELETE /config_values/1
  # DELETE /config_values/1.json
  def destroy
    @c_config_value.destroy
    redirect_to config_type_path(@c_config_type)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_config_type
    @c_config_type = ConfigType.find(params['config_type_id']) if params['config_type_id']
  end

  def set_config_value
    @c_config_value = ConfigValue.find(params['id'])
    @c_config_type = @c_config_value.config_type
  end

  # Never trust parameters from the scary internet, only allow the white list through.
    def config_value_params
      cfp =  params['config_value']
      cfp['scope'] = nil if cfp['scope'] == ""
      cfp['value'] = cfp['value'].strip if cfp['value']
      params.require(:config_value).permit(:scope, :value, :config_type_id)
    end
end
