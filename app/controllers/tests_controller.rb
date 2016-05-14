class TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy]

  # GET /tests
  # GET /tests.json
  def index
    search_string = "%#{params[:q]}%"
    params[:page_size] = 10 if params[:page_size].nil?
    @tests = current_user.tests.where("name like ? OR description like ?", search_string,search_string).page(params[:page]).per(params[:page_size])

    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /tests/1
  # GET /tests/1.json
  def show
  end

  # GET /tests/new
  def new
    @test = Test.new
    @answers =  parse_json(nil)
    @questions = parse_json(nil)
  end

  # GET /tests/1/edit
  def edit
  end

  # POST /tests
  # POST /tests.json
  def create
    return unless current_user.type == "Teacher"
    @test = Test.new(test_params)
    @test.teacher_id = current_user.id

    @test.questions = params["questions"].to_json
    @test.answers = params["answers"].to_json

    @answers =  parse_json(@test.answers)
    @questions = parse_json(@test.questions)
    respond_to do |format|
      if @test.save
        format.html { redirect_to @test, notice: 'Bài kiểm tra đã được khởi tạo.' }
        format.json { render :show, status: :created, location: @test }
      else
        format.html { render :new }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tests/1
  # PATCH/PUT /tests/1.json
  def update
    return unless current_user.id == @test.teacher_id
    @test.update_attributes(:questions => params["questions"].to_json, :answers => params["answers"].to_json)
    @answers =  parse_json(@test.answers)
    @questions = parse_json(@test.questions)
    respond_to do |format|
      if @test.update(test_params)
        format.html { redirect_to @test, notice: 'Bài kiểm tra đã được cập nhật.' }
        format.json { render :show, status: :ok, location: @test }
      else
        format.html { render :edit }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    @test.destroy
    respond_to do |format|
      format.html { redirect_to tests_url, notice: 'Bài kiểm tra đã bị hủy.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      @test = Test.find(params[:id])

      @answers =  parse_json(@test.answers)
      @questions = parse_json(@test.questions)

    end

    def parse_json(json)
      return JSON.parse("{ }") if json.nil?
      begin
        json_result = JSON.parse(json)
        return json_result
      rescue JSON::ParserError => e
        JSON.parse("{ }")
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_params
      params.require(:test).permit(:name, :description, :questions, :answers, :time)
    end
end
