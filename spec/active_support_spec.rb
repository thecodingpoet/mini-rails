require "active_record"
require "active_support"

RSpec.describe ActiveSupport do
  describe ".search_for_file" do 
    before(:each) do
      ActiveSupport::Dependencies.autoload_paths = Dir["#{__dir__}/muffin_blog/app/*"]
    end

    it "works" do 
      file = ActiveSupport::Dependencies.search_for_file("application_controller")
      expect(file).to eq("#{__dir__}/muffin_blog/app/controllers/application_controller.rb")

      file = ActiveSupport::Dependencies.search_for_file("unknown")
      expect(file).to eq(nil)
    end
  end

  describe "#underscore" do 
    it "works" do
      expect(:Post.to_s.underscore).to eq("post")
      expect(:ApplicationController.to_s.underscore).to eq("application_controller")
    end
  end
end
