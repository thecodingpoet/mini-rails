RSpec.describe ActionController do
  class TestController < ActionController::Base
    before_action :callback, only: [:show]
    before_action :second_callback, except: [:show]

    def index
      response << "index"
    end

    def show
      response << "show"
    end

    private 

    def callback
      response << "callback"
    end

    def second_callback
      response << "second_callback"
    end
  end

  describe TestController do 
    describe "#index" do
      it "works" do
        controller = TestController.new
        controller.response = []
        controller.process(:index)
  
        expect(controller.response).to include("index")
      end
    end
  
    describe "callback" do
      it "works" do
        controller = TestController.new
        controller.response = []
        controller.process(:show)
  
        expect(controller.response).to eq(["callback", "show"])
  
        controller.process(:index)
        expect(controller.response).to eq(["callback", "show", "second_callback", "index"])
      end
    end
  end

  describe PostsController do
    class Request
      def params
        { 'id': 1 }
      end
    end

    it "works" do
      controller = PostsController.new 
      controller.request = Request.new
      controller.process(:show)
    end
  end
end
