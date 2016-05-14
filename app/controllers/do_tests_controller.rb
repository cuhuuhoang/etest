class DoTestsController < ApplicationController
  def index
    redirect_to test_url if current_user.type == "Teacher"
    search_string = "%#{params[:q]}%"
    params[:page_size] = 10 if params[:page_size].nil?
    @tests = current_user.available_tests.includes(:teacher).where("tests.name like ? OR tests.description like ?", search_string,search_string).page(params[:page]).per(params[:page_size])

    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    @test = Test.find_by(id: params[:test_id])
    if !@test.nil?
      @do_test = DoTest.find_by(test_id: params[:test_id], student_id: current_user.id)
      if @do_test.nil?
        @do_test = current_user.do_tests.build
        @do_test.test_id = params[:test_id];
        @do_test.save!
      end
      redirect_to edit_do_test_path(@do_test)
    end
  end

  def edit
    @do_test = DoTest.find_by(id: params[:id])
    if @do_test.nil?
      redirect_to index
    end
    @test = @do_test.test
    @answers =  parse_json(@test.answers)
    @questions = parse_json(@test.questions)
  end

  def update

  end

  private
    def parse_json(json)
      return JSON.parse("{ }") if json.nil?
      begin
        json_result = JSON.parse(json)
        return json_result
      rescue JSON::ParserError => e
        JSON.parse("{ }")
      end
    end
end
