require 'spec_helper'

describe BooksController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET index" do
    context "listing books" do
      it "assigns no books" do
        get :index
        assigns(:books).should == []
      end

      it "lists a created book" do
        book = Book.new(isbn: "9781934356548", quantity: 3)
        Book.should_receive(:all).and_return([book])
        get :index
        assigns(:books).should == [book]
      end

      it "assigns books with their title, authors and images" do
        book = Book.new(isbn: "9780137081073", quantity: 3)
        Book.stub(:all).and_return([book])
        get :index
        google_books = assigns(:google_books)
        google_books.first.title.should == "Clean Code: A Handbook of Agile Software Craftsmanship"
      end
    end
  end

  describe "POST create" do

    let (:book) { mock_model(Book).as_null_object}

    before do
      Book.stub(:new).and_return(book)
      @attrs = { :title => "Rails Tutorial",
                 :author => "Michael Hartl",
                 :isbn => "1234567890",
                 :quantity =>3}
    end

    it "creates a new book" do
      post :create, {:book => @attrs}
      book.count.should_not == 0
    end

    it "saves a new book" do
      book.should_receive(:save)
      post :create
    end

    context "when the book saves successfully" do
      it "sets a flash[:success] message" do
        post :create
        flash[:success].should eq("The book was saved successfully")
      end

      it "redirects to Book index" do
        post :create
        response.should redirect_to(:action => "index")
      end
    end


    context "retrieve book information using isbn Google API" do
      book = GoogleBooks.search('9781934356548').first

      it "has the correct title" do
        book.title.should == 'Agile Web Development With Rails'
      end

      it "has the correct author" do
        book.authors.should == "Sam Ruby, Dave Thomas, David Heinemeier Hansson, Leon Breedt"
      end
    end

    context "when the book fails to save" do
      before do
        book.stub(:save).and_return(false)
      end
      it "assigns @book" do
        post :create
        assigns[:book].should eq(book)
      end

      it "renders the new template" do
        post :create
        response.should render_template("new")
      end

      it "sets a flash[:error] message" do
        post :create
        flash[:error].should eq("Please fill in the fields correctly")
      end
    end
  end
end
