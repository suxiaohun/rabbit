class Mdm::CompaniesController < ApplicationController
  before_action :set_mdm_company, only: [:show, :edit, :update, :destroy]

  # GET /mdm/companies
  # GET /mdm/companies.json
  def index
    @mdm_companies = Mdm::Company.all.page params[:page]
  end

  # GET /mdm/companies/1
  # GET /mdm/companies/1.json
  def show
  end

  # GET /mdm/companies/new
  def new
    @mdm_company = Mdm::Company.new
  end

  # GET /mdm/companies/1/edit
  def edit
  end

  # POST /mdm/companies
  # POST /mdm/companies.json
  def create
    @mdm_company = Mdm::Company.new(mdm_company_params)

    respond_to do |format|
      if @mdm_company.save
        format.html { redirect_to ({:action=>'index'}), notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @mdm_company }
      else
        format.html { render :new }
        format.json { render json: @mdm_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mdm/companies/1
  # PATCH/PUT /mdm/companies/1.json
  def update
    respond_to do |format|
      if @mdm_company.update(mdm_company_params)
        format.html { redirect_to ({:action=>'index'}), notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @mdm_company }
      else
        format.html { render :edit }
        format.json { render json: @mdm_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mdm/companies/1
  # DELETE /mdm/companies/1.json
  def destroy
    @mdm_company.destroy
    respond_to do |format|
      format.html { redirect_to ({:action=>'index'}), notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mdm_company
      @mdm_company = Mdm::Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mdm_company_params
      params.require(:mdm_company).permit(:code, :name, :corporation, :phone, :email)
    end
end
