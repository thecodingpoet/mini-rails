require "active_record"
require "muffin_blog/app/models/application_record"
require "muffin_blog/app/models/post"

RSpec.describe ActiveRecord do
  before(:each) do 
    Post.establish_connection(database: "#{__dir__}/muffin_blog/db/development.sqlite3")
  end 

  it "executes sql" do
    rows = Post.connection.execute("SELECT * FROM posts")
    expect(rows).to be_kind_of(Array)
    row = rows.first
    expect(row).to be_kind_of(Hash)
    expect(row.keys).to eq([:id, :title, :body, :created_at, :updated_at])
  end

  it "initializes attributes" do
    post = Post.new(id: 1, title: "My first post")

    expect(post.id).to eq(1)
    expect(post.title).to eq("My first post")
  end

  describe ".find" do 
    it "retreives a record" do 
      post = Post.find(1)
      expect(post).to be_instance_of(Post)
      expect(post.id).to eq(1)
    end
  end

  describe ".all" do 
    it "retreives all records" do 
      posts = Post.all 
      expect(posts).to be_instance_of(ActiveRecord::Relation)
      expect(posts.first.id).to eq(1)
    end
  end

  describe '.where' do 
    it 'filters records' do
      relation = Post.where("id = 2").where("title IS NOT NULL")
      expect(relation.to_sql).to eq("SELECT * FROM posts WHERE id = 2 AND title IS NOT NULL")

      post = relation.first 
      expect(post.id).to eq(2)
    end
  end
end
