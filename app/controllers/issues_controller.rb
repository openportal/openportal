class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  # GET /issues
  # GET /issues.json
  def index
    @issues = Issue.all
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
  end

  # GET /issues/new
  def new
    @issue = Issue.new
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(issue_params)

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render action: 'show', status: :created, location: @issue }
      else
        format.html { render action: 'new' }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url }
      format.json { head :no_content }
    end
  end

  def github_pull_info

    #This is for rails repository
    @issues_from_site = JSON.parse(RestClient.get("https://api.github.com/repos/rails/rails/issues?client_id=#{ENV["CLIENT_ID"]}&client_secret=#{ENV["CLIENT_SECRET"]}"))
    
    @events = JSON.parse(RestClient.get("https://api.github.com/repos/rhintz42/scpd-scraper/events?client_id=#{ENV["CLIENT_ID"]}&client_secret=#{ENV["CLIENT_SECRET"]}"))
    
    @latest_repository = JSON.parse(RestClient.get("https://api.github.com/repos/rhintz42/scpd-scraper/git/refs/heads/master?client_id=#{ENV["CLIENT_ID"]}&client_secret=#{ENV["CLIENT_SECRET"]}"))
    
    @issues = []

    @issues_from_site.each do |i|
      issue = Issue.new
      issue[:issue_id] = i["number"]
      issue[:status] = i["state"]
      issue[:description] = i["title"]
      issue[:url] = i["url"]
      issue[:organization_id] =  1 #params["organization_id"]

      #take out
      issue.level = Random.rand(0...5)
      
   
      issue.save

      @issues << issue
    end

    respond_to do |format|
      format.html
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_params
      params.require(:issue).permit(:organization_id, :name, :url, :issue_id, :status, :level, :description)
    end
end
