RSpec.describe ActionController do
  describe "Test Controller" do 
    class TestController < ActionController::Base
      before_action :callback, only: [:show]
      before_action :second_callback, except: [:show, :redirect]
  
      def index
        response << "index"
      end
  
      def show
        response << "show"
      end
  
      def redirect 
        redirect_to "/"
      end
  
      private 
  
      def callback
        response << "callback"
      end
  
      def second_callback
        response << "second_callback"
      end
    end
  
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

    
    describe "#redirect" do
      class Response
        attr_accessor :status, :location, :body
      end
    
      it "works" do 
        controller = TestController.new
        controller.response = Response.new
        controller.process(:redirect)

        expect(controller.response.status).to eq(302)
        expect(controller.response.location).to eq("/")
        expect(controller.response.body).to eq(["You are being redirected"])
      end
    end
  end

  describe "Real Controller" do
    class Request
      def params
        { 'id': 1 }
      end
    end

    it "works" do
      controller = PostsController.new 
      controller.request = Request.new
      controller.process(:show)

      expect(controller.instance_variable_get(:@post)).to be_instance_of(Post)
    end
  end
end
